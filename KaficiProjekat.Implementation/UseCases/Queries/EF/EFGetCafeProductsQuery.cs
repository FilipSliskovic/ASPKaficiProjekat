using KaficiProjekat.Application.UseCases;
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
    public class EFGetCafeProductsQuery : EfUseCase, IGetCafeProductsQuery
    {
        public EFGetCafeProductsQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 31;

        public string Name => "Get cafe products";

        public string Description => "get cafe products with ef";

        public PagedResponse<CafeProductDTO> Execute(BasePagedSearch search)
        {
            var query = Context.CafeProducts.Where(x=>x.IsActive == true).Include(x=>x.Product).ThenInclude(x=>x.Category).Where(x=>x.IsActive == true).Include(x=>x.Cafe).Where(x=>x.IsActive == true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Product.Name.Contains(search.Keyword) || x.Product.Description.Contains(search.Keyword) || x.Product.Amount.Contains(search.Keyword) || x.Cafe.Name.Contains(search.Keyword) || x.Product.Category.Name.Contains(search.Keyword));
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

            var response = new PagedResponse<CafeProductDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new CafeProductDTO
            {
                Id = x.Id,
                CafeName = x.Cafe.Name,
                ProductName = x.Product.Name,
                Category = x.Product.Category.Name,
                Description = x.Product.Description,
                Price = x.Product.Price,
                Amount = x.Product.Amount
                

            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;
        }
    }
}
