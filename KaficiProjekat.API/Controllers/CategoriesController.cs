using KaficiProjekat.API.DTO;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO.Searches;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.Implementation;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace KaficiProjekat.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CategoriesController : ControllerBase
    {

        private UseCaseHandler _handler;

        public CategoriesController(UseCaseHandler handler)
        {
            _handler = handler;
        }


        // GET: api/<CategoriesController>



        /// <summary>
        /// Get all categories. Only authorized can search.
        /// </summary>
        /// <response code="200">Successful query.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpGet]
        public IActionResult Get([FromQuery] BasePagedSearch search, [FromServices] IGetCategoriesQuery query)
        {
            return Ok(_handler.HandleQuery(query,search));
        }



        // POST api/<CategoriesController>


        /// <summary>
        /// Create a new category. Only authorized can create.
        /// </summary>
        /// <response code="201">Successful delete.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if Category already exists</response>
        /// <response code="500">Unexpected server error.</response>


        [HttpPost]
        public IActionResult Post([FromForm] CreateCategoryApiDto dto, [FromServices] ICreateCategoryCommand command)
        {
            if (dto.Image != null)
            {

                var guid = Guid.NewGuid();
                var extension = Path.GetExtension(dto.Image.FileName);

                if (SupportedExtension.Contains(extension))
                {
                    throw new InvalidOperationException("Invalid file extension");
                }

                var newFileName = guid + extension;

                var path = Path.Combine("wwwroot", "images", newFileName);


                using (var filestream = new FileStream(path, FileMode.Create))
                {
                    dto.Image.CopyTo(filestream);
                }


                dto.ImageFileName = newFileName;

            }

            _handler.HandleCommand(command, dto);
            return StatusCode(201);
        }

        private IEnumerable<string> SupportedExtension => new List<string> { ".Png",".jpg",".jpeg" };

        // PUT api/<CategoriesController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {

        }

        // DELETE api/<CategoriesController>/5


        /// <summary>
        /// Delete a category and all its products. Only authorized can delete.
        /// </summary>
        /// <response code="204">Successful delete.</response>
        /// <response code="404">Not found.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpDelete("{id}")]
        public IActionResult Delete(int id, [FromServices] IDeleteCategoriesCommand command)
        {
            _handler.HandleCommand(command, id);
            return NoContent();
        }
    }
}
