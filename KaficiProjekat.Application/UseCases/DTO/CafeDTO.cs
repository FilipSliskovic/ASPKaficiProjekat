using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class CafeDTO :BaseDTO
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Adress { get; set; }
        public bool IsActive { get; set; }

    }

    public class CreateCafeDTO
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Adress { get; set; }

    }

    public class GetSingleCafeDTO
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Adress { get; set; }
        public IEnumerable<ProductDTO> Products { get; set; }
        public IEnumerable<WorkersDTO> Workers { get; set; }
        public IEnumerable<TableDTO> Tables { get; set; }
        
    }
}
