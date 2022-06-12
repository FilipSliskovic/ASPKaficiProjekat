using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.DTO.Searches;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Queries.EF
{
    public class EFGetShiftsQuery : EfUseCase, IGetShiftsQuery
    {
        public EFGetShiftsQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 1;

        public string Name => "Search Shifts";

        public string Description => "Search Shifts with EF";

        public PagedResponse<ShiftDTO> Execute(BasePagedSearch search)
        {
            var query = Context.Shifts.Where(x => x.IsActive == true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Name.Contains(search.Keyword));
            }

            if (search.PerPage == null || search.PerPage<1)
            {
                search.PerPage = 15;
            }


            if (search.Page == null || search.Page <1)
            {
                search.Page = 1;
            }

            var toSkip = (search.Page.Value -1) * search.PerPage.Value;

            var response = new PagedResponse<ShiftDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new ShiftDTO
            {
                Id = x.Id,
                Name = x.Name,
                IsActive = x.IsActive,
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;
        }
    }
}
