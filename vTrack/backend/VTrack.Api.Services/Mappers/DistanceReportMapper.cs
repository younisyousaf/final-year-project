using System.Collections.Generic;
using VTrack.Api.Model.Locations;
using VTrack.Api.Model.Reports;
using VTrack.Api.Model.Trips;
using VTrack.Core.Model;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Locations;

namespace VTrack.Api.Services.Mappers;

public static class DistanceReportMapper
{
    public static DistanceReportListModel Map(IEnumerable<LocationDocument> source, UnitsType unitsType)
    {
        List<TripModel> trips = new();
        TripModel currentTripModel = null;
        LocationDocument lastLocation = null;

        foreach (LocationDocument locationDocument in source)
        {
            if (lastLocation == null || locationDocument.DateTime > lastLocation.DateTime.AddMinutes(5))
            {
                currentTripModel = new TripModel
                {
                    Locations = new List<LocationModel>()
                };
                trips.Add(currentTripModel);
            }

            currentTripModel.Locations.Add(LocationMapper.Map(locationDocument, unitsType));

            lastLocation = locationDocument;
        }

        DistanceReportListModel listModel = new()
        {
            // Items = trips.Select(trip =>
            //     {
            //         trip.Distance = TripDistanceCalculator.CalculateDistance(trip.Locations.Select(x =>
            //             (x.Latitude, x.Longitude, x.Odometer)).ToList());
            //
            //         return trip;
            //     })
            //     .Where(x => x.Distance > 0)
            //     .OrderByDescending(x => x.EndLocation.DateTime)
            //     .ToList()
        };

        return listModel;
    }
}