using System.Collections.Generic;
using System.Linq;
using VTrack.Api.Model.Assets;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Mappers;

public static class AssetUsersModelMapper
{
    public static AssetUserListModel Map(AssetDocument asset, List<UserDocument> users)
    {
        AssetUserListModel list = new()
        {
            Items = asset.UserRoles
                .Select(x =>
                    AssetUserModelMapper.Map(x, users.First(y => x.UserId == y.Id)))
                .ToList()
        };

        return list;
    }
}