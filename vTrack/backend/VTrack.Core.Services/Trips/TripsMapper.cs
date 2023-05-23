using System.Collections.Generic;
using System.Linq;
using VTrack.Core.Model;
using VTrack.Core.Model.Trips;
using VTrack.Core.Services.Util;
using VTrack.DataAccess.Model.Locations;

namespace VTrack.Core.Services.Trips;

public static class TripsMapper
{
    public static IEnumerable<Trip> Map(IEnumerable<LocationDocument> source)
    {
        List<Trip> trips = CreateTrips(source);

        AddDistance(trips);

        return trips;
    }

    private static void AddDistance(List<Trip> trips)
    {
        foreach (Trip trip in trips)
        {
            trip.Distance = TripDistanceCalculator.CalculateDistance(trip.Locations
                .Select(x => (new Coordinates(x.Latitude, x.Longitude), x.Odometer)).ToList());
        }
    }

    private static List<Trip> CreateTrips(IEnumerable<LocationDocument> source)
    {
        List<Trip> trips = new();

        Trip currentTrip = null;
        LocationDocument lastLocation = null;

        foreach (LocationDocument locationDocument in source)
        {
            if (lastLocation == null || locationDocument.DateTime > lastLocation.DateTime.AddMinutes(5))
            {
                currentTrip = new Trip
                {
                    Locations = new List<LocationDocument>()
                };

                trips.Add(currentTrip);
            }

            currentTrip.Locations.Add(locationDocument);
            lastLocation = locationDocument;
        }

        return trips;
    }
}