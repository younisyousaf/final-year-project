using System;
using System.Text.Json.Serialization;
using VTrack.DataAccess.Model.Locations;

namespace VTrack.Api.Model.Trips;

public class DateFilterModel : DateFilter
{
    [JsonPropertyName("startDate")]
    public override DateTime? StartDate { get; set; }

    [JsonPropertyName("endDate")]
    public override DateTime? EndDate { get; set; }
}