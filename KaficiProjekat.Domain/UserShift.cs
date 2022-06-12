using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class UserShift : Entity
    {
        public int UserId { get; set; }
        public int ShiftId { get; set; }

        public User User { get; set; }
        public Shift Shifts { get; set; }
    }
}
