using System.Collections.Generic;
using System.Linq;
using Microsoft.Extensions.DependencyInjection;
using VTrack.DataAccess.Model.Protocols;
using VTrack.DataAccess.Services.Devices;
using VTrack.Library.DI;

namespace VTrack.DataAccess.Services.Protocols;

[Service(typeof(IProtocolDataService), ServiceLifetime.Singleton)]
public class ProtocolDataService : IProtocolDataService
{
    private readonly IDeviceTypeDataService deviceTypeDataService;
    private Protocol[]? protocols;

    public ProtocolDataService(IDeviceTypeDataService deviceTypeDataService)
    {
        this.deviceTypeDataService = deviceTypeDataService;
    }

    public IEnumerable<Protocol> GetProtocols()
    {
        return protocols ??= deviceTypeDataService.GetDeviceTypes()
            .GroupBy(x => x.Protocol)
            .Select(x => x.Key)
            .OrderBy(x => x.Name)
            .ThenBy(x => x.Port)
            .ToArray();
    }
}