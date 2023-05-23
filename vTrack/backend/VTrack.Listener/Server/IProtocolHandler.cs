using System.Threading;
using System.Threading.Tasks;

namespace VTrack.Listener.Server;

public interface IProtocolHandler
{
    Task HandleProtocol(CancellationToken cancellationToken, IProtocol protocol);
}