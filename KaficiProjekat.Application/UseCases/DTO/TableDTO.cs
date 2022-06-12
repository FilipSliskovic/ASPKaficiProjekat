using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class TableDTO :BaseDTO
    {
        public string Name { get; set; }
        public string CafeName { get; set; }
        public bool IsActive { get; set; }

    }

    public class CreateTableDTO
    {
        public string Name { get; set; }
        public int CafeId { get; set; }

    }

    public class UpradeTableDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool IsActive { get; set; }

    }
}
