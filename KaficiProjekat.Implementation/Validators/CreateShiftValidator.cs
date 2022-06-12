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
    public class CreateShiftValidator : AbstractValidator<CreateShiftDTO>
    {
        private KaficiProjekatDbContext _context;

        public CreateShiftValidator(KaficiProjekatDbContext context)
        {
            RuleFor(x => x.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Name is required.")
                .MinimumLength(3).WithMessage("Minimum length for a shift name is 3.")
                .Must(ShiftNotInUse).WithMessage("Name: {PropertyValue} is already in use");

            _context = context;
        }

        private bool ShiftNotInUse(string name)
        {
            var exists = _context.Shifts.Any(x => x.Name == name);

            return !exists;
        }
    }
}
