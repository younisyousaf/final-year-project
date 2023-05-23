using VTrack.DataAccess.Model.Common;

namespace VTrack.Api.Model.User;

public class UpdateUserRequest
{
    public string Email { get; set; }
    public UnitsType? UnitsType { get; set; }
}