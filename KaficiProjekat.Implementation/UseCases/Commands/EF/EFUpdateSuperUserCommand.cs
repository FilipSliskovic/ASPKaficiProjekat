using KaficiProjekat.Application.Exceptions;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFUpdateSuperUserCommand : EfUseCase, IUpdateSuperUserCommand
    {

        private IAplicationUser _user;

        public EFUpdateSuperUserCommand(KaficiProjekatDbContext context, IAplicationUser user) : base(context)
        {
            _user = user;
        }

        public int Id => 22;

        public string Name => "Update superuser";

        public string Description => "Update superusers with EF";

        public void Execute(UpdateSuperUserDTO request)
        {

            if (!_user.UseCaseIds.Contains(22))
            {
                throw new UseCaseConflictException("You dont have permission to Excecute: " + this.Name);
            }

            var user = Context.Users.Find(request.UserId);
            List<UserUseCase> updateSuperUser = new List<UserUseCase>();
            
            if (user== null)
            {
                throw new EntityNotFoundException("User",request.UserId);
            }

            if (user.IsSuperUser)
            {
                throw new UseCaseConflictException("User is already Super user");

            }

            var users = Context.UserUseCase.Where(x => x.UserId == request.UserId);
            user.IsSuperUser = false;
            Context.UserUseCase.RemoveRange(users);

            if (request.GiveSuperUser)
            {

                for (int i = 0; i < 100; i++)
                {
                    updateSuperUser.Add(new UserUseCase
                    {
                        UserId = request.UserId,
                        UseCaseId = i
                    });
                }
                user.IsSuperUser = true;
                Context.UserUseCase.AddRange(updateSuperUser);

            }

            Context.SaveChanges();

        }
    }
}
