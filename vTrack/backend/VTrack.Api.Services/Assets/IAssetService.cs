using System.Threading.Tasks;
using VTrack.Api.Model.Assets;
using VTrack.DataAccess.Model.Assets;

namespace VTrack.Api.Services.Assets;

public interface IAssetService
{
    Task<AssetModel> GetById(string assetId);
    Task<AssetsModel> GetAssets();
    Task Update(string assetId, UpdateAssetModel model);
    Task Delete(string assetId);
    Task<AssetModel> Add(AddAssetModel model);
    Task<AssetUserListModel> GetAssetUsers(string assetId);
    Task AddUserToAsset(string assetId, AddUserToAssetModel model);
    Task RemoveUserFromAsset(string assetId, string userId);
}