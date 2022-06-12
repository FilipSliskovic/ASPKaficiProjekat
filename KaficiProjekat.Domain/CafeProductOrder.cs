using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class CafeProductOrder : Entity
    {
        public int CafeProductId { get; set; }
        public int OrderId { get; set; }
        public string ProductName { get; set; }
        public decimal? ProductPrice { get; set; }
        public int ProductAmount { get; set; }


        public CafeProduct CafeProduct { get; set; }
        public Order Order { get; set; }


    }
}
