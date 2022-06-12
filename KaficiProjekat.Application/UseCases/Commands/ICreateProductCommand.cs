using KaficiProjekat.Application.UseCases.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Application.UseCases.Commands
{
    public interface ICreateProductCommand : ICommand<CreateProductDTO>
    {
    }
}
