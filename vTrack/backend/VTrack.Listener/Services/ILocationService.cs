using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.Listener.Models;

namespace VTrack.Listener.Services;

public interface ILocationService
{
    Task AddRange(List<Location> locations, ObjectId connectionMessageId);
}