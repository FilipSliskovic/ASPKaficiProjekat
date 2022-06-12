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
    public class CreateOrderValidator : AbstractValidator<CreateOrderDTO>
    {
        private KaficiProjekatDbContext _context;

        public CreateOrderValidator(KaficiProjekatDbContext context)
        {
            RuleFor(x => x.DateAndTime)
                .Cascade(CascadeMode.Stop)
                .GreaterThan(DateTime.Now);
            _context = context;

        }
    }
}
