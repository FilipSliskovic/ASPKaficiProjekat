using KaficiProjekat.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases
{
    public abstract class EfUseCase
    {
        protected EfUseCase(KaficiProjekatDbContext context)
        {
            Context = context;
        }

        protected KaficiProjekatDbContext Context { get; }
    }
}
