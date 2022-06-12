using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class CafeProduct : Entity
    {
        public int CafeId { get; set; }
        public int ProductID { get; set; }

        public Product Product { get; set; }
        public Cafe Cafe { get; set; }
        public ICollection<CafeProductOrder> CafeProductOrders { get; set; } = new List<CafeProductOrder>();



    }
}
