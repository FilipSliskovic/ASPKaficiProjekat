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
    public class EFGetCafeProductOrderQuery : EfUseCase, IGetCafeProductOrderQuery
    {
        private IAplicationUser _konobar;

        public EFGetCafeProductOrderQuery(KaficiProjekatDbContext context, IAplicationUser konobar) : base(context)
        {
            this._konobar = konobar;
        }

        public int Id => 35;

        public string Name => "Get all products from an order with its total price";

        public string Description => "get order with EF";

        public CafeProductOrder Execute(int search)
        {

            //var orderProducts = Context.CafeProductOrder.Where(x => x.OrderId == search && x.IsActive == true);


            //var order = new SingleCafeProductOrderDTO
            //{
            //    CafeName = orderProducts.Select(x => x.CafeProduct.Cafe.Name).First(),
            //    CafeAdress = orderProducts.Select(x => x.CafeProduct.Cafe.Adress).First(),
            //    DateAndTime = DateTime.UtcNow,
            //    Konobar = _konobar.Identity,
            //    OrderId = search,
            //    TableName = orderProducts.Select(x => x.Order.Table.Name).First(),
            //    CafeProductOrders = orderProducts.Select(y => new ProizvodiDTO
            //    {
            //        ProductName = y.ProductName,
            //        ProductAmount = y.ProductAmount,
            //        ProductPricePer = y.ProductPrice.Value,
            //        ProductPriceTotal = y.ProductAmount * y.ProductPrice.Value
            //    }),
            //    TotalOrderPrice = orderProducts.Sum(x=>x.ProductPrice.Value * x.ProductAmount)
            //};

            //return order;
            var cafeproductorder = Context.CafeProductOrder.Find(search);

            

            return cafeproductorder;


        }
    }
}
