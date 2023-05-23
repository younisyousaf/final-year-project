using System.Threading.Tasks;
using VTrack.Api.Model.User;

namespace VTrack.Api.Services.User;

public interface IUserAccessService
{
    Task ForgotPassword(ForgotPasswordRequest model);
    Task ChangePassword(ChangePasswordRequest model);
    Task ResetPassword(ResetPasswordRequest model);
}