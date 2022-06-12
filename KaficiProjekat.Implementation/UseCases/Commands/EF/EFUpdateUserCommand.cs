using FluentValidation;
using KaficiProjekat.Application.Exceptions;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFUpdateUserCommand : EfUseCase, IUpdateUserCommand
    {

        private UpdateUserValidator _validator;

        public EFUpdateUserCommand(KaficiProjekatDbContext context, UpdateUserValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 40;

        public string Name => "Update User";

        public string Description => "Update user";

        public void Execute(UpdateUserDTO request)
        {

            _validator.ValidateAndThrow(request);





            var user = Context.Users.Find(request.Id);





            if (request.Name != null)
            {
                user.Name = request.Name;
            }
            if (request.LastName != null)
            {
                user.LastName = request.LastName;
            }
            if (request.UserName != null)
            {
                user.UserName = request.UserName;
            }


            if (request.Password != null)
            {
                user.Password = request.Password;
            }



            List<UserUseCase> updateUser = new List<UserUseCase>();

            if (user == null)
            {
                throw new EntityNotFoundException("User", request.Id);
            }

            if (user.IsSuperUser)
            {
                throw new UseCaseConflictException("This is a Super user");

            }



            var users = Context.UserUseCase.Where(x => x.UserId == request.Id && request.UseCaseIDs.Equals(x.UseCaseId));
            
            Context.UserUseCase.RemoveRange(users);

           
                for (int i = 0; i < request.UseCaseIDs.Count(); i++)
                {
                    updateUser.Add(new UserUseCase
                    {
                        UserId = request.Id,
                        UseCaseId = request.UseCaseIDs.ElementAt(i)
                    });;
                }
                
                Context.UserUseCase.AddRange(updateUser);

            

            Context.SaveChanges();


        }
    }
}
