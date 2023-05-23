using Mongo2Go;
using MongoDB.Bson.Serialization.Conventions;
using MongoDB.Driver;
using VTrack.DataAccess.Mongo;

namespace VTrack.Api.Tests.Helpers;

public class TestMongoDatabaseFactory : IMongoDatabaseFactory
{
    private readonly IMongoDatabase database;
    private readonly MongoDbRunner mongoDbRunner;
    private readonly MongoClient mongoClient;

    public TestMongoDatabaseFactory()
    {
        mongoDbRunner = MongoDbRunner.Start();
        mongoClient = new MongoClient(mongoDbRunner.ConnectionString);
        database = mongoClient.GetDatabase("Navtrack_Test");
        
        ConventionRegistry.Register(nameof(IgnoreIfNullConvention),
            new ConventionPack { new IgnoreIfNullConvention(true) }, t => true);
        ConventionRegistry.Register(nameof(IgnoreExtraElementsConvention),
            new ConventionPack { new IgnoreExtraElementsConvention(true) }, t => true);
    }

    public IMongoDatabase CreateMongoDatabase()
    {
        return database;
    }
}