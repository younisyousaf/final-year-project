using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using IdentityServer4.Models;
using IdentityServer4.Validation;
using VTrack.Common.Passwords;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.IdentityServer;

[Service(typeof(IResourceOwnerPasswordValidator))]
public class ResourceOwnerPasswordValidator : IResourceOwnerPasswordValidator
{
    private readonly IPasswordHasher passwordHasher;
    private readonly IUserDataService userDataService;

    public ResourceOwnerPasswordValidator(IPasswordHasher passwordHasher, IUserDataService userDataService)
    {
        this.passwordHasher = passwordHasher;
        this.userDataService = userDataService;
    }

    public async Task ValidateAsync(ResourceOwnerPasswordValidationContext context)
    {
        UserDocument? user = await userDataService.GetUserByEmail(context.UserName);

        if (user != null && passwordHasher.CheckPassword(context.Password, user.Password.Hash, user.Password.Salt))
        {
            context.Result = new GrantValidationResult($"{user.Id}",
                "custom",
                new List<Claim>());
        }
        else
        {
            context.Result =
                new GrantValidationResult(TokenRequestErrors.InvalidGrant, "Invalid username or password.");
        }
    }
}