using System.Collections.Generic;
using System.Linq;
using MongoDB.Bson;
using VTrack.Api.Model.Devices;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers.Devices;

public class DeviceListModelMapper
{
    public static DevicesModel Map(IEnumerable<DeviceDocument> devices, IEnumerable<DeviceType> deviceTypes,
        Dictionary<ObjectId, int> counts,
        AssetDocument assetDocument)
    {
        return new DevicesModel
        {
            Items = devices.Select(x =>
                DeviceModelMapper.Map(x, deviceTypes.First(d => d.Id == x.DeviceTypeId.ToString()), assetDocument,
                    counts.TryGetValue(x.Id, out int value) ? value : 0)).ToList()
        };
    }
}