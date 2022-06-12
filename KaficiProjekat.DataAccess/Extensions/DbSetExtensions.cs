using KaficiProjekat.DataAccess.Exceptions;
using KaficiProjekat.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.DataAccess.Extensions
{
    public static class DbSetExtensions
    {


        public static void Deactivate(this DbContext context, Entity entity)
        {
            entity.IsActive = false;
            entity.DeletedAt = DateTime.UtcNow;
            entity.IsActive = false;
            context.Entry(entity).State = EntityState.Modified;
        }

        public static void Deactivate<T>(this DbContext context, int id)
            where T : Entity
        {
            var itemToDeactivate = context.Set<T>().Find(id);

            if (itemToDeactivate == null)
            {
                throw new EntityNotFoundException();
            }
            itemToDeactivate.DeletedAt = DateTime.UtcNow;
            itemToDeactivate.IsActive = false;
        }

        public static void Deactivate<T>(this DbContext context, IEnumerable<int> ids)
            where T : Entity
        {
            var toDeactivate = context.Set<T>().Where(x => ids.Contains(x.Id));

            //var nonExistingIds = ids.Except(toDeactivate.Select(x => x.Id));

            foreach (var d in toDeactivate)
            {
                d.IsActive = false;
                d.DeletedAt = DateTime.UtcNow;
                d.IsActive = false;
            }

        }

    }
}
