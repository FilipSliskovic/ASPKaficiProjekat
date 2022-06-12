using KaficiProjekat.Application.UseCases.DTO;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace KaficiProjekat.API.DTO
{
    public class CreateProductApiDTO : CreateProductDTO
    {
        public IFormFile Image { get; set; }

    }
}
