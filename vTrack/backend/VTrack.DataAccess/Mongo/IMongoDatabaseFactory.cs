using MongoDB.Driver;

namespace VTrack.DataAccess.Mongo;

public interface IMongoDatabaseFactory
{
    IMongoDatabase CreateMongoDatabase();
}