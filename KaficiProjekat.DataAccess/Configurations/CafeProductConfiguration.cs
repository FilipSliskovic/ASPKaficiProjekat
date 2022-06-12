using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.DataAccess.Configurations
{
    public class CafeProductConfiguration : EntityConfiguration<CafeProduct>
    {


        protected override void ConfigureRules(EntityTypeBuilder<CafeProduct> builder)
        {
            builder.HasMany(x => x.CafeProductOrders).WithOne(x => x.CafeProduct).HasForeignKey(x => x.CafeProductId).OnDelete(DeleteBehavior.Restrict);
        }
    }
}
