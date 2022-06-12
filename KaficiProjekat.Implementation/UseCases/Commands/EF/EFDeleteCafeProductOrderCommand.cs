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
    public class EFDeleteCafeProductOrderCommand : EfUseCase, IDeleteCafeProductOrderCommand
    {
        public EFDeleteCafeProductOrderCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 37;

        public string Name => "Delete Cafe Product Order";

        public string Description => "delete cafe producto order with EF";

        public void Execute(int request)
        {

            if (Context.CafeProductOrder.Find(request) == null)
            {
                throw new EntityNotFoundException("Cafe Product Order", request);
            }

            Context.Deactivate<CafeProductOrder>(request);

            Context.SaveChanges();
        }
    }
}
