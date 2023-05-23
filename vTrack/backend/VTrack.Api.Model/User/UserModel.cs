using System.ComponentModel.DataAnnotations;
using VTrack.DataAccess.Model.Common;

namespace VTrack.Api.Model.User;

public class UserModel
{
    [Required]
    public string Id { get; set; }

    [Required]
    public string Email { get; set; }

    [Required]
    public UnitsType Units { get; set; }
}