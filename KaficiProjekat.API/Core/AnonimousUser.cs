using KaficiProjekat.Domain;
using System.Collections.Generic;

namespace KaficiProjekat.API.Core
{
    public class AnonimousUser : IAplicationUser
    {
        public string Identity => "anonymous";

        public int Id => 0;

        public IEnumerable<int> UseCaseIds => new List<int> { 8};
        public string Username => "anonimous@asp-api.com";
    }
}
