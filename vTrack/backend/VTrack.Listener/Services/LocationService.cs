using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Locations;
using VTrack.DataAccess.Services.Assets;
using VTrack.DataAccess.Services.Devices;
using VTrack.DataAccess.Services.Locations;
using VTrack.Library.DI;
using VTrack.Listener.Mappers;
using Location = VTrack.Listener.Models.Location;

namespace VTrack.Listener.Services;

[Service(typeof(ILocationService))]
public class LocationService : ILocationService
{
    private readonly ILocationDataService locationDataService;
    private readonly IDeviceDataService deviceDataService;
    private readonly IAssetDataService assetDataService;

    public LocationService(ILocationDataService locationDataService, IDeviceDataService deviceDataService,
        IAssetDataService assetDataService)
    {
        this.locationDataService = locationDataService;
        this.deviceDataService = deviceDataService;
        this.assetDataService = assetDataService;
    }

    public async Task AddRange(List<Location> locations, ObjectId connectionMessageId)
    {
        if (locations.Any())
        {
            string deviceId = locations.First().Device.IMEI;

            AssetDocument asset = await deviceDataService.GetActiveDeviceByDeviceId(deviceId);

            if (asset != null)
            {
                List<LocationDocument> mapped =
                    locations.Select(x => LocationDocumentMapper.Map(x, asset, connectionMessageId))
                        .ToList();

                await locationDataService.AddRange(mapped);
                
                LocationDocument latestLocation = mapped.OrderByDescending(x => x.DateTime).First();

                if (asset.Location == null || latestLocation.DateTime > asset.Location.DateTime)
                {
                    await assetDataService.UpdateLocation(asset.Id, latestLocation);
                }
            }
        }
    }
}