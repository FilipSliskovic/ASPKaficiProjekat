using KaficiProjekat.Application.UseCases;
using KaficiProjekat.Application.UseCases.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.UseCases.Queries.SP
{
    public class SPGetUseCaseLogsQuery : IGetUseCaseLogsQuery
    {

        private readonly IUseCaseLogger _logger;

        public SPGetUseCaseLogsQuery(IUseCaseLogger logger)
        {
            _logger = logger;
        }

        public int Id => 27;

        public string Name => "Search use case logs";

        public string Description => "Search use case logs with stored procedure";

        public IEnumerable<UseCaseLog> Execute(UseCaseLogSearch search)
        {
            return _logger.GetLogs(search);
        }
    }
}
