using VTrack.Api.Model.Devices;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers.Devices;

internal class DeviceModelMapper
{
    public static DeviceModel Map(DeviceDocument deviceDocument, DeviceType deviceType, AssetDocument assetDocument,
        int? locationCount = null)
    {
        return new DeviceModel
        {
            Id = deviceDocument.Id.ToString(),
            SerialNumber = deviceDocument.SerialNumber,
            DeviceType = DeviceTypeModelMapper.Map(deviceType),
            Active = assetDocument.Device.Id == deviceDocument.Id,
            Locations = locationCount
        };
    }

    public static DeviceModel Map(AssetDocument asset, DeviceType deviceType)
    {
        return new DeviceModel
        {
            Id = asset.Device.Id.ToString(),
            SerialNumber = asset.Device.SerialNumber,
            DeviceType = DeviceTypeModelMapper.Map(deviceType),
            Active = true
        };
    }
}