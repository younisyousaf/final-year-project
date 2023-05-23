using System.Collections.Generic;
using System.Threading.Tasks;
using VTrack.Core.Model.Trips;

namespace VTrack.Core.Services.Trips;

public interface ITripService
{
    Task<IEnumerable<Trip>> GetTrips(string assetId, TripFilter tripFilter);
}