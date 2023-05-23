using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Users;

namespace VTrack.Api.Services.User;

public interface ICurrentUserAccessor
{
    ObjectId GetId();
    Task<UserDocument> GetCurrentUser();
}