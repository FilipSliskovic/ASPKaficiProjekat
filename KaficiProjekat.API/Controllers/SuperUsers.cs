using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.DTO.Searches;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.Implementation;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace KaficiProjekat.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class SuperUsers : ControllerBase
    {

        private UseCaseHandler _handler;

        public SuperUsers(UseCaseHandler handler)
        {
            _handler = handler;
        }





        // GET: api/<SuperUsers>

        /// <summary>
        /// Get all superusers. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe is linked with some posts.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetSuperUsersQuery query)
        {
            return Ok(_handler.HandleQuery(query, search));
        }





        // PUT api/<SuperUsers>/5

        /// <summary>
        /// Take all superuser usecases. Only authorized can delete.
        /// </summary>
        /// <response code="200">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if user is already superuser.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPut]
        public IActionResult Put([FromBody] UpdateSuperUserDTO dto, [FromServices] IUpdateSuperUserCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(200) ;
        }

       
    }
}
