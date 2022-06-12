using KaficiProjekat.Application.Exceptions;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFUpdateOrderCommand : EfUseCase, IUpdateOrderCommand
    {
        public EFUpdateOrderCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 21;

        public string Name => "Update Order ";

        public string Description => "Update order with EF";

        public void Execute(UpdateOrderDTO request)
        {

            var orderToUpdate = Context.Orders.Find(request.ID);

            if (orderToUpdate == null)
            {
                throw new EntityNotFoundException("Order",request.ID);
            }

            if (Context.Tables.Find(request.Tableid) == null)
            {
                throw new EntityNotFoundException("Table", request.Tableid);
            }

            orderToUpdate.IsActive = request.IsActive;

            orderToUpdate.TableId = request.Tableid;

            orderToUpdate.DateAndTime = request.DateAndTime;

            Context.SaveChanges();

        }
    }
}
