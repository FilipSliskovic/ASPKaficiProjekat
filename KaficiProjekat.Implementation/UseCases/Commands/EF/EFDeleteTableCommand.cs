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
    public class EFDeleteTableCommand : EfUseCase, IDeleteTableCommand
    {
        public EFDeleteTableCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 18;

        public string Name => "Delete table";

        public string Description => "delete table with EF";

        public void Execute(int request)
        {

            if (Context.Tables.Find(request) == null)
            {
                throw new EntityNotFoundException("Table", request);
            }


            Context.Deactivate<Table>(request);

            Context.SaveChanges();
        }
    }
}
