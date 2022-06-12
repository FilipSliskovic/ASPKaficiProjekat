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
    public class EFGetOrdersQuery : EfUseCase, IGetOrdersQuery
    {
        public EFGetOrdersQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 19;

        public string Name => "Get orders";

        public string Description => "Get orders with EF";

        public PagedResponse<OrdersDTO> Execute(BasePagedSearch search)
        {

            var query = Context.Orders.Where(x => x.IsActive == true).Include(x => x.Table).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Table.Name.Contains(search.Keyword));
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

            var response = new PagedResponse<OrdersDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new OrdersDTO
            {
                DateAndTime = x.DateAndTime,
                IsActive = x.IsActive,
                TableName = x.Table.Name
                
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;

        }
    }
}
