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
    public class EFCreateCategoryCommand : EfUseCase, ICreateCategoryCommand
    {

        private CreateCategoyValidator _validator;

        public EFCreateCategoryCommand(KaficiProjekatDbContext context, CreateCategoyValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 24;

        public string Name => "Create category";

        public string Description => "Create category with EF";

        public void Execute(CreateCategoryDTO request)
        {

            _validator.ValidateAndThrow(request);

            var category = new Category
            {
                Name = request.Name,
                ParentId = request.ParentCategoryId
            };

            if (!string.IsNullOrEmpty(request.ImageFileName))
            {
                var image = new Image
                {
                    Path = request.ImageFileName
                };
                category.Image = image;
            }

            Context.Categories.Add(category);
            Context.SaveChanges();





        }
    }
}
