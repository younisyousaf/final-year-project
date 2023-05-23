using System.Collections.Generic;
using VTrack.Listener.Models;

namespace VTrack.Listener.Server;

public interface ICustomMessageHandler
{
    Location Parse(MessageInput input);
    IEnumerable<Location> ParseRange(MessageInput input);
}
    
public interface ICustomMessageHandler<T> : ICustomMessageHandler
{
}