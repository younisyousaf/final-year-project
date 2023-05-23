using System.Collections.Generic;
using System.Linq;
using VTrack.Api.Model.Assets;
using VTrack.Core.Model;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers.Assets;

public static class AssetListMapper
{
    public static AssetsModel Map(IEnumerable<AssetDocument> source, UnitsType unitsType,
        IEnumerable<DeviceType> deviceTypes)
    {
        AssetsModel list = new()
        {
            Items = source
                .Select(x =>
                {
                    DeviceType deviceType = deviceTypes.First(y => y.Id == x.Device.DeviceTypeId.ToString());

                    return AssetModelMapper.Map(x, unitsType, deviceType);
                })
                .ToList()
        };
        return list;
    }
}