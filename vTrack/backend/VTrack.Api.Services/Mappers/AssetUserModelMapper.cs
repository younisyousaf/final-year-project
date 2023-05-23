using VTrack.Api.Model.Assets;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Mappers;

public static class AssetUserModelMapper
{
    public static AssetUserModel Map(AssetUserRoleElement assetUserRole, UserDocument user)
    {
        return new AssetUserModel
        {
            UserId = user.Id.ToString(),
            Email = user.Email,
            Role = assetUserRole.Role.ToString()
        };
    }
}