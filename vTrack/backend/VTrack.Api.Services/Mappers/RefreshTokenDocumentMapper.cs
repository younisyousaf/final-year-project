using IdentityServer4.Models;
using MongoDB.Bson;
using VTrack.Api.Services.IdentityServer;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Mappers;

public static class RefreshTokenDocumentMapper
{
    public static RefreshTokenDocument Map(RefreshToken source)
    {
        return new RefreshTokenDocument
        {
            Id = ObjectId.Parse(source.Subject.GetId()),
            CreationTime = source.CreationTime,
            Lifetime = source.Lifetime,
            ConsumedTime = source.ConsumedTime,
            AccessToken = AccessTokenElementMapper.Map(source.AccessToken),
            Version = source.Version
        };
    }
}