using System.Collections.Generic;
using System.Linq;
using VTrack.Api.Model.Devices;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers;

public class DeviceTypesModelMapper
{
    public static DeviceTypesModel Map(IEnumerable<DeviceType> deviceTypes)
    {
        return new DeviceTypesModel
        {
            Items = deviceTypes.Select(DeviceTypeModelMapper.Map)
                .OrderBy(x => x.DisplayName)
                .ToList()
        };
    }
}