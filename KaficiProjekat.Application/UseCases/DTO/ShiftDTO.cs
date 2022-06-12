using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class ShiftDTO : BaseDTO
    {
        public string Name { get; set; }
        public bool IsActive { get; set; }


    }

    public class CreateShiftDTO
    {
        public string Name { get; set; }
    }
    public class DeleteShiftDTO 
    {
        public int Id { get; set; }

    }

}
