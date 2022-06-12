using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class User : Entity
    {
        public string Name { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool IsSuperUser { get; set; }


        public ICollection<UserShift> UserShifts { get; set; } = new List<UserShift>();
        public ICollection<UserUseCase> UseCases { get; set; }
    }
}
