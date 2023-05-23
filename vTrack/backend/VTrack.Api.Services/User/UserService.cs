using System.Threading.Tasks;
using VTrack.Api.Model.Errors;
using VTrack.Api.Model.User;
using VTrack.Api.Services.Exceptions;
using VTrack.Api.Services.Mappers;
using VTrack.Common.Passwords;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Users;
using VTrack.Library.DI;

namespace VTrack.Api.Services.User;

[Service(typeof(IUserService))]
public class UserService : IUserService
{
    private readonly IPasswordHasher passwordHasher;
    private readonly ICurrentUserAccessor currentUserAccessor;
    private readonly IUserDataService userDataService;

    public UserService(IPasswordHasher passwordHasher, ICurrentUserAccessor currentUserAccessor,
        IUserDataService userDataService)
    {
        this.passwordHasher = passwordHasher;
        this.currentUserAccessor = currentUserAccessor;
        this.userDataService = userDataService;
    }

    public async Task<CurrentUserModel> GetCurrentUser()
    {
        UserDocument entity = await currentUserAccessor.GetCurrentUser();

        return CurrentUserMapper.Map(entity);
    }

    public async Task UpdateUser(UpdateUserRequest model)
    {
        UserDocument currentUser = await currentUserAccessor.GetCurrentUser();

        await userDataService.UpdateUser(currentUser, model.Email, model.UnitsType);
    }

    public async Task Register(RegisterAccountRequest model)
    {
        ApiException apiException = new();

        if (await userDataService.EmailExists(model.Email))
        {
            apiException.AddValidationError(nameof(model.Email), ValidationErrorCodes.EmailAlreadyExists);
        }

        if (model.Password != model.ConfirmPassword)
        {
            apiException.AddValidationError(nameof(model.ConfirmPassword), ValidationErrorCodes.PasswordsDoNotMatch);
        }

        apiException.ThrowIfInvalid();

        (string hash, string salt) = passwordHasher.Hash(model.Password);

        UserDocument userDocument = UserDocumentMapper.Map(model.Email, hash, salt);

        await userDataService.Add(userDocument);
    }
}