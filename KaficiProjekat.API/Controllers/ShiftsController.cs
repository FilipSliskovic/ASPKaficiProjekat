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
    
    public class ShiftsController : ControllerBase
    {

        private UseCaseHandler _handler;

        public ShiftsController(UseCaseHandler handler)
        {
            _handler = handler;
        }


        // GET: api/<ShiftsController>


        /// <summary>
        /// Get all shifts. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetShiftsQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<ShiftsController>/5
        //[HttpGet("{id}")]
        //public string Get(int id)
        //{
        //    return "value";
        //}

        // POST api/<ShiftsController>


        /// <summary>
        /// Create a new shift. Only authorized can create.
        /// </summary>
        /// <response code="201">Successful create.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if shift already exists</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPost]
        public IActionResult Post([FromBody] CreateShiftDTO dto, [FromServices] ICreateShiftCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        // PUT api/<ShiftsController>/5


        /// <summary>
        /// Update a shift. Only authorized can update.
        /// </summary>
        /// <response code="200">Successful update.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if shift already exists</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPut]
        public IActionResult Put([FromBody] ShiftDTO dto, [FromServices] IUpdateShiftCommand command)
        {
            _handler.HandleCommand(command, dto);
            return Ok();
        }

        // DELETE api/<ShiftsController>/5

        /// <summary>
        /// Delete a shift. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteShiftCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }
    }
}
