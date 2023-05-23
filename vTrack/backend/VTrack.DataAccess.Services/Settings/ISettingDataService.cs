using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using VTrack.DataAccess.Model.Settings;

namespace VTrack.DataAccess.Services.Settings;

public interface ISettingDataService
{
    Task<List<SettingDocument>> GetAll();
    Task<SettingDocument?> Get(string key);
    Task Save(string key, BsonDocument value);
}