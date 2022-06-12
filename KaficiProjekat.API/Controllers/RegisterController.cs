using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Implementation;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace KaficiProjekat.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
        
    public class RegisterController : ControllerBase
    {

        private readonly UseCaseHandler _handler;
        private readonly IRegisterUserCommand _command;

        public RegisterController(
            UseCaseHandler handler,
            IRegisterUserCommand command)
        {
            _handler = handler;
            _command = command;
        }


        // POST api/<RegisterController>

        /// <summary>
        /// Register new user and sends an email*. Everyone can register.
        /// </summary>
        /// <response code="201">Successful register.</response>
        /// <response code="401">Unauthorized.</response>
        /// <response code="409">Conflict if User already exists.</response>
        /// <response code="500">Unexpected server error, email needs secure connection.</response>



        [HttpPost]
        [AllowAnonymous]
        public IActionResult Post([FromBody] RegisterDTO dto)
        {
            _handler.HandleCommand(_command,dto);

            return StatusCode(201);
        }

    }
}
