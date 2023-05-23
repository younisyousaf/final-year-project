using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.Api.Model.Devices;
using VTrack.Api.Services.Extensions;
using VTrack.Api.Services.Mappers;
using VTrack.Api.Services.Mappers.Devices;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Devices;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Assets;
using VTrack.DataAccess.Services.Devices;
using VTrack.DataAccess.Services.Locations;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Devices;

[Service(typeof(IDeviceService))]
public class DeviceService : IDeviceService
{
    private readonly IDeviceTypeDataService deviceTypeDataService;
    private readonly IDeviceDataService deviceDataService;
    private readonly IAssetDataService assetDataService;
    private readonly ILocationDataService locationDataService;
    private readonly ICurrentUserAccessor currentUserAccessor;

    public DeviceService(IDeviceTypeDataService deviceTypeDataService, IDeviceDataService deviceDataService,
        IAssetDataService assetDataService, ILocationDataService locationDataService,
        ICurrentUserAccessor currentUserAccessor)
    {
        this.deviceTypeDataService = deviceTypeDataService;
        this.deviceDataService = deviceDataService;
        this.assetDataService = assetDataService;
        this.locationDataService = locationDataService;
        this.currentUserAccessor = currentUserAccessor;
    }

    public Task<bool> SerialNumberIsUsed(string serialNumber, string deviceTypeId, string? excludeAssetId = null)
    {
        DeviceType deviceType = deviceTypeDataService.GetById(deviceTypeId);

        return deviceDataService.SerialNumberIsUsed(serialNumber, deviceType.Protocol.Port, excludeAssetId);
    }

    public async Task<DevicesModel> Get(string assetId)
    {
        AssetDocument asset = await assetDataService.GetById(assetId);
        asset.Throw404IfNull();

        List<DeviceDocument> devices = await deviceDataService.GetDevicesByAssetId(assetId);
        IEnumerable<DeviceType> deviceTypes = deviceTypeDataService.GetDeviceTypes()
            .Where(x => devices.Any(y => y.DeviceTypeId == x.Id))
            .ToList();

        Dictionary<ObjectId, int> locationCount =
            await locationDataService.GetLocationsCountByDeviceIds(devices.Select(x => x.Id));

        return DeviceListModelMapper.Map(devices, deviceTypes, locationCount, asset);
    }

    public async Task Add(string assetId, AddDeviceModel model)
    {
        AssetDocument asset = await assetDataService.GetById(assetId);
        asset.Throw404IfNull();

        if (asset.Device.DeviceTypeId == model.DeviceTypeId &&
            asset.Device.SerialNumber == model.SerialNumber)
        {
            return;
        }

        DeviceType? deviceType = deviceTypeDataService.GetById(model.DeviceTypeId);
        deviceType.ThrowApiExceptionIfNull(HttpStatusCode.BadRequest, "Device type not found.");

        bool deviceUsed =
            await deviceDataService.SerialNumberIsUsed(model.SerialNumber, deviceType.Protocol.Port, assetId);

        deviceUsed.ThrowApiExceptionIfTrue(HttpStatusCode.BadRequest,
            "Device with this serial number is already used.");

        List<DeviceDocument> devices = await deviceDataService.GetDevicesByAssetId(assetId);

        DeviceDocument? existingDevice = devices.FirstOrDefault(x =>
            x.DeviceTypeId == model.DeviceTypeId && x.SerialNumber == model.SerialNumber);

        if (existingDevice != null)
        {
            await assetDataService.SetActiveDevice(asset.Id, existingDevice.Id, existingDevice.SerialNumber,
                existingDevice.DeviceTypeId, deviceType.Protocol.Port);
        }
        else
        {
            UserDocument currentUser = await currentUserAccessor.GetCurrentUser();
            DeviceDocument newDevice = DeviceDocumentMapper.Map(assetId, model, currentUser.Id);

            await deviceDataService.Add(newDevice);

            await assetDataService.SetActiveDevice(asset.Id, newDevice.Id, newDevice.SerialNumber,
                newDevice.DeviceTypeId, deviceType.Protocol.Port);
        }
    }

    public async Task Delete(string id)
    {
        bool isActive = await deviceDataService.IsActive(id);
        isActive.ThrowApiExceptionIfTrue(HttpStatusCode.BadRequest, "Device is active.");
        
        await deviceDataService.Delete(id);
    }
}