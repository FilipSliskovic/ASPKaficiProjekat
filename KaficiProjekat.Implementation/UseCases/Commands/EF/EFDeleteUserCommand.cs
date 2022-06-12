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
    public class EFDeleteUserCommand : EfUseCase, IDeleteUserCommand
    {
        public EFDeleteUserCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 7;

        public string Name => "Deactivate user";

        public string Description => "Deactivate user using EF";

        public void Execute(int request)
        {

            if (Context.Users.Find(request) == null)
            {
                throw new EntityNotFoundException("Users", request);
            }


            Context.Deactivate<User>(request);

            Context.SaveChanges();
        }
    }
}
