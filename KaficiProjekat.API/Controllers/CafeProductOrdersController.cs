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
    public class CafeProductOrdersController : ControllerBase
    {

        private UseCaseHandler _handler;

        public CafeProductOrdersController(UseCaseHandler handler)
        {
            _handler = handler;
        }


        // GET: api/<CafeProductOrdersController>

        /// <summary>
        /// Get all products that are in orders. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetCafeProductOrdersQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<CafeProductOrdersController>/5



        /// <summary>
        /// Get a product from an order. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet("{id}")]
        public IActionResult Get(int id , [FromServices] IGetCafeProductOrderQuery query)
        {
            return Ok(_handler.HandleQuery(query, id));
        }

        // POST api/<CafeProductOrdersController>


        /// <summary>
        /// Add a product to an order. Only authorized can add.
        /// </summary>
        /// <response code="201">Successful.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPost]
        public IActionResult Post([FromBody] CreateCafeProductOrderDTO dto, [FromServices] ICreateCafeProductOrderCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        // PUT api/<CafeProductOrdersController>/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        // DELETE api/<CafeProductOrdersController>/5


        /// <summary>
        /// Delete a product from an order. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe is linked with some posts.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpDelete("{id}")]
        public IActionResult Delete(int id , [FromServices] IDeleteCafeProductOrderCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }

    }
}
