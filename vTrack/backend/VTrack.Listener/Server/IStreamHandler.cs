using System.Threading;
using System.Threading.Tasks;
using VTrack.Listener.Models;

namespace VTrack.Listener.Server;

public interface IStreamHandler
{
    Task HandleStream(CancellationToken cancellationToken,
        Client client, INetworkStreamWrapper networkStream);
}