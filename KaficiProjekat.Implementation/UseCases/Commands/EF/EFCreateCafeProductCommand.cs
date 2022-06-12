using KaficiProjekat.Application.Exceptions;
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
    public class EFCreateCafeProductCommand : EfUseCase, ICreateCafeProductCommand
    {
        public EFCreateCafeProductCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 32;

        public string Name => "Add product to Cafe's menu";

        public string Description => "Adds a product to Cafe's menu with EF";

        public void Execute(CreateCafeProductDTO request)
        {

            if (Context.Cafes.Find(request.CafeID) == null)
            {
                throw new EntityNotFoundException("Cafe",request.CafeID);
            }

            if (Context.Products.Find(request.ProductID) == null)
            {
                throw new EntityNotFoundException("Product", request.ProductID);
            }


            if (Context.CafeProducts.Any(x=> x.CafeId == request.CafeID && x.ProductID == request.ProductID))
            {
                throw new UseCaseConflictException("Cafe already has that product");
            }

            var CafeProduct = new CafeProduct
            {
                CafeId = request.CafeID,
                ProductID = request.ProductID
            };

            Context.CafeProducts.Add(CafeProduct);
            Context.SaveChanges();


        }
    }
}
