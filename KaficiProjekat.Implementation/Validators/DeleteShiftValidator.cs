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
    public class DeleteShiftValidator : AbstractValidator<DeleteShiftDTO>
    {
        private KaficiProjekatDbContext _context;

        public DeleteShiftValidator(KaficiProjekatDbContext context)
        {

            RuleFor(x => x.Id)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("ID is required.");

            _context = context;
        }
    }
}
