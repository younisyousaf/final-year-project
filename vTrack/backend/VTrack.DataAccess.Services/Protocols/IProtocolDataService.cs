using System.Collections.Generic;
using VTrack.DataAccess.Model.Protocols;

namespace VTrack.DataAccess.Services.Protocols;

public interface IProtocolDataService
{
    IEnumerable<Protocol> GetProtocols();
}