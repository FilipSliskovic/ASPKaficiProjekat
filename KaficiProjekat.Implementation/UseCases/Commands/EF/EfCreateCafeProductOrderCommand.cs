using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EfCreateCafeProductOrderCommand : EfUseCase, ICreateCafeProductOrderCommand
    {
        public EfCreateCafeProductOrderCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 36;

        public string Name => "Add cafeproduct to an order";

        public string Description => "add cafeproduct to an order with EF";

        public void Execute(CreateCafeProductOrderDTO request)
        {
            
            var cafeProduct = Context.CafeProducts.Find(request.CafeProductId);
            var product = Context.Products.Find(cafeProduct.ProductID);
            var productPrice = product.Price;
            var productName = product.Name;


            if (Context.CafeProductOrder.Any(x=>x.CafeProductId == request.CafeProductId && x.OrderId == request.OrderId && x.IsActive == true))
            {
                var cafeProductOrderAdd = Context.CafeProductOrder.Where(x => x.CafeProductId == request.CafeProductId && x.OrderId == request.OrderId && x.IsActive == true).First();

                cafeProductOrderAdd.ProductAmount += request.ProductAmount;
                cafeProductOrderAdd.ProductPrice = productPrice ;

            }
            else
            {

                var cafeproductorder = new CafeProductOrder()
                {
                    CafeProductId = request.CafeProductId,
                    OrderId = request.OrderId,
                    ProductAmount = request.ProductAmount,
                    ProductName = productName,
                    ProductPrice = productPrice * request.ProductAmount
                };

                Context.CafeProductOrder.Add(cafeproductorder);


            }

            

            Context.SaveChanges();



        }
    }
}
