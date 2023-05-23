namespace VTrack.Common.Email.Emails;

public interface IEmail
{
    string Subject { get; }
    string Body { get; }
}