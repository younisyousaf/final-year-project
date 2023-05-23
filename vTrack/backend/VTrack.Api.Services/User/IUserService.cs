using System.Threading.Tasks;
using VTrack.Api.Model.User;

namespace VTrack.Api.Services.User;

public interface IUserService
{
    Task<CurrentUserModel> GetCurrentUser();
    Task Register(RegisterAccountRequest model);
    Task UpdateUser(UpdateUserRequest model);
}