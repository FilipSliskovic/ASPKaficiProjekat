using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class CafeProductDTO : BaseDTO
    {
        public string CafeName { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public string Amount { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        
    }

    public class CreateCafeProductDTO
    {
        public int ProductID { get; set; }
        public int CafeID { get; set; }

    }
}
