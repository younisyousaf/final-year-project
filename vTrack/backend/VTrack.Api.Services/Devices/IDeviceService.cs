using System.Threading.Tasks;
using VTrack.Api.Model.Devices;

namespace VTrack.Api.Services.Devices;

public interface IDeviceService
{
    Task<bool> SerialNumberIsUsed(string serialNumber, string deviceTypeId, string? excludeAssetId = null);
    Task<DevicesModel> Get(string assetId);
    Task Add(string assetId, AddDeviceModel model);
    Task Delete(string id);
}