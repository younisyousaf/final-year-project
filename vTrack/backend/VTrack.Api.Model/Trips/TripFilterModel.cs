using System.Text.Json.Serialization;
using VTrack.Core.Model.Trips;

namespace VTrack.Api.Model.Trips;

public class TripFilterModel : TripFilter
{
    [JsonPropertyName("minAvgAltitude")]
    public override int? MinAvgAltitude { get; set; }

    [JsonPropertyName("maxAvgAltitude")]
    public override int? MaxAvgAltitude { get; set; }

    [JsonPropertyName("minAvgSpeed")]
    public override int? MinAvgSpeed { get; set; }

    [JsonPropertyName("maxAvgSpeed")]
    public override int? MaxAvgSpeed { get; set; }

    [JsonPropertyName("minDuration")]
    public override int? MinDuration { get; set; }

    [JsonPropertyName("maxDuration")]
    public override int? MaxDuration { get; set; }

    [JsonPropertyName("latitude")]
    public override double? Latitude { get; set; }

    [JsonPropertyName("longitude")]
    public override double? Longitude { get; set; }

    [JsonPropertyName("radius")]
    public override int? Radius { get; set; }
}