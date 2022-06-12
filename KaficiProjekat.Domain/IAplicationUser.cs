using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public interface IAplicationUser
    {
        public string Identity { get; }
        public int Id { get;}
        public IEnumerable<int> UseCaseIds { get;  }
        public string Username { get; }

    }
}
