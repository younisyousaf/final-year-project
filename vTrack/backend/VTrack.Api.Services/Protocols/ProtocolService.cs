using System.Collections.Generic;
using VTrack.Api.Model.Protocols;
using VTrack.Api.Services.Mappers;
using VTrack.DataAccess.Model.Protocols;
using VTrack.DataAccess.Services.Protocols;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Protocols;

[Service(typeof(IProtocolService))]
public class ProtocolService : IProtocolService
{
    private readonly IProtocolDataService protocolDataService;

    public ProtocolService(IProtocolDataService protocolDataService)
    {
        this.protocolDataService = protocolDataService;
    }

    public ProtocolsModel GetProtocols()
    {
        IEnumerable<Protocol> protocols = protocolDataService.GetProtocols();

        return ProtocolListMapper.Map(protocols);
    }
}