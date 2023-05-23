using MongoDB.Bson;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Assets;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Roles;

[Service(typeof(IRoleService))]
public class RoleService : IRoleService
{
    private readonly ICurrentUserAccessor currentUserAccessor;

    public RoleService(ICurrentUserAccessor currentUserAccessor)
    {
        this.currentUserAccessor = currentUserAccessor;
    }

    public void CheckRole(AssetDocument asset, AssetRoleType assetRoleType)
    {
        ObjectId currentUserId = currentUserAccessor.GetId();
            
        // if (asset.UserRoles.All(x => x.UserId != currentUserId))
        // {
        //     throw new ApiException(HttpStatusCode.Forbidden);
        // }
    }
}