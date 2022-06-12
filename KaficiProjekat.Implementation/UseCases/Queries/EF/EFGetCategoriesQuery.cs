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
    public class EFGetCategoriesQuery : EfUseCase, IGetCategoriesQuery
    {
        public EFGetCategoriesQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 25;

        public string Name => "Get categories";

        public string Description => "Get categories with EF";

        public PagedResponse<CategoryDTO> Execute(BasePagedSearch search)
        {

            var query = Context.Categories.Where(x => x.IsActive == true).AsQueryable();

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

            var response = new PagedResponse<CategoryDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new CategoryDTO
            {
                Name = x.Name
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();

            return response;


        }
    }
}
