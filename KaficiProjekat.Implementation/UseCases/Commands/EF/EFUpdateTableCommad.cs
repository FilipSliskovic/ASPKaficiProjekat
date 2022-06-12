using FluentValidation;
using KaficiProjekat.Application.Exceptions;
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
    public class EFUpdateTableCommad : EfUseCase, IUpdateTableCommand
    {
        private UpdateTableValidator _validator;
        public EFUpdateTableCommad(KaficiProjekatDbContext context, UpdateTableValidator validator) : base(context)
        {
            _validator = validator;
        }

        public int Id => 17;

        public string Name => "Update table table :)";

        public string Description => "Update table tables using EF";

        public void Execute(UpradeTableDTO request)
        {

            _validator.ValidateAndThrow(request);

            var table = Context.Tables.Find(request.Id);

            if (table == null)
            {
                throw new EntityNotFoundException("Table",request.Id);
            }

            if (request.Name != null)
            {
                table.Name = request.Name;
            }



            
            table.IsActive = request.IsActive;

            Context.SaveChanges();
        }
    }
}
