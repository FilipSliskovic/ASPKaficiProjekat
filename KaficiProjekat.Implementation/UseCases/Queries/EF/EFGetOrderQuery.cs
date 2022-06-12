using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Queries.EF
{
    public class EFGetOrderQuery : EfUseCase, IGetOrderQuery
    {

        private IAplicationUser _konobar;

        public EFGetOrderQuery(KaficiProjekatDbContext context, IAplicationUser konobar) : base(context)
        {
            _konobar = konobar;
        }

        public int Id => 35;

        public string Name => "Make a reciept";

        public string Description => "Makes a reciept with EF";

        public SingleOrderDTO Execute(int search)
        {
            var orderProducts = Context.CafeProductOrder.Where(x => x.OrderId == search && x.IsActive == true);




            var order = new SingleOrderDTO
            {
                CafeName = orderProducts.Select(x => x.CafeProduct.Cafe.Name).First(),
                CafeAdress = orderProducts.Select(x => x.CafeProduct.Cafe.Adress).First(),
                DateAndTime = DateTime.UtcNow,
                Konobar = _konobar.Identity,
                OrderId = search,
                TableName = orderProducts.Select(x => x.Order.Table.Name).First(),
                CafeProductOrders = orderProducts.Select(y => new ProizvodiDTO
                {
                    ProductName = y.ProductName,
                    ProductAmount = y.ProductAmount,
                    ProductPricePer = y.ProductPrice.Value,
                    ProductPriceTotal = y.ProductAmount * y.ProductPrice.Value
                }),
                TotalOrderPrice = orderProducts.Sum(x => x.ProductPrice.Value * x.ProductAmount)
            };


            return order;
        }
    }
}
