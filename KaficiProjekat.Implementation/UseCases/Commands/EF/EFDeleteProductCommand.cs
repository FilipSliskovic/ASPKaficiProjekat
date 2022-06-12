using KaficiProjekat.Application.Exceptions;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.DataAccess;
using KaficiProjekat.DataAccess.Extensions;
using KaficiProjekat.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFDeleteProductCommand : EfUseCase, IDeleteProductCommand
    {
        public EFDeleteProductCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 30;

        public string Name => "Delete a product";

        public string Description => "Delete a product with EF";

        public void Execute(int request)
        {

            if (Context.Products.Find(request) == null)
            {
                throw new EntityNotFoundException("Products", request);
            }


            var products = Context.CafeProducts.Where(x => x.ProductID == request);
            List<int> productIDs = products.Select(x => x.Id).ToList();

            if (productIDs != null)
            {
                Context.Deactivate<CafeProduct>(productIDs);
            }


            



            Context.Deactivate<Product>(request);
            Context.SaveChanges();
        }
    }
}
