using System.Threading.Tasks;
using VTrack.DataAccess.Model.Users;

namespace VTrack.DataAccess.Services.Users;

public interface ITokenDataService
{
    Task Add(RefreshTokenDocument document);
    Task Remove(string userId);
    Task<RefreshTokenDocument?> GetByUserId(string userId);
}