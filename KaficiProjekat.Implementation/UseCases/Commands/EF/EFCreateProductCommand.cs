using FluentValidation;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFCreateProductCommand : EfUseCase, ICreateProductCommand
    {

        private CreateProductValidator _validator;

        public EFCreateProductCommand(KaficiProjekatDbContext context, CreateProductValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 29;

        public string Name => "Create a new product";

        public string Description => "Create a new product with EF";

        public void Execute(CreateProductDTO request)
        {

            _validator.ValidateAndThrow(request);


            var product = new Product
            {
                Name = request.Name,
                Amount = request.Amount,
                Price = request.Price,
                Description = request.Description,
                CategoryId = request.CategoryID
            };

            if (!string.IsNullOrEmpty(request.ImageFileName))
            {
                var image = new Image
                {
                    Path = request.ImageFileName
                };
                product.Images.Add(image);
            }

            Context.Products.Add(product);
            Context.SaveChanges();



        }
    }
}
