using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.User;

public class ForgotPasswordRequest
{
    [Required]
    public string Email { get; set; }
}