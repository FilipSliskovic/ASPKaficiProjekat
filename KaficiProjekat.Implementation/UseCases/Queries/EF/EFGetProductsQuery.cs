using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.DTO.Searches;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Queries.EF
{
    public class EFGetProductsQuery : EfUseCase, IGetProductsQuery
    {
        public EFGetProductsQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 28;

        public string Name => "Get products";

        public string Description => "Get products with EF-";

        public PagedResponse<ProductDTO> Execute(BasePagedSearch search)
        {

            var query = Context.Products.Where(x => x.IsActive == true).Include(x=>x.Images).Where(x => x.IsActive == true).Include(x=>x.Category).Where(x => x.IsActive == true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Name.Contains(search.Keyword) || x.Description.Contains(search.Keyword));
            }

            if (search.PerPage == null || search.PerPage < 1)
            {
                search.PerPage = 15;
            }


            if (search.Page == null || search.Page < 1)
            {
                search.Page = 1;
            }

            var toSkip = (search.Page.Value - 1) * search.PerPage.Value;

            var response = new PagedResponse<ProductDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new ProductDTO
            {
                Id = x.Id,
                Description = x.Description,
                Price = x.Price,
                Name = x.Name,
                CategoryName = x.Category.Name,
                ImageNames = x.Images.Select(x=>x.Path),
                Amount = x.Amount
                
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;


        }
    }
}
