using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class SuperUserDTO : BaseDTO
    {
    }

    public class UpdateSuperUserDTO
    {
        public int UserId { get; set; }
        public bool GiveSuperUser { get; set; }

    }
}
