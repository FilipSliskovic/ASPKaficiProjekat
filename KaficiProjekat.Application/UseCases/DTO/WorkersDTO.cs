using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class WorkersDTO : BaseDTO
    {
        public string WorkerName { get; set; }
        public string WorkerLastName { get; set; }
        public string ShiftName { get; set; }
        public DateTime Date { get; set; }
        public bool IsActive { get; set; }
        public string CafeName { get; set; }

    }

    public class CreateWorkersDTO
    {
        public int UserId { get; set; }
        public int ShiftId { get; set; }
        public int CafeId { get; set; }
        public DateTime Date { get; set; }

    }
}
