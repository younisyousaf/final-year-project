using System.Threading.Tasks;
using VTrack.Api.Model.Reports;

namespace VTrack.Api.Services.Reports;

public interface IReportService
{
    Task<DistanceReportListModel> GetDistanceReport(string assetId, DistanceReportFilterModel tripFilter);
}