using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore;
using System;

namespace KaficiProjekat.DataAccess
{
    public class KaficiProjekatDbContext : DbContext
    {

        //public KaficiProjekatDbContext(DbContextOptions options = null) :base(options)
        //{

        //}

        public IAplicationUser User { get; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(this.GetType().Assembly);
            modelBuilder.Entity<UserUseCase>().HasKey(x => new {x.UserId,x.UseCaseId});
            base.OnModelCreating(modelBuilder);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=DESKTOP-BOHUG24;Initial Catalog=KaficiProjekat;Integrated Security=True");
        }


        public override int SaveChanges()
        {
            foreach (var entry in this.ChangeTracker.Entries())
            {
                if (entry.Entity is Entity e)
                {
                    switch (entry.State)
                    {
                        case EntityState.Added:
                            e.IsActive = true;
                            e.CreatedAt = DateTime.UtcNow;
                            break;
                        case EntityState.Modified:
                            e.UpdatedAt = DateTime.UtcNow;
                            e.UpdatedBy = User?.Identity;
                            break;
                    }
                }
            }

            return base.SaveChanges();
        }



        public DbSet<Cafe> Cafes { get; set; }
        public DbSet<CafeProduct> CafeProducts { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Image> Images { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Shift> Shifts { get; set; }
        public DbSet<Table> Tables { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserShift> UserShifts { get; set; }
        public DbSet<WhoWorksWhenAndWhere> WorkersInCafe { get; set; }
        public DbSet<CafeProductOrder> CafeProductOrder { get; set; }
        public DbSet<UserUseCase> UserUseCase { get; set; }
        public DbSet<Activity> Activities { get; set; }
    }
}
