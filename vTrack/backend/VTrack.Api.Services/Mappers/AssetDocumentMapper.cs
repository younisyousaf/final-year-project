using System.Collections.Generic;
using MongoDB.Bson;
using VTrack.Api.Model.Assets;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Mappers;

public static class AssetDocumentMapper
{
    public static AssetDocument Map(AddAssetModel source, UserDocument owner)
    {
        return new AssetDocument
        {
            Id = ObjectId.GenerateNewId(),
            Name = source.Name,
            UserRoles = new List<AssetUserRoleElement>
            {
                UserRoleElementMapper.Map(owner.Id, AssetRoleType.Owner)
            },
            Created = AuditElementMapper.Map(owner.Id)
        };
    }
}