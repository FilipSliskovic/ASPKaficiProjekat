using FluentValidation;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.Validators
{
    public class CreateProductValidator : AbstractValidator<CreateProductDTO>
    {
        private KaficiProjekatDbContext _context;


        public CreateProductValidator(KaficiProjekatDbContext context)
        {
            RuleFor(x => x.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Name is required.")
                .MinimumLength(3).WithMessage("Minimum length for a shift name is 3.")
                .Must(NameNotInUse).WithMessage("Name: {PropertyValue} is already in use");

            RuleFor(x => x.Description)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Description is required.")
                .MinimumLength(3).WithMessage("Minimum length for a description is 3.");

            RuleFor(x => x.Amount)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Adress is required.");

            RuleFor(x => x.Price)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Price is required.")
                .GreaterThan(0).WithMessage("Price must be above 0");

            RuleFor(x => x.CategoryID)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Category is required.");

            

            _context = context;
        }

        private bool NameNotInUse(string name)
        {


            var exists = _context.Cafes.Any(x => x.Name == name);

            return !exists;
        }

        
    }
}
