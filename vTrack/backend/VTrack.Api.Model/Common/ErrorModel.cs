using System.Collections.Generic;

namespace VTrack.Api.Model.Common;

public class ErrorModel : BaseErrorModel
{
    public List<ValidationErrorModel>? ValidationErrors { get; set; }
}