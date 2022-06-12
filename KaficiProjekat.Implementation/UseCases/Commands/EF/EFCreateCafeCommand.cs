using FluentValidation;
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
    public class EFCreateCafeCommand : EfUseCase, ICreateCafeCommand
    {
        private CreateCafeValidator _validator;

        public EFCreateCafeCommand(KaficiProjekatDbContext context, CreateCafeValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 13;

        public string Name => "Create a cafe";

        public string Description => "Create cafe using EF";

        public void Execute(CreateCafeDTO request)
        {
            _validator.ValidateAndThrow(request);

            

            var cafe = new Cafe
            {
                Adress = request.Adress,
                Name = request.Name,
                Description = request.Description
            };

            Context.Cafes.Add(cafe);
            Context.SaveChanges();


        }
    }
}
