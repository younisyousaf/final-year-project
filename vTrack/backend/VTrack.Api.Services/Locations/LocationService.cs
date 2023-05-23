using System.Collections.Generic;
using System.Threading.Tasks;
using VTrack.Api.Model.Locations;
using VTrack.Api.Services.Mappers;
using VTrack.Api.Services.Roles;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Locations;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Assets;
using VTrack.DataAccess.Services.Locations;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Locations;

[Service(typeof(ILocationService))]
public class LocationService : ILocationService
{
    private readonly IAssetDataService assetDataService;
    private readonly IRoleService roleService;
    private readonly ILocationDataService locationDataService;
    private readonly ICurrentUserAccessor currentUserAccessor;

    public LocationService(IAssetDataService assetDataService, IRoleService roleService,
        ILocationDataService locationDataService, ICurrentUserAccessor currentUserAccessor)
    {
        this.assetDataService = assetDataService;
        this.roleService = roleService;
        this.locationDataService = locationDataService;
        this.currentUserAccessor = currentUserAccessor;
    }

    public async Task<LocationListModel> GetLocations(string assetId, LocationFilterModel locationFilter, int page, int size)
    {
        AssetDocument asset = await assetDataService.GetById(assetId);

        roleService.CheckRole(asset, AssetRoleType.Viewer);

        List<LocationDocument> locations = await locationDataService.GetLocations(assetId, locationFilter);
        UserDocument user = await currentUserAccessor.GetCurrentUser();

        return LocationListMapper.Map(locations, user.UnitsType);
    }
}