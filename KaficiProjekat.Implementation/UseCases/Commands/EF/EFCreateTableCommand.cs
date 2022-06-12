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
    public class EFCreateTableCommand : EfUseCase, ICreateTableCommand
    {

        private CreateTableValidator _validator;

        public EFCreateTableCommand(KaficiProjekatDbContext context, CreateTableValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 16;

        public string Name => "Create table";

        public string Description => "Create table using EF";

        public void Execute(CreateTableDTO request)
        {

            _validator.ValidateAndThrow(request);


            var cafe = Context.Cafes.Find(request.CafeId);

            if (cafe == null)
            {
                throw new EntityNotFoundException("Cafe",request.CafeId);
            }

            if (Context.Tables.Any(x=>x.Name == request.Name && x.CafeId == request.CafeId))
            {
                throw new UseCaseConflictException($"Table with Name: {request.Name} already exist in that cafe");
            }

            var table = new Table
            {
                CafeId = cafe.Id,
                Name = request.Name,

            };

            Context.Tables.Add(table);
            Context.SaveChanges();

        }
    }
}
