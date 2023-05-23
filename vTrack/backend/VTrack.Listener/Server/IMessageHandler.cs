using System.Threading.Tasks;
using VTrack.Listener.Models;

namespace VTrack.Listener.Server;

public interface IMessageHandler
{
    Task HandleMessage(Client client, INetworkStreamWrapper networkStream, byte[] bytes);
}