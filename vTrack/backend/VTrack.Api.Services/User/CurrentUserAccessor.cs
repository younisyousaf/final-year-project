using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using MongoDB.Bson;
using VTrack.Api.Services.Exceptions;
using VTrack.Api.Services.IdentityServer;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.User;

[Service(typeof(ICurrentUserAccessor))]
public class CurrentUserAccessor : ICurrentUserAccessor
{
    private readonly IHttpContextAccessor httpContextAccessor;
    private readonly IUserDataService userDataService;
    private UserDocument? currentUser;

    public CurrentUserAccessor(IHttpContextAccessor httpContextAccessor, IUserDataService userDataService)
    {
        this.httpContextAccessor = httpContextAccessor;
        this.userDataService = userDataService;
    }

    public ObjectId GetId()
    {
        string? id = httpContextAccessor.HttpContext?.User.GetId();

        if (string.IsNullOrEmpty(id))
        {
            throw new ApiException(HttpStatusCode.Unauthorized);
        }
            
        ObjectId currentUserId = ObjectId.Parse(id);

        return currentUserId;
    }

    public async Task<UserDocument> GetCurrentUser()
    {
        if (currentUser == null)
        {
            ObjectId id = GetId();

            currentUser = await userDataService.GetByObjectId(id);
        }

        return currentUser;
    }
}