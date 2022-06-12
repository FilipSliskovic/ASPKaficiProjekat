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
    public class EFGetSuperusersQuery : EfUseCase, IGetSuperUsersQuery
    {
        public EFGetSuperusersQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 23;

        public string Name => "Get superusers";

        public string Description => "Get all superusers with EF";

        public PagedResponse<UserDTO> Execute(BasePagedSearch search)
        {



            var query = Context.Users.Where(x=>x.IsSuperUser == true).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Name.Contains(search.Keyword) || x.LastName.Contains(search.Keyword) || x.UserName.Contains(search.Keyword));
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

            var response = new PagedResponse<UserDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new UserDTO
            {
                Id = x.Id,
                Username = x.UserName,
                Firstname = x.Name,
                Lastname = x.LastName
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();

            return response;


        }
    }
}
