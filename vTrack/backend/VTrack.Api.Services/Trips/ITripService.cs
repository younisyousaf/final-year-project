using System.Threading.Tasks;
using VTrack.Api.Model.Trips;

namespace VTrack.Api.Services.Trips;

public interface ITripService
{
    Task<TripListModel> GetTrips(string assetId, TripFilterModel tripFilter);
}