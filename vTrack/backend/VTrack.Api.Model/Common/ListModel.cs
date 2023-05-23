using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Common;

public class ListModel<T>
{
    [Required]
    public IEnumerable<T> Items { get; set; }
}