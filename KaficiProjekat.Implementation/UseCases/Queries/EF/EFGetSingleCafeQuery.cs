using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Commands.EF
{
    public class EFGetSingleCafeQuery : EfUseCase, IGetSingleCafeQuery
    {
        public EFGetSingleCafeQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 38;

        public string Name => "Get a single cafe";

        public string Description => "Get a single cafe with EF";

        public GetSingleCafeDTO Execute(int search)
        {
            var Cafe = Context.Cafes.Include(x=>x.CafeProducts).ThenInclude(x=>x.Product).ThenInclude(x=>x.Category)
                .Include(x=>x.Tables)
                .Include(x=>x.WorkersInCafe).ThenInclude(x=>x.UserShift).ThenInclude(x=>x.User)
                .Include(x=>x.WorkersInCafe).ThenInclude(x=>x.UserShift).ThenInclude(x=>x.Shifts);
            var cafe = Cafe.First(x=>x.Id == search);
            //var cafe = Context.Cafes.Find(search);
            var products = cafe.CafeProducts.Where(x => x.CafeId == cafe.Id).Select(x=>x.Product);
            var tables = cafe.Tables.Where(x => x.CafeId == search);
            var workers = cafe.WorkersInCafe.Where(x => x.CafeId == cafe.Id).Select(x=>x.UserShift);
            // cafe.CafeProducts = products;


            var response = new GetSingleCafeDTO
            {
                Name = cafe.Name,
                Description = cafe.Description,
                Adress = cafe.Adress,
                Products = products.Select(x => new ProductDTO
                {
                    Id = x.Id,
                    Name = x.Name,
                    Amount = x.Amount,
                    Description = x.Description,
                    CategoryName = x.Category.Name,
                    Price = x.Price,
                    ImageNames = x.Images.Select(x => x.Path)
                }),
                Tables = tables.Select(x => new TableDTO
                {
                    Id = x.Id,
                    Name = x.Name,
                    CafeName = cafe.Name,
                    IsActive = x.IsActive
                }),
                Workers = workers.Select(x => new WorkersDTO
                {
                    Id = x.User.Id,
                    CafeName = cafe.Name,
                    WorkerName = x.User.Name,
                    WorkerLastName = x.User.LastName,
                    ShiftName = x.Shifts.Name,
                    Date = cafe.WorkersInCafe.Select(x=>x.Date).First(),
                    IsActive = x.IsActive
                })
                
            };


            return response;
        }
    }
}
