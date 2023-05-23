using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using VTrack.Api.Services.Mappers;

namespace VTrack.Api.Services.ActionFilters;

public class ModelStateMappingActionFilter : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext context)
    {
        if (!context.ModelState.IsValid)
        {
            context.Result = new JsonResult(ErrorModelMapper.Map(context.ModelState))
            {
                StatusCode = (int?)HttpStatusCode.BadRequest
            };
        }
    }
}