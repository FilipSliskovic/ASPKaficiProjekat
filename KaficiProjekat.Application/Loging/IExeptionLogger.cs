using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.Loging
{
    public interface IExeptionLogger
    {
        void Log(Exception ex);
    }
}
