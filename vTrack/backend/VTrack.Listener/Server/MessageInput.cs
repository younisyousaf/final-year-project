using VTrack.Listener.Models;

namespace VTrack.Listener.Server;

public class MessageInput
{
    public Client Client { get; set; }
    public INetworkStreamWrapper NetworkStream { get; set; }
    public DataMessage DataMessage { get; set; }
}