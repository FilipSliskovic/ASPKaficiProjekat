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
    public class CafeController : ControllerBase
    {

        private UseCaseHandler _handler;

        public CafeController(UseCaseHandler handler)
        {
            _handler = handler;
        }


        


        // GET: api/<CafeController>


        /// <summary>
        /// Get Cafes. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetCafeQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<CafeController>/5


        /// <summary>
        /// Get a single Cafe. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpGet("{id}")]
        public IActionResult Get(int id, [FromServices] IGetSingleCafeQuery query)
        {
            return Ok(_handler.HandleQuery(query,id));
        }

        // POST api/<CafeController>


        /// <summary>
        /// Create a Cafe. Only authorized can create.
        /// </summary>
        /// <response code="200">Successful creation.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe with that data already exists</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPost]
        public IActionResult Post([FromBody] CreateCafeDTO dto, [FromServices] ICreateCafeCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        // PUT api/<CafeController>/5


        /// <summary>
        /// Update a Cafe. Only authorized can update.
        /// </summary>
        /// <response code="200">Successful update.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe with that data already exists</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPut]
        public IActionResult Put([FromBody] CafeDTO dto, [FromServices] IUpdateCafeCommand command)
        {
            _handler.HandleCommand(command, dto);
            return Ok();
        }

        // DELETE api/<CafeController>/5



        /// <summary>
        /// Delete Cafe. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe is linked with some posts.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteCafeCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }
    }
}
