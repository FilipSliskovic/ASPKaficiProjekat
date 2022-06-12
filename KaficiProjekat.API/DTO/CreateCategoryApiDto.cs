using KaficiProjekat.Application.UseCases.DTO;
using Microsoft.AspNetCore.Http;

namespace KaficiProjekat.API.DTO
{
    public class CreateCategoryApiDto : CreateCategoryDTO
    {
        public IFormFile Image { get; set; }
    }
}
