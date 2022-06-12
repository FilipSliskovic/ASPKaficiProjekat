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
    public class OrdersController : ControllerBase
    {

        private UseCaseHandler _handler;

        public OrdersController(UseCaseHandler handler)
        {
            _handler = handler;
        }



        // GET: api/<OrdersController>

        /// <summary>
        /// Gets all orders. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetOrdersQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<OrdersController>/5

        /// <summary>
        /// Gets and order and makes a reciept. Only authorized make a reciept.
        /// </summary>
        /// <response code="200">Success.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet("{id}")]
        public IActionResult Get(int id, [FromServices] IGetOrderQuery query)
        {
            return Ok(_handler.HandleQuery(query, id));
        }

        // POST api/<OrdersController>


        /// <summary>
        /// Create a new Order. Only authorized can create.
        /// </summary>
        /// <response code="201">Successful create.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe is linked with some posts.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPost]
        public IActionResult Post([FromBody] CreateOrderDTO dto, [FromServices] ICreateOrderCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        // PUT api/<OrdersController>/5


        /// <summary>
        /// Update order. Only authorized can delete.
        /// </summary>
        /// <response code="200">Successful update.</response>
        /// <response code="404">Order/table Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPut("{id}")]
        public IActionResult Put([FromBody] UpdateOrderDTO dto, [FromServices] IUpdateOrderCommand command)
        {
            _handler.HandleCommand(command, dto);
            return Ok();
        }

        // DELETE api/<OrdersController>/5


        /// <summary>
        /// Delete an order . Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteOrderCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }
    }
}
