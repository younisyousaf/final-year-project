using VTrack.DataAccess.Model.Assets;

namespace VTrack.Listener.Models;

public class Device
{
    public string IMEI { get; set; }
    public AssetDocument Entity { get; set; }
}