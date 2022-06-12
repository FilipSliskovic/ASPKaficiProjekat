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
    public class CreateWorkersValidator : AbstractValidator<CreateWorkersDTO>
    {

        private KaficiProjekatDbContext _context;

        public CreateWorkersValidator(KaficiProjekatDbContext context)
        {
            _context = context;

            RuleFor(x => x.Date)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Datum je obavezan podatak.")
                .GreaterThan(DateTime.Now);
        }
    }
}
