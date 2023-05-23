using VTrack.Api.Model.Devices;

namespace VTrack.Api.Services.Devices;

public interface IDeviceTypeService
{
    DeviceTypesModel GetAll();
}