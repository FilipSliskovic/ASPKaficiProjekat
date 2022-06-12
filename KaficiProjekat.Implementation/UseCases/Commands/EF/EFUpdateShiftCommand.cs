using FluentValidation;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.DataAccess.Exceptions;
using KaficiProjekat.Implementation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFUpdateShiftCommand :EfUseCase, IUpdateShiftCommand
    {
        private UpdateShiftValidator _validator;
        public EFUpdateShiftCommand(KaficiProjekatDbContext context, UpdateShiftValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 4;

        public string Name => "Update Shift";

        public string Description => "Update shift using EF";

        public void Execute(ShiftDTO request)
        {

            _validator.ValidateAndThrow(request);

            var shiftToUpdate = Context.Shifts.Find(request.Id);

            if (shiftToUpdate == null)
            {
                throw new EntityNotFoundException();
            }

            shiftToUpdate.IsActive = request.IsActive;
            shiftToUpdate.Name = request.Name;

            Context.SaveChanges();

        }
    }
}
