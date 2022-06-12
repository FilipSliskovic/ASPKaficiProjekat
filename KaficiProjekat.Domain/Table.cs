using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Table : Entity
    {
        public string Name { get; set; }
        public int Seats { get; set; }
        public int CafeId { get; set; }

        public Cafe Cafe { get; set; }


    }
}
