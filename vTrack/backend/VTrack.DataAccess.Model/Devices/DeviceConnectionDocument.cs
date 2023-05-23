using System;
using System.Collections.Generic;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using VTrack.DataAccess.Model.Attributes;

namespace VTrack.DataAccess.Model.Devices;

[Collection("deviceConnections")]
public class DeviceConnectionDocument
{
    [BsonId]
    public ObjectId Id { get; set; }
        
    [BsonElement("openedAt")]
    public DateTime OpenedAt { get; set; }
        
    [BsonElement("closedAt")]
    public DateTime? ClosedAt { get; set; }
        
    [BsonElement("protocolPort")]
    public int ProtocolPort { get; set; }
        
    [BsonElement("remoteEndpoint")]
    public string RemoteEndpoint { get; set; }
        
    [BsonElement("deviceId")]
    public ObjectId DeviceId { get; set; }
        
    [BsonElement("messages")]
    public List<DeviceConnectionMessageElement> Messages { get; set; }
}