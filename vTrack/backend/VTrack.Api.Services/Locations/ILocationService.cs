using System.Threading.Tasks;
using VTrack.Api.Model.Locations;

namespace VTrack.Api.Services.Locations;

public interface ILocationService
{
    Task<LocationListModel> GetLocations(string assetId, LocationFilterModel locationFilter, int page, int size);
}