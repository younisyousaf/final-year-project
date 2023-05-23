using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Assets;

public class AddUserToAssetModel
{
    [Required]
    public string Email { get; set; }

    [Required]
    public string Role { get; set; }
}