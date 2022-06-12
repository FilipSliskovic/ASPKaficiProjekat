using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class CategoryDTO
    {
        public string Name { get; set; }
    }

    public class CreateCategoryDTO
    {
        public string ImageFileName { get; set; }

        public string Name { get; set; }
        public int? ParentCategoryId { get; set; }

    }
}
