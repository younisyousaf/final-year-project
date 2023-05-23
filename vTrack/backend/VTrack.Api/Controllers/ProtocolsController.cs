using System.Net.Mime;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using VTrack.Api.Model.Protocols;
using VTrack.Api.Services.Protocols;

namespace VTrack.Api.Controllers;

[ApiController]
[Route("protocols")]
public class ProtocolsController : ControllerBase
{
    private readonly IProtocolService protocolService;

    public ProtocolsController(IProtocolService protocolService)
    {
        this.protocolService = protocolService;
    }

    [HttpGet]
    [ProducesResponseType(typeof(ProtocolsModel), StatusCodes.Status200OK)]
    [Produces(MediaTypeNames.Application.Json)]
    public ProtocolsModel GetProtocols()
    {
        return protocolService.GetProtocols();
    }
}