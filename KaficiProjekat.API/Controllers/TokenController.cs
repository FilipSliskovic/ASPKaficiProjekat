using KaficiProjekat.API.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace KaficiProjekat.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TokenController : ControllerBase
    {

        private readonly JwtManager _manager;

        public TokenController(JwtManager manager)
        {
            _manager = manager;
        }



        // POST api/<TokenController>


        /// <summary>
        /// Generate a new JWT. 
        /// </summary>
        /// <response code="200">Successful.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="500">Unexpected server error.</response>

        [HttpPost]
        [AllowAnonymous]
        public IActionResult Post([FromBody] TokenRequest request)
        {

            try
            {
                var token = _manager.MakeToken(request.Username, request.Password);

                return Ok(new { token });
            }
            catch (UnauthorizedAccessException)
            {
                return Unauthorized();
            }
            catch (System.Exception )
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }

        }

       
    }


    public class TokenRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
