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
    public class EFGetTablesQuery : EfUseCase, IGetTablesQuery
    {
        public EFGetTablesQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 15;

        public string Name => "Get tables";

        public string Description => "Get tables with EF";

        public PagedResponse<TableDTO> Execute(BasePagedSearch search)
        {

            var query = Context.Tables.Where(x => x.IsActive == true).Include(x => x.Cafe).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Name.Contains(search.Keyword));
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

            var response = new PagedResponse<TableDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new TableDTO
            {
                Id = x.Id,
                Name = x.Name,
                CafeName = x.Cafe.Name,
                IsActive = x.IsActive,
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;

        }
    }
}
