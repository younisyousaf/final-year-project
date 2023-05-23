using System.Linq;
using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Assets;

[Service(typeof(IAssetAuthorizationService))]
public class AssetAuthorizationService : IAssetAuthorizationService
{
    private readonly ICurrentUserAccessor currentUserAccessor;

    public AssetAuthorizationService(ICurrentUserAccessor currentUserAccessor)
    {
        this.currentUserAccessor = currentUserAccessor;
    }

    public async Task<bool> CurrentUserHasRole(UserDocument userDocument, AssetRoleType assetRoleType, string assetId)
    {
        UserDocument currentUser = await currentUserAccessor.GetCurrentUser();

        AssetRoleType[] validRoles = assetRoleType == AssetRoleType.Viewer
            ? new[] { AssetRoleType.Owner, AssetRoleType.Viewer }
            : new[] { assetRoleType };

        bool hasRole =
            (currentUser.AssetRoles?.Any(x => x.AssetId == ObjectId.Parse(assetId) && validRoles.Contains(x.Role)))
            .GetValueOrDefault();

        return hasRole;
    }
}