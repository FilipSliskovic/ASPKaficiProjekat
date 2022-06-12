using KaficiProjekat.Domain;
using System.Collections.Generic;

namespace KaficiProjekat.API.Core
{
    public class JwtUser : IAplicationUser
    {
        public string Identity { get; set; }

        public int Id { get; set; }

        public IEnumerable<int> UseCaseIds { get; set; } = new List<int>();
        public string Username { get; set; }
    }
}
