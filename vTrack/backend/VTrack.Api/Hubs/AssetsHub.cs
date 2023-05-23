using System.Threading.Tasks;
using IdentityServer4;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using VTrack.Api.Model.Assets;
using VTrack.Api.Services.Assets;

namespace VTrack.Api.Hubs;

[Authorize(IdentityServerConstants.LocalApi.PolicyName)]
public class AssetsHub : Hub
{
    private readonly IAssetService assetService;

    public AssetsHub(IAssetService assetService)
    {
        this.assetService = assetService;
    }

    public async Task<AssetsModel> GetAll()
    {
        AssetsModel assets = await assetService.GetAssets();

        return assets;
    }
}