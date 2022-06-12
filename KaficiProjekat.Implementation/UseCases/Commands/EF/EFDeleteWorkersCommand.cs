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
    public class EFDeleteWorkersCommand : EfUseCase, IDeleteWorkersCommand
    {
        public EFDeleteWorkersCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 11;

        public string Name => "Deactivate workers";

        public string Description => "Deactivate from workers with EF";

        public void Execute(int request)
        {

            if (Context.WorkersInCafe.Find(request) == null)
            {
                throw new EntityNotFoundException("Workers", request);
            }


            Context.Deactivate<WhoWorksWhenAndWhere>(request);

            Context.SaveChanges();

        }
    }
}
