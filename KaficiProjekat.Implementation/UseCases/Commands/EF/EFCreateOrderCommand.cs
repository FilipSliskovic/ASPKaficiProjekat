using FluentValidation;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.DataAccess.Exceptions;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFCreateOrderCommand : EfUseCase, ICreateOrderCommand
    {

        private CreateOrderValidator _validator;

        public EFCreateOrderCommand(KaficiProjekatDbContext context, CreateOrderValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 20;

        public string Name => "Create a new order" ;

        public string Description => "Create order with EF";

        public void Execute(CreateOrderDTO request)
        {
            _validator.ValidateAndThrow(request);


            var table = Context.Tables.Find(request.TableId);

            if (table == null)
            {
                throw new EntityNotFoundException();
            }

            var order = new Order
            {
                DateAndTime = request.DateAndTime,
                TableId = request.TableId
            };

            Context.Orders.Add(order);
            Context.SaveChanges();

        }
    }
}
