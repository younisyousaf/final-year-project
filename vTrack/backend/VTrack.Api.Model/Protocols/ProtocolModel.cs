using System.ComponentModel.DataAnnotations;

namespace VTrack.Api.Model.Protocols;

public class ProtocolModel
{
    [Required]
    public int Port { get; set; }

    [Required]
    public string Name { get; set; }
}