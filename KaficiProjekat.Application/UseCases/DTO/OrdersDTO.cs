using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class OrdersDTO 
    {
        public string TableName { get; set; }
        public DateTime DateAndTime { get; set; }
        public bool IsActive { get; set; }

    }
    public class CreateOrderDTO
    {
        public int TableId { get; set; }
        public DateTime DateAndTime { get; set; } = DateTime.Now.AddMinutes(1);

    }

    public class UpdateOrderDTO
    {
        public int ID { get; set; }
        public int Tableid { get; set; }
        public DateTime DateAndTime { get; set; }
        public bool IsActive { get; set; }



    }


    public class SingleOrderDTO
    {
        public int OrderId { get; set; }
        public string Konobar { get; set; }
        public string CafeName { get; set; }
        public string CafeAdress { get; set; }
        public DateTime DateAndTime { get; set; }
        public string TableName { get; set; }


        public IEnumerable<ProizvodiDTO> CafeProductOrders { get; set; }
        public decimal TotalOrderPrice { get; set; }

    }
}
