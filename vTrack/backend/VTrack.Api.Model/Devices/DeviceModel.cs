using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Devices;

public class DeviceModel
{
    [Required]
    public string Id { get; set; }

    [Required]
    public string SerialNumber { get; set; }

    [Required]
    public DeviceTypeModel DeviceType { get; set; }
    
    [Required]
    public bool Active { get; set; }

    public int? Locations { get; set; }
}