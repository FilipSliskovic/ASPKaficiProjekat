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
    public class CafeProductsController : ControllerBase
    {

        private UseCaseHandler _handler;

        public CafeProductsController(UseCaseHandler handler)
        {
            _handler = handler;
        }

        // GET: api/<CafeProductsController>


        /// <summary>
        /// Add a Cafe's menu. Only authorized can search.
        /// </summary>
        /// <response code="201">Successful query.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetCafeProductsQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }

        // GET api/<CafeProductsController>/5




        //[HttpGet("{id}")]
        //public string Get(int id)
        //{
        //    return "value";
        //}

        // POST api/<CafeProductsController>


        /// <summary>
        /// Add a product to cafe's menu. Only authorized can add.
        /// </summary>
        /// <response code="201">Successful.</response>
        /// <response code="404">Product/Cafe Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Cafe already has that product</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPost]
        public IActionResult Post([FromBody] CreateCafeProductDTO dto, [FromServices] ICreateCafeProductCommand command)
        {
            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        

        // DELETE api/<CafeProductsController>/5


        /// <summary>
        /// Delete a product from cafe's menu. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteCafeProductCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }
    }
}
