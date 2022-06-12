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
    public class EFGetWorkersQuery : EfUseCase, IGetWorkersQuery
    {
        public EFGetWorkersQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 9;

        public string Name => "Get workers in cafe";

        public string Description => "Get workers in cafe with EF";

        public PagedResponse<WorkersDTO> Execute(BasePagedSearch search)
        {


            var query = Context.WorkersInCafe.Where(x => x.IsActive == true).Include(x=>x.UserShift).ThenInclude(x=>x.User).Where(x => x.IsActive == true).Include(x=>x.UserShift).ThenInclude(x=>x.Shifts).Where(x => x.IsActive == true).Include(x=>x.Cafe).AsQueryable();

            if (!string.IsNullOrEmpty(search.Keyword))
            {
                query = query.Where(x => x.Cafe.Name.Contains(search.Keyword) || x.Date.Date.ToString() == search.Keyword || x.UserShift.User.Name.Contains(search.Keyword));
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

            var response = new PagedResponse<WorkersDTO>();

            response.Data = query.Skip(toSkip).Take(search.PerPage.Value).Select(x => new WorkersDTO
            {
                Id = x.Id,
                Date = x.Date,
                ShiftName = x.UserShift.Shifts.Name,
                WorkerName = x.UserShift.User.Name,
                WorkerLastName = x.UserShift.User.LastName,
                CafeName = x.Cafe.Name,
                IsActive = x.IsActive
            }).ToList();

            response.CurrentPage = search.Page.Value;
            response.ItemsPerPage = search.PerPage.Value;
            response.TotalCount = query.Count();
            return response;



        }
    }
}
