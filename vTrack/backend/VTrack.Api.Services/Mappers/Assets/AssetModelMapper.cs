using VTrack.Api.Model.Assets;
using VTrack.Api.Services.Mappers.Devices;
using VTrack.Core.Model;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.Api.Services.Mappers.Assets;

public static class AssetModelMapper
{
    public static AssetModel Map(AssetDocument asset, UnitsType unitsType, DeviceType deviceType)
    {
        return new AssetModel
        {
            Id = asset.Id.ToString(),
            Name = asset.Name,
            Location = asset.Location != null ? LocationMapper.Map(asset.Location, unitsType) : null,
            Device = DeviceModelMapper.Map(asset, deviceType)
        };
    }
}