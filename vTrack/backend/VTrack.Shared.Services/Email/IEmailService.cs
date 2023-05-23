using System.Threading.Tasks;
using VTrack.Common.Email.Emails;

namespace VTrack.Common.Email;

public interface IEmailService
{
    Task Send(string destination, IEmail email);
}