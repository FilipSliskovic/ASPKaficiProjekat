using KaficiProjekat.Application.UseCases.DTO.Searches;
using KaficiProjekat.Implementation;
using Microsoft.AspNetCore.Mvc;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace KaficiProjekat.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class TableController : ControllerBase
    {
        private UseCaseHandler _handler;

        public TableController(UseCaseHandler handler)
        {
            _handler = handler;
        }

        // GET: api/<TableController>



        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetTablesQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }



        // POST api/<TableController>


        /// <summary>
        /// Create a new table. Only authorized can create.
        /// </summary>
        /// <response code="201">Successful create.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if table already exists in that cafe.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPost]
        public IActionResult Post([FromBody] CreateTableDTO dto, [FromServices] ICreateTableCommand command)
        {
            _handler.HandleCommand(command,dto);
            return StatusCode(201);
        }

        // PUT api/<TableController>/5

        /// <summary>
        /// Update a table. Only authorized can update.
        /// </summary>
        /// <response code="200">Successful update.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPut]
        public IActionResult Put([FromBody] UpradeTableDTO dto, [FromServices] IUpdateTableCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(200);
        }

        // DELETE api/<TableController>/5

        /// <summary>
        /// Delete a table. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteTableCommand command)
        {
            _handler.HandleCommand(command,id);
            return NoContent();
        }
    }
}
