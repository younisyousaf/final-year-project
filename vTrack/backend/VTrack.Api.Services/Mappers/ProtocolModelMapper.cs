using VTrack.Api.Model.Protocols;
using Protocol = VTrack.DataAccess.Model.Protocols.Protocol;

namespace VTrack.Api.Services.Mappers;

public class ProtocolModelMapper
{
    public static ProtocolModel Map(Protocol source)
    {
        return new ProtocolModel
        {
            Name = source.Name,
            Port = source.Port
        };
    }
}