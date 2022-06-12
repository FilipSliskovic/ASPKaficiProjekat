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
    public class ActivityConfiguration : IEntityTypeConfiguration<Activity>
    {
        public void Configure(EntityTypeBuilder<Activity> builder)
        {
            builder.Property(x => x.User).HasDefaultValueSql("USER_NAME()");
            builder.Property(x => x.DateTime).HasDefaultValueSql("GETDATE()");
            builder.Property(x => x.Action).IsRequired();


        }
    }
}
