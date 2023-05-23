using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.User;

public class ResetPasswordRequest : BasePasswordRequest
{
    [Required]
    public string Hash { get; set; }
}