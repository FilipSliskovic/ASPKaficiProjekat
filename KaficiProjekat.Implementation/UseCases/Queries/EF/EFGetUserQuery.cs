using KaficiProjekat.Application.UseCases.DTO;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Queries.EF
{
    public class EFGetUserQuery : EfUseCase, IGetUserQuery
    {
        public EFGetUserQuery(KaficiProjekatDbContext context) : base(context)
        {
        }

        public int Id => 6;

        public string Name => "Get a single user";

        public string Description => "Get a user with EF";

        public UserDTO Execute(int id)
        {
            var user = Context.Users.Find(id);

            if (user == null)
            {
                return null;
            }

            var korisnik = new UserDTO
            {
                Firstname = user.Name,
                Lastname = user.LastName,
                //IsActive = user.IsActive,
                Username = user.UserName,
                Id = user.Id
            };

            return korisnik;
        }
    }
}
