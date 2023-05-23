using System.Threading.Tasks;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Assets;

public interface IAssetAuthorizationService
{
    Task<bool> CurrentUserHasRole(UserDocument userDocument, AssetRoleType assetRoleType, string assetId);
}