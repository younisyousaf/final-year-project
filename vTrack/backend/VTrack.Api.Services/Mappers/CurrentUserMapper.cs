using VTrack.Api.Model.User;
using VTrack.Core.Model;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.Mappers;

internal static class CurrentUserMapper
{
    public static CurrentUserModel Map(UserDocument entity)
    {
        return new CurrentUserModel
        {
            Id = entity.Id.ToString(),
            Email = entity.Email,
            Units = (UnitsType)entity.UnitsType
        };
    }
}