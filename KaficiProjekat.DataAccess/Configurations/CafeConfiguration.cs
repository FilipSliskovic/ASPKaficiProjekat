using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.DataAccess.Configurations
{
    public class CafeConfiguration : EntityConfiguration<Cafe>
    {
        protected override void ConfigureRules(EntityTypeBuilder<Cafe> builder)
        {
            builder.Property(x => x.Name).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Adress).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Description).IsRequired().HasMaxLength(50);


            builder.HasIndex(x => x.Name).IsUnique();
            builder.HasIndex(x => x.Adress).IsUnique();
            builder.HasIndex(x => x.Description).IsUnique();

            builder.HasMany(x => x.CafeProducts).WithOne(x => x.Cafe).HasForeignKey(x => x.CafeId).OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);
            builder.HasMany(x => x.WorkersInCafe).WithOne(x => x.Cafe).HasForeignKey(x => x.CafeId).OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);
            builder.HasMany(x=>x.Tables).WithOne(x=>x.Cafe).HasForeignKey(x=>x.CafeId);

        }
    }
}
