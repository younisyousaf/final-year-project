using System;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Common;

namespace VTrack.Api.Services.Mappers;

public static class AuditElementMapper
{
    public static AuditElement Map(ObjectId? userId = null)
    {
        return new AuditElement
        {
            Date = DateTime.UtcNow,
            UserId = userId
        };
    }
}