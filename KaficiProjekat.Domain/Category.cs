using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Domain
{
    public class Category : Entity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public int? ImageId { get; set; }
        public int? ParentId { get; set; }


        public Image Image { get; set; }
        public ICollection<Category> ChildCategories { get; set; } = new List<Category>();  
        public Category ParentCategory { get; set; }
        public ICollection<Product> Products { get; set; } = new List<Product>();



    }
}
