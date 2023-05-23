using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Devices;
using VTrack.Listener.Models;

namespace VTrack.Listener.Services;

public interface IConnectionService
{
    Task<DeviceConnectionDocument> NewConnection(string endPoint, int protocolPort);
    Task MarkConnectionAsClosed(DeviceConnectionDocument deviceConnection);
    Task<ObjectId> AddMessage(ObjectId deviceConnectionId, string hex);
    Task SetDeviceId(Client client);
}