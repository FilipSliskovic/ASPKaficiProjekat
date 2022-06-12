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
    public class CafeProductOrderConfiguration : IEntityTypeConfiguration<CafeProductOrder>
    {
        public void Configure(EntityTypeBuilder<CafeProductOrder> builder)
        {
            builder.Property(x => x.ProductPrice).IsRequired(false);
        }
    }
}
