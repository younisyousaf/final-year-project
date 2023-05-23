using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using VTrack.DataAccess.Model.Attributes;
using VTrack.DataAccess.Model.Common;

namespace VTrack.DataAccess.Model.Devices;

[Collection("devices")]
[BsonIgnoreExtraElements]
public class DeviceDocument
{
    [BsonId]
    public ObjectId Id { get; set; }

    [BsonElement("serialNumber")]
    public string SerialNumber { get; set; }

    [BsonElement("deviceTypeId")]
    public string DeviceTypeId { get; set; }

    [BsonElement("assetId")]
    public ObjectId AssetId { get; set; }

    [BsonElement("created")]
    public AuditElement Created { get; set; }
}