using Dapper;
using KaficiProjekat.Application.UseCases;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.Logging
{
    public class SPUseCaseLogger : IUseCaseLogger
    {
        private string connString;

        public SPUseCaseLogger(string connString)
        {
            this.connString = connString;
        }

        public IEnumerable<UseCaseLog> GetLogs(UseCaseLogSearch search)
        {
            var connection = new SqlConnection(connString);

            return connection.Query<UseCaseLog>("SearchUseCaseLogs", new 
            { 
                datefrom = search.DateFrom,
                dateto = search.DateTo,
                usecasename = search.UseCaseName,
                userid = search.UserId,
                user = search.User,

            },
                commandType: System.Data.CommandType.StoredProcedure);
        }

        public void Log(UseCaseLog log)
        {
            var connection = new SqlConnection(connString);

            connection.Query("AddLogRecord",new {
                usecasename = log.UseCaseName,
                username = log.User,
                userid = log.UserId,
                excecutiontime = log.ExecutionTime,
                data = log.Data,
                isauthorized = log.IsAuthorized
            },commandType: System.Data.CommandType.StoredProcedure);
        }
    }
}
