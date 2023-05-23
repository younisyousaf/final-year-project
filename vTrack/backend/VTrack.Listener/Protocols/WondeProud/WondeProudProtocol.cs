using VTrack.Library.DI;
using VTrack.Listener.Server;

namespace VTrack.Listener.Protocols.WondeProud;

[Service(typeof(IProtocol))]
public class WondeProudProtocol : BaseProtocol
{
    public override int Port => 7046;
}