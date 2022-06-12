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
    public class EFGetCafeProductOrdersQuery : EfUseCase, IGetCafeProductOrdersQuery
    {
        public EFGetCafeProductOrdersQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 34;

        public string Name => "Get Cafe Product Orders";

        public string Description => "Get Cafe Product Orders with EF";

        public PagedResponse<CafeProductOrderDTO> Execute(BasePagedSearch search)
        {


            var query = Context.CafeProductOrder.Where(x => x.IsActive == true)
                .Include(x => x.Order).ThenInclude(x => x.Table).Where(x => x.IsActive == true)
                .Include(x => x.CafeProduct).ThenInclude(x => x.Product).Where(x => x.IsActive == true)
                .Include(x => x.CafeProduct).ThenInclude(x => x.Cafe).Where(x => x.IsActive == true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.CafeProduct.Product.Name.Contains(search.Keyword) || 
                x.CafeProduct.Product.Description.Contains(search.Keyword) ||
                x.CafeProduct.Product.Amount.Contains(search.Keyword) ||
                x.CafeProduct.Cafe.Name.Contains(search.Keyword) || 
                x.CafeProduct.Product.Category.Name.Contains(search.Keyword));
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

            var response = new PagedResponse<CafeProductOrderDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new CafeProductOrderDTO
            {
                Id = x.Id,
                CafeProducts = new CafeProductDTO
                {
                    Id = x.CafeProduct.Id,
                    ProductName = x.CafeProduct.Product.Name,
                    Amount = x.CafeProduct.Product.Amount,
                    CafeName = x.CafeProduct.Cafe.Name,
                    Description = x.CafeProduct.Product.Description,
                    Category = x.CafeProduct.Product.Category.Name,
                    Price = x.CafeProduct.Product.Price

                },
                AmountOfProducts = x.ProductAmount,
                TableName = x.Order.Table.Name,
                TotalProductsPrice = x.ProductPrice.Value * x.ProductAmount,
                DateAndTime = x.Order.DateAndTime
                
                


            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;



        }
    }
}
