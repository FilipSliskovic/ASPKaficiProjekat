using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class WhoWorksWhenAndWhere : Entity
    {
        public int UserShiftId { get; set; }
        public int CafeId { get; set; }
        public DateTime Date { get; set; }

        public UserShift UserShift { get; set; }
        public Cafe Cafe { get; set; }
    }
}
