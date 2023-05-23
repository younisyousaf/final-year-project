using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Common;

public class ValidationErrorModel : BaseErrorModel
{
    [Required]
    public string PropertyName { get; set; }
}