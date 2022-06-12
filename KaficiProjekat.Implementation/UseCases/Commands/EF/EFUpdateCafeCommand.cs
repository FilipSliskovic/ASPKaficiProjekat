using FluentValidation;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Implementation.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFUpdateCafeCommand : EfUseCase, IUpdateCafeCommand
    {
        private UpdateCafeValidator _validator;
        public EFUpdateCafeCommand(KaficiProjekatDbContext context, UpdateCafeValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 14;

        public string Name => "Update a cafe";

        public string Description => "Update cafe using EF";

        public void Execute(CafeDTO request)
        {

            _validator.ValidateAndThrow(request);

            var cafeToUpdate = Context.Cafes.Find(request.Id);



            cafeToUpdate.IsActive = request.IsActive;
            if (request.Name != null)
            {
                cafeToUpdate.Name = request.Name;
            }
            if (request.Description !=null)
            {
                cafeToUpdate.Description = request.Description;
            }
            if (request.Adress != null)
            {
                cafeToUpdate.Adress = request.Adress;
            }
            


            Context.SaveChanges();
        }
    }
}
