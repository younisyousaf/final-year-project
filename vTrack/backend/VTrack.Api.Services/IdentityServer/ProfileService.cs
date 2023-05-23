using System.Security.Claims;
using System.Threading.Tasks;
using IdentityModel;
using IdentityServer4.Models;
using IdentityServer4.Services;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.IdentityServer;

[Service(typeof(IProfileService))]
public class ProfileService : IProfileService
{
    private readonly IUserDataService userDataService;

    public ProfileService(IUserDataService userDataService)
    {
        this.userDataService = userDataService;
    }

    public async Task GetProfileDataAsync(ProfileDataRequestContext context)
    {
        string? userId = context.Subject.GetId();
            
        UserDocument user = await userDataService.GetByObjectId(ObjectId.Parse(userId));

        context.IssuedClaims.Add(new Claim(JwtClaimTypes.Email, user.Email));
    }

    public Task IsActiveAsync(IsActiveContext context)
    {
        return Task.CompletedTask;
    }
}