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
    public class EFDeleteCafeCommand : EfUseCase, IDeleteCafeCommand
    {
        public EFDeleteCafeCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 13;

        public string Name => "Deactivate a cafe";

        public string Description => "Deactivate cafe using EF";

        public void Execute(int request)
        {

            if (Context.Cafes.Find(request) == null)
            {
                throw new EntityNotFoundException("Cafe",request);
            }

            var products = Context.CafeProducts.Where(x => x.CafeId == request);
            List<int> productIDs = products.Select(x => x.Id).ToList();

            if (productIDs != null)
            {
                Context.Deactivate<CafeProduct>(productIDs);
            }



            var tables = Context.Tables.Where(x => x.CafeId == request);
            List<int> tableIDS = products.Select(x => x.Id).ToList();

            if (tableIDS != null)
            {
                Context.Deactivate<Table>(tableIDS);
            }


            var workers = Context.WorkersInCafe.Where(x => x.CafeId == request);
            List<int> workerIDS = workers.Select(x => x.Id).ToList();

            if (workerIDS != null)
            {
                Context.Deactivate<WhoWorksWhenAndWhere>(workerIDS);
            }


            Context.Deactivate<Cafe>(request);

            Context.SaveChanges();
        }
    }
}
