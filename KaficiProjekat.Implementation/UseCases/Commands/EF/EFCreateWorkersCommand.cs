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
    public class EFCreateWorkersCommand : EfUseCase, ICreateWorkersCommand
    {

        private CreateWorkersValidator _validator;

        public EFCreateWorkersCommand(KaficiProjekatDbContext context, CreateWorkersValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 10;

        public string Name => "Create WorkersInCafe";

        public string Description => "Give a worker shift in cafe on a given date";

        public void Execute(CreateWorkersDTO request)
        {

            _validator.ValidateAndThrow(request);

            var userShift = new UserShift
            {
                UserId = request.UserId,
                ShiftId = request.ShiftId
            };

            Context.UserShifts.Add(userShift);

            

            var workersInCafe = new WhoWorksWhenAndWhere
            {
                CafeId = request.CafeId,
                UserShift = userShift,
                Date = request.Date,
                
            };

            Context.WorkersInCafe.Add(workersInCafe);

            Context.SaveChanges();

        }
    }
}
