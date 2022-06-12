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
    public class CreateCategoyValidator : AbstractValidator<CreateCategoryDTO>
    {
        private KaficiProjekatDbContext _context;

        public CreateCategoyValidator(KaficiProjekatDbContext context)
        {
            RuleFor(x => x.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Name is required.")
                .MinimumLength(3).WithMessage("Minimum length for a category name is 3.")
                .Must(CategoryNotInUse).WithMessage("Name: {PropertyValue} is already in use");

            _context = context;
        }

        private bool CategoryNotInUse(string name)
        {
            var exists = _context.Categories.Any(x => x.Name == name);

            return !exists;
        }
    }
}
