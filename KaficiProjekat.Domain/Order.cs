using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Order : Entity
    {
        public int TableId { get; set; }
        public DateTime DateAndTime { get; set; }



        public Table Table { get; set; }
        public ICollection<CafeProductOrder> CafeProductOrders { get; set; } = new List<CafeProductOrder>();
    }
}
