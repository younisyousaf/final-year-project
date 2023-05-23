using System.Threading;
using System.Threading.Tasks;
using VTrack.Listener.Models;

namespace VTrack.Listener.Server;

public interface IClientHandler
{
    Task HandleClient(CancellationToken cancellationToken, Client client);
}