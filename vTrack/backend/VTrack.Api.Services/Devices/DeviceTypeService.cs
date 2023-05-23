using System.Collections.Generic;
using VTrack.Api.Model.Devices;
using VTrack.Api.Services.Mappers;
using VTrack.DataAccess.Model.Devices;
using VTrack.DataAccess.Services.Devices;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Devices;

[Service(typeof(IDeviceTypeService))]
public class DeviceTypeService : IDeviceTypeService
{
    private readonly IDeviceTypeDataService deviceTypeDataService;

    public DeviceTypeService(IDeviceTypeDataService deviceTypeDataService)
    {
        this.deviceTypeDataService = deviceTypeDataService;
    }

    public DeviceTypesModel GetAll()
    {
        IEnumerable<DeviceType> devicesTypes = deviceTypeDataService.GetDeviceTypes();

        return DeviceTypesModelMapper.Map(devicesTypes);
    }
}