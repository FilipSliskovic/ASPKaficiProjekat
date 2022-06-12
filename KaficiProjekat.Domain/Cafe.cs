using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Cafe : Entity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Adress { get; set; }

        public ICollection<CafeProduct> CafeProducts { get; set; } = new List<CafeProduct>();
        public ICollection<WhoWorksWhenAndWhere> WorkersInCafe { get; set; } = new List<WhoWorksWhenAndWhere>();
        public ICollection<Table> Tables { get; set; } = new List<Table>();
    }
}
