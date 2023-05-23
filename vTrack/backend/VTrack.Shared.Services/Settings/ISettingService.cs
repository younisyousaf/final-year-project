using System.Threading.Tasks;

namespace VTrack.Common.Settings;

public interface ISettingService
{
    Task<T?> Get<T>() where T : new();
    Task Set<T>(T settings);
}