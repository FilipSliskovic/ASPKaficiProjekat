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
    public class UpdateTableValidator : AbstractValidator<UpradeTableDTO>
    {

        private KaficiProjekatDbContext _context;

        public UpdateTableValidator(KaficiProjekatDbContext context)
        {
            _context = context;

            RuleFor(x => x.Name)
                .Cascade(CascadeMode.Stop)
                .Must(NameNotInUse).WithMessage("Name: {PropertyValue} is already in use");

            
        }

        private bool NameNotInUse(string name)
        {
            var exists = _context.Tables.Any(x => x.Name == name);

            return !exists;
        }
    }
}
