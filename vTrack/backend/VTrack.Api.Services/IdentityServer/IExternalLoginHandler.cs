using System.Threading.Tasks;

namespace VTrack.Api.Services.IdentityServer;

public interface IExternalLoginHandler
{
    Task<string?> HandleToken(HandleTokenInput input);
}