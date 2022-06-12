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
    public class EFCreateShiftCommand : EfUseCase, ICreateShiftCommand
    {
        private CreateShiftValidator _validator;
        public EFCreateShiftCommand(KaficiProjekatDbContext context, CreateShiftValidator validator ) : base(context)
        {
            _validator = validator;
        }

        public int Id => 2;

        public string Name => "Create Shift EF";

        public string Description => "Create shift using EF";

        public void Execute(CreateShiftDTO request)
        {
            _validator.ValidateAndThrow(request);

            var shift = new Shift
            {
                Name = request.Name,
            };

            Context.Shifts.Add(shift);

            Context.SaveChanges();
        }
    }
}
