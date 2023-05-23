using System.Collections.Generic;
using System.Linq;
using VTrack.Api.Model.Protocols;
using VTrack.DataAccess.Model.Protocols;

namespace VTrack.Api.Services.Mappers;

public static class ProtocolListMapper
{
    public static ProtocolsModel Map(IEnumerable<Protocol> protocols)
    {
        ProtocolsModel listModel = new()
        {
            Items = protocols.Select(ProtocolModelMapper.Map).ToList()
        };

        return listModel;
    }
}