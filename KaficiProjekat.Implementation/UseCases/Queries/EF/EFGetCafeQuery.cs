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
    public class EFGetCafeQuery : EfUseCase, IGetCafeQuery
    {
        public EFGetCafeQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 12;

        public string Name => "Get cafes";

        public string Description => "Get cafes with EF";

        public PagedResponse<CafeDTO> Execute(BasePagedSearch search)
        {

            var query = Context.Cafes.Where(x=>x.IsActive==true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Name.Contains(search.Keyword) || x.Description.Contains(search.Keyword) || x.Adress.Contains(search.Keyword));
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

            var response = new PagedResponse<CafeDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new CafeDTO
            {
                Id = x.Id,
                Adress = x.Adress,
                Description = x.Description,
                Name = x.Name,
                IsActive = x.IsActive
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();

            return response;



        }
    }
}
