using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using VTrack.DataAccess.Model.Attributes;

namespace VTrack.DataAccess.Model.Settings;

[Collection("settings")]
public class SettingDocument
{
    [BsonId]
    public ObjectId Id { get; set; }

    [BsonElement("key")]
    public string Key { get; set; }
  
    [BsonElement("value")]
    public BsonDocument Value { get; set; }
}