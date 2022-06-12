using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.DataAccess.Configurations
{
    public class ProductConfiguration : EntityConfiguration<Product>
    {
        protected override void ConfigureRules(EntityTypeBuilder<Product> builder)
        {
            builder.Property(x => x.Name).IsRequired().HasMaxLength(30);
            builder.Property(x => x.Description).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Price).IsRequired().HasMaxLength(10);
            builder.Property(x => x.Amount).IsRequired().HasMaxLength(10);

            builder.HasIndex(x => x.Name);

            builder.HasMany(x => x.Images).WithMany(x => x.Products);
            builder.HasMany(x=>x.CafeProducts).WithOne(x=>x.Product).HasForeignKey(x=>x.ProductID);
        }
    }
}
