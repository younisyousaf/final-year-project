using System;
using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Reports;

public class DistanceReportItemModel
{
    [Required]
    public DateTime Day { get; set; }
    
    [Required]
    public int Distance { get; set; }

    [Required]
    public double Duration { get; set; }
}