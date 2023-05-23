using VTrack.DataAccess.Model.Assets;

namespace VTrack.Api.Services.Roles;

public interface IRoleService
{
    void CheckRole(AssetDocument asset, AssetRoleType assetRoleType);
}