using System;
using System.ComponentModel.DataAnnotations;
using VTrack.Api.Model.Devices;
using VTrack.Api.Model.Locations;

namespace VTrack.Api.Model.Assets;

public class AssetModel
{
    [Required]
    public string Id { get; set; }

    [Required]
    public string Name { get; set; }

    [Required]
    public bool Online => Location != null && Location.DateTime > DateTime.UtcNow.AddMinutes(-1);

    [Required]
    public int MaxSpeed => 400; // TODO update this property

    public LocationModel Location { get; set; }
    
    [Required]
    public DeviceModel Device { get; set; }
}