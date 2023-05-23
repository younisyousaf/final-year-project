using System.Collections.Generic;

namespace VTrack.Listener.Server;

public interface IProtocol
{
    int Port { get; }
    byte[] MessageStart { get; }
    IEnumerable<byte[]> MessageEnd { get; }
    string SplitMessageBy { get; }
    int? GetMessageLength(byte[] bytes);
}