using VTrack.Api.Model.Devices;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers;

public class DeviceTypeModelMapper
{
    public static DeviceTypeModel Map(DeviceType source)
    {
        return new DeviceTypeModel
        {
            Id = source.Id,
            Manufacturer = source.Manufacturer,
            Model = source.Type,
            Protocol = ProtocolModelMapper.Map(source.Protocol)
        };
    }
}