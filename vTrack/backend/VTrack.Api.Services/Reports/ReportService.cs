using System.Collections.Generic;
using System.Threading.Tasks;
using VTrack.Api.Model.Reports;
using VTrack.Api.Services.Mappers;
using VTrack.Api.Services.Roles;
using VTrack.Api.Services.User;
using VTrack.DataAccess.Model.Assets;
using VTrack.DataAccess.Model.Locations;
using VTrack.DataAccess.Model.Users;
using VTrack.DataAccess.Services.Assets;
using VTrack.DataAccess.Services.Locations;
using VTrack.Library.DI;

namespace VTrack.Api.Services.Reports;

[Service(typeof(IReportService))]
public class ReportService : IReportService
{
    private readonly IAssetDataService assetDataService;
    private readonly IRoleService roleService;
    private readonly ILocationDataService locationDataService;
    private readonly ICurrentUserAccessor currentUserAccessor;

    public ReportService(IAssetDataService assetDataService, IRoleService roleService,
        ILocationDataService locationDataService, ICurrentUserAccessor currentUserAccessor)
    {
        this.assetDataService = assetDataService;
        this.roleService = roleService;
        this.locationDataService = locationDataService;
        this.currentUserAccessor = currentUserAccessor;
    }

    public async Task<DistanceReportListModel> GetDistanceReport(string assetId, DistanceReportFilterModel tripFilter)
    {
        AssetDocument asset = await assetDataService.GetById(assetId);

        roleService.CheckRole(asset, AssetRoleType.Viewer);

        List<LocationDocument> locations =
            await locationDataService.GetLocations(assetId, tripFilter);

        UserDocument user = await currentUserAccessor.GetCurrentUser();

        DistanceReportListModel listModel = DistanceReportMapper.Map(locations, user.UnitsType);

        return listModel;
    }
}