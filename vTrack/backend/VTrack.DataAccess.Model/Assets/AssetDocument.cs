using System.Collections.Generic;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using VTrack.DataAccess.Model.Attributes;
using VTrack.DataAccess.Model.Common;
using VTrack.DataAccess.Model.Locations;

namespace VTrack.DataAccess.Model.Assets;

[Collection("assets")]
[BsonIgnoreExtraElements]
public class AssetDocument
{
    [BsonId]
    public ObjectId Id { get; set; }

    [BsonElement("name")]
    public string Name { get; set; }

    [BsonElement("created")]
    public AuditElement Created { get; set; }
        
    [BsonElement("device")]
    public AssetDeviceElement Device { get; set; }
        
    [BsonElement("location")]
    public LocationDocument? Location { get; set; }

    [BsonElement("userRoles")]
    public IEnumerable<AssetUserRoleElement> UserRoles { get; set; }
}