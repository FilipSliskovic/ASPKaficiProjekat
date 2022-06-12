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
    public class EFDeleteCategoryCommand : EfUseCase, IDeleteCategoriesCommand
    {
        public EFDeleteCategoryCommand(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 26;

        public string Name => "Delete a category";

        public string Description => "Delete a category and all its products";

        public void Execute(int request)
        {

            if (Context.Categories.Find(request) == null)
            {
                throw new EntityNotFoundException("Category", request);
            }


            var products = Context.Products.Where(x => x.CategoryId == request);
            List<int> productIDs = products.Select(x => x.Id).ToList();

            if (productIDs != null)
            {
                Context.Deactivate<Product>(productIDs);
            }



            

            Context.Deactivate<Category>(request);

            Context.SaveChanges();


        }
    }
}
