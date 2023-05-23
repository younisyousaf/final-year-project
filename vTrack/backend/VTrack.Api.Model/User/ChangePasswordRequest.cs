using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.User;

public class ChangePasswordRequest : BasePasswordRequest
{
    [Required]
    public string CurrentPassword { get; set; }
}