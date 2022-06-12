using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Product : Entity
    {
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Amount { get; set; }
        public string Description { get; set; }
        public int CategoryId { get; set; }

        public Category Category { get; set; }
        public ICollection<Image> Images { get; set; } = new List<Image>();

        public ICollection<CafeProduct> CafeProducts { get; set; }



    }
}
