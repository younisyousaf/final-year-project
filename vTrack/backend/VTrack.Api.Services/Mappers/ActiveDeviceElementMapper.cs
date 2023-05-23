using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers;

public static class ActiveDeviceElementMapper
{
    public static AssetDeviceElement Map(DeviceDocument deviceDocument, DeviceType deviceType)
    {
        return new AssetDeviceElement
        {
            Id = deviceDocument.Id,
            ProtocolPort = deviceType.Protocol.Port,
            DeviceTypeId = deviceDocument.DeviceTypeId,
            SerialNumber = deviceDocument.SerialNumber
        };
    }
}