
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.DTO
{
    public class CafeProductOrderDTO : BaseDTO
    {
        public CafeProductDTO CafeProducts { get; set; }
        public string TableName { get; set; }
        public DateTime DateAndTime { get; set; }
        public decimal TotalProductsPrice { get; set; }
        public int AmountOfProducts { get; set; }


    }

    public class SingleCafeProductOrderDTO
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

    public class ProizvodiDTO
    {
        public string ProductName { get; set; }
        public int ProductAmount { get; set; }
        public decimal ProductPricePer { get; set; }
        public decimal ProductPriceTotal { get; set; }


    }

    public class CreateCafeProductOrderDTO
    {
        public int CafeProductId { get; set; }
        public int OrderId { get; set; }
        public int ProductAmount { get; set; }

    }
}
