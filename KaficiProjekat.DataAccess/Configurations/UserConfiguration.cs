using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.DataAccess.Configurations
{
    public class UserConfiguration : EntityConfiguration<User>
    {
        protected override void ConfigureRules(EntityTypeBuilder<User> builder)
        {
            builder.Property(x => x.Name).IsRequired().HasMaxLength(30);
            builder.Property(x => x.LastName).IsRequired().HasMaxLength(30);
            builder.Property(x => x.UserName).IsRequired().HasMaxLength(20);

            builder.HasIndex(x => x.Name);
            builder.HasIndex(x => x.LastName);
            builder.HasIndex(x => x.UserName).IsUnique();

            builder.HasMany(x => x.UserShifts).WithOne(x => x.User).HasForeignKey(x => x.UserId);
            builder.HasMany(x => x.UseCases).WithOne(x => x.User).HasForeignKey(x => x.UserId);

            //builder.HasDiscriminator<string>("Uloga").HasValue<User>("User").HasValue<Owner>("Owner");
        }
    }
}
