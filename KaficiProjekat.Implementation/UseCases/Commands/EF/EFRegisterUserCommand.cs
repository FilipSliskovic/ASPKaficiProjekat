using FluentValidation;
using KaficiProjekat.Application.Emails;
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
    public class EFRegisterUserCommand : EfUseCase,IRegisterUserCommand
    {


        private readonly RegisterUserValidator _validator;
        private readonly IEmailSender _sender;

        public EFRegisterUserCommand(KaficiProjekatDbContext context, RegisterUserValidator validator, IEmailSender sender) : base(context)
        {
            _validator = validator;
            _sender = sender;
        }

        public void Execute(RegisterDTO request)
        {
            _validator.ValidateAndThrow(request);

            var hash = BCrypt.Net.BCrypt.HashPassword(request.Password);

            var user = new User
            {
                UserName = request.UserName,
                
                Password = hash,
                Name = request.Name,
                LastName = request.LastName
            };

            Context.Users.Add(user);
            Context.SaveChanges();

            //slanje email-a za verifikaciju ne radi zbog security

            _sender.Send(new EmailDTO
            {
                To = request.UserName,
                Title = "Successfull registration!",
                Body = "Dear " + request.Name + "\n Please activate your account...."
            });
        }


        public int Id => 8;

        public string Name => "User reigstration (Using EF)";

        public string Description => "";


    }
}
