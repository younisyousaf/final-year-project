using System.Threading;
using System.Threading.Tasks;

namespace VTrack.Listener.Services;

public interface IListenerService
{
    Task Execute(CancellationToken cancellationToken);
}