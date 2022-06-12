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
    public class WorkersCafeController : ControllerBase
    {

        private UseCaseHandler _handler;

        public WorkersCafeController(UseCaseHandler handler)
        {
            _handler = handler;
        }


        // GET: api/<WorkersCafeController>

        /// <summary>
        /// Get all workers and their shifts. Only authorized can delete.
        /// </summary>
        /// <response code="200">Successful.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetWorkersQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<WorkersCafeController>/5
        //[HttpGet("{id}")]
        //public string Get(int id)
        //{
        //    return "value";
        //}

        // POST api/<WorkersCafeController>

        /// <summary>
        /// Create a new WhoWorksWhenAndWhere. Only authorized can create.
        /// </summary>
        /// <response code="201">Successful create.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPost]
        public IActionResult Post([FromBody] CreateWorkersDTO dto, [FromServices] ICreateWorkersCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        // PUT api/<WorkersCafeController>/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        // DELETE api/<WorkersCafeController>/5


        /// <summary>
        /// Delete Cafe. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe is linked with some posts.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteWorkersCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();

        }
    }
}
