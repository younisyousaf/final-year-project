using System.Net;
using VTrack.Api.Tests.Helpers;

namespace VTrack.Api.Tests;

public class HealthTests : IClassFixture<TestWebApplicationFactory<Program>>
{
    private readonly HttpClient httpClient;

    public HealthTests(TestWebApplicationFactory<Program> factory)
    {
        httpClient = factory.CreateClient();
    }

    [Fact]
    public async Task Health_Get_ReturnsOk()
    {
        HttpResponseMessage response = await httpClient.GetAsync("/health");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}
