using System;
using Microsoft.AspNetCore.Authorization;
using VTrack.DataAccess.Model.Assets;

namespace VTrack.Api.Services.ActionFilters;

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Class)]
public class AuthorizeAssetAttribute : AuthorizeAttribute
{
    public readonly AssetRoleType AssetRoleType;

    public AuthorizeAssetAttribute(AssetRoleType assetRoleType)
    {
        AssetRoleType = assetRoleType;
    }
}