using System.Collections.Generic;
using System.Threading.Tasks;

namespace VTrack.Api.Services.Environment;

public interface IEnvironmentService
{
    public Task<Dictionary<string, string>> Get();
}