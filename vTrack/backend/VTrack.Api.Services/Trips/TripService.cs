using System.Collections.Generic;
using System.Threading.Tasks;
using VTrack.Api.Model.Trips;
using VTrack.Api.Services.Mappers;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Users;
using VTrack.Library.DI;
using Trip = VTrack.Core.Model.Trips.Trip;

namespace VTrack.Api.Services.Trips;

[Service(typeof(ITripService))]
public class TripService : ITripService
{
    private readonly Core.Services.Trips.ITripService tripService;
    private readonly ICurrentUserAccessor currentUserAccessor;

    public TripService(Core.Services.Trips.ITripService tripService, ICurrentUserAccessor currentUserAccessor)
    {
        this.tripService = tripService;
        this.currentUserAccessor = currentUserAccessor;
    }

    public async Task<TripListModel> GetTrips(string assetId, TripFilterModel tripFilter)
    {
        IEnumerable<Trip> trips = await tripService.GetTrips(assetId, tripFilter);
        UserDocument user = await currentUserAccessor.GetCurrentUser();

        TripListModel list = TripListMapper.Map(trips, user.UnitsType);
            
        return list;
    }
}