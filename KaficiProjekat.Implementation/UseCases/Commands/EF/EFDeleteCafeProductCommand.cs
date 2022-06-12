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
    public class EFDeleteCafeProductCommand : EfUseCase, IDeleteCafeProductCommand
    {
        public EFDeleteCafeProductCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 33;

        public string Name => "Delete a product from cafe's menu";

        public string Description => "Delete a product from cafe's menu with EF";

        public void Execute(int request)
        {

            if (Context.CafeProducts.Find(request) == null)
            {
                throw new EntityNotFoundException("CafeProducts", request);
            }

            Context.Deactivate<CafeProduct>(request);
        }
    }
}
