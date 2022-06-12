using KaficiProjekat.Application.Exceptions;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.DataAccess;
using KaficiProjekat.DataAccess.Extensions;
using KaficiProjekat.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFDeleteOrderCommand : EfUseCase, IDeleteOrderCommand
    {
        public EFDeleteOrderCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 39;

        public string Name => "Delete order";

        public string Description => "delete order with ef";

        public void Execute(int request)
        {
            var order = Context.Orders.Find(request);

            if (order == null)
            {
                throw new EntityNotFoundException("Order", request);


            }

            Context.Deactivate<Order>(request);

            Context.SaveChanges();
        }
    }
}
