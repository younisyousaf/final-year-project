using System.Collections.Generic;
using VTrack.DataAccess.Model.Devices;

namespace VTrack.DataAccess.Services.Devices;

public interface IDeviceTypeDataService
{
    DeviceType GetById(string deviceTypeId);
    bool Exists(string deviceTypeId);
    IEnumerable<DeviceType> GetDeviceTypes();
}