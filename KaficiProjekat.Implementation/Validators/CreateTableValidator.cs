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
    public class CreateTableValidator : AbstractValidator<CreateTableDTO>
    {
        private KaficiProjekatDbContext _context;

        public CreateTableValidator(KaficiProjekatDbContext context)
        {
            RuleFor(x => x.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Name is required.");
                //.Must(NameAlreadyInUse).WithMessage("Name: {PropertyValue} is already in use");
            RuleFor(x => x.CafeId)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Cafe id is required");
            _context = context;
        }

        private bool NameAlreadyInUse(string name)
        {
            var exists = _context.Tables.Any(x => x.Name == name);

            return !exists;
        }
    }
}
