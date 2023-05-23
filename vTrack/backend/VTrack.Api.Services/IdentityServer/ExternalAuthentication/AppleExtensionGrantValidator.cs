using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using IdentityServer4.Models;
using IdentityServer4.Validation;
using VTrack.Api.Services.IdentityServer.Model;
using VTrack.Api.Services.Mappers;
using VTrack.Common.Settings;
using VTrack.DataAccess.Services.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.IdentityServer.ExternalAuthentication;

[Service(typeof(IExtensionGrantValidator))]
public class AppleExtensionGrantValidator : IExtensionGrantValidator
{
    private readonly IUserDataService userDataService;
    private readonly IExternalLoginHandler externalLoginHandler;
    private readonly ISettingService settingService;

    public AppleExtensionGrantValidator(IUserDataService userDataService, IExternalLoginHandler externalLoginHandler,
        ISettingService settingService)
    {
        this.userDataService = userDataService;
        this.externalLoginHandler = externalLoginHandler;
        this.settingService = settingService;
    }

    public string GrantType => "apple";

    public async Task ValidateAsync(ExtensionGrantValidationContext context)
    {
        AppleAuthenticationSettings settings = await settingService.Get<AppleAuthenticationSettings>();

        string? userId = await externalLoginHandler.HandleToken(new HandleTokenInput(settings)
        {
            Token = context.Request.Raw["code"],
            IdClaimType = ClaimTypes.NameIdentifier,
            EmailClaimType = ClaimTypes.Email,
            GetUser = userDataService.GetByAppleId,
            Map = (email, id) => UserDocumentMapper.MapWithExternalId(email, appleId: id),
            ExternalId = user => user.AppleId,
            SetId = userDataService.SetAppleId
        });

        context.Result = !string.IsNullOrEmpty(userId)
            ? new GrantValidationResult(userId, "apple", new List<Claim>())
            : new GrantValidationResult(TokenRequestErrors.InvalidGrant, "Invalid token.");
    }
}