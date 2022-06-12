using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Activity
    {
        public int Id { get; set; }
        public string User { get; set; }
        public DateTime DateTime { get; set; }
        public string Action { get; set; }
        public string DataDeleted { get; set; }
        public string DataInserted { get; set; }

    }
}
