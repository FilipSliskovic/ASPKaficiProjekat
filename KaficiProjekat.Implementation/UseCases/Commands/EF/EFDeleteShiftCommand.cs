using FluentValidation;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation.Validators;
using KaficiProjekat.DataAccess.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using KaficiProjekat.Application.Exceptions;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFDeleteShiftCommand : EfUseCase, IDeleteShiftCommand
    {
        private DeleteShiftValidator _validator;

        public EFDeleteShiftCommand(KaficiProjekatDbContext context,DeleteShiftValidator valdator) : base(context)
        {
            _validator = valdator;
        }

        public int Id => 3;

        public string Name => "Deactivate shift";

        public string Description => "Deactivate shift with EF";

        public void Execute(int request)
        {

            //_validator.ValidateAndThrow(request);

            if (Context.Shifts.Find(request) == null)
            {
                throw new EntityNotFoundException("Shifts", request);
            }


            Context.Deactivate<Shift>(request);

            Context.SaveChanges();
        }
    }
}
