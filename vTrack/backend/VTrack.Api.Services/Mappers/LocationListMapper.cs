using System.Collections.Generic;
using System.Linq;
using VTrack.Api.Model.Locations;
using VTrack.Core.Model;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Locations;

namespace VTrack.Api.Services.Mappers;

public static class LocationListMapper
{
    public static LocationListModel Map(IEnumerable<LocationDocument> source, UnitsType unitsType)
    {
        LocationListModel listModel = new()
        {
            Items = source.Select(source1 => LocationMapper.Map(source1, unitsType)).ToList()
        };

        return listModel;
    }
}