using KaficiProjekat.API.Core;
using KaficiProjekat.Application.UseCases.Commands;
using KaficiProjekat.Application.UseCases.Queries;
using KaficiProjekat.DataAccess;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation.UseCases.Commands.EF;
using KaficiProjekat.Implementation.UseCases.Queries.EF;
using KaficiProjekat.Implementation.UseCases.Queries.SP;
using KaficiProjekat.Implementation.Validators;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace KaficiProjekat.API.Extensions
{
    public static class ContainerExtensions
    {


        public static void AddJwt(this IServiceCollection services, AppSettings settings)
        {
            services.AddTransient(x =>
            {
                var context = x.GetService<KaficiProjekatDbContext>();
                var settings = x.GetService<AppSettings>();

                return new JwtManager(context, settings.JwtSettings);
            });


            services.AddAuthentication(options =>
            {
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultSignInScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(cfg =>
            {
                cfg.RequireHttpsMetadata = false;
                cfg.SaveToken = true;
                cfg.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidIssuer = settings.JwtSettings.Issuer,
                    ValidateIssuer = true,
                    ValidAudience = "Any",
                    ValidateAudience = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(settings.JwtSettings.SecretKey)),
                    ValidateIssuerSigningKey = true,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };
            });
        }




        public static void AddApplicationUser(this IServiceCollection services)
        {
            services.AddTransient<IAplicationUser>(x =>
            {
                var accessor = x.GetService<IHttpContextAccessor>();
                var header = accessor.HttpContext.Request.Headers["Authorization"];

                //Pristup payload-u
                var claims = accessor.HttpContext.User;

                if (claims == null || claims.FindFirst("UserId") == null)
                {
                    return new AnonimousUser();
                }

                var actor = new JwtUser
                {
                    Identity = claims.FindFirst("Username").Value,
                    Id = Int32.Parse(claims.FindFirst("UserId").Value),
                    //Identity = claims.FindFirst("Email").Value,
                    // "[1, 2, 3, 4, 5]"
                    UseCaseIds = JsonConvert.DeserializeObject<List<int>>(claims.FindFirst("UseCases").Value)
                };

                return actor;
            });
        }


        public static void AddUseCases(this IServiceCollection services)
        {
            services.AddTransient<IGetShiftsQuery, EFGetShiftsQuery>();
            services.AddTransient<ICreateShiftCommand, EFCreateShiftCommand>();
            services.AddTransient<IDeleteShiftCommand, EFDeleteShiftCommand>();
            services.AddTransient<IUpdateShiftCommand, EFUpdateShiftCommand>();
            services.AddTransient<IGetUsersQuery, EFGetUsersQuery>();
            services.AddTransient<IGetUserQuery, EFGetUserQuery>();
            services.AddTransient<IDeleteUserCommand, EFDeleteUserCommand>();
            services.AddTransient<IRegisterUserCommand, EFRegisterUserCommand>();
            services.AddTransient<IGetWorkersQuery, EFGetWorkersQuery>();
            services.AddTransient<ICreateWorkersCommand, EFCreateWorkersCommand>();
            services.AddTransient<IDeleteWorkersCommand, EFDeleteWorkersCommand>();
            services.AddTransient<IGetCafeQuery, EFGetCafeQuery>();
            services.AddTransient<ICreateCafeCommand, EFCreateCafeCommand>();
            services.AddTransient<IDeleteCafeCommand, EFDeleteCafeCommand>();
            services.AddTransient<IUpdateCafeCommand, EFUpdateCafeCommand>();
            services.AddTransient<IGetTablesQuery, EFGetTablesQuery>();
            services.AddTransient<ICreateTableCommand, EFCreateTableCommand>();
            services.AddTransient<IUpdateTableCommand, EFUpdateTableCommad>();
            services.AddTransient<IDeleteTableCommand, EFDeleteTableCommand>();
            services.AddTransient<IGetOrdersQuery, EFGetOrdersQuery>();
            services.AddTransient<ICreateOrderCommand, EFCreateOrderCommand>();
            services.AddTransient<IUpdateOrderCommand, EFUpdateOrderCommand>();
            services.AddTransient<IUpdateSuperUserCommand, EFUpdateSuperUserCommand>();
            services.AddTransient<IGetSuperUsersQuery, EFGetSuperusersQuery>();
            services.AddTransient<ICreateCategoryCommand, EFCreateCategoryCommand>();
            services.AddTransient<IGetCategoriesQuery, EFGetCategoriesQuery>();
            services.AddTransient<IDeleteCategoriesCommand, EFDeleteCategoryCommand>();
            services.AddTransient<IGetUseCaseLogsQuery, SPGetUseCaseLogsQuery>();
            services.AddTransient<IGetProductsQuery, EFGetProductsQuery>();
            services.AddTransient<ICreateProductCommand, EFCreateProductCommand>();
            services.AddTransient<IDeleteProductCommand, EFDeleteProductCommand>();
            services.AddTransient<IGetCafeProductsQuery, EFGetCafeProductsQuery>();
            services.AddTransient<ICreateCafeProductCommand, EFCreateCafeProductCommand>();
            services.AddTransient<IDeleteCafeProductCommand, EFDeleteCafeProductCommand>();
            services.AddTransient<IGetCafeProductOrdersQuery, EFGetCafeProductOrdersQuery>();
            services.AddTransient<IGetCafeProductOrderQuery, EFGetCafeProductOrderQuery>();
            services.AddTransient<IGetOrderQuery, EFGetOrderQuery>();
            services.AddTransient<ICreateCafeProductOrderCommand, EfCreateCafeProductOrderCommand>();
            services.AddTransient<IDeleteCafeProductOrderCommand, EFDeleteCafeProductOrderCommand>();
            services.AddTransient<IGetSingleCafeQuery, EFGetSingleCafeQuery>();
            services.AddTransient<IDeleteOrderCommand, EFDeleteOrderCommand>();
            
            


            #region Validators

            services.AddTransient<CreateShiftValidator>();
            services.AddTransient<DeleteShiftValidator>();
            services.AddTransient<RegisterUserValidator>();
            services.AddTransient<CreateWorkersValidator>();
            services.AddTransient<CreateCafeValidator>();
            services.AddTransient<UpdateCafeValidator>();
            services.AddTransient<CreateOrderValidator>();
            services.AddTransient<UpdateTableValidator>();
            services.AddTransient<UpdateShiftValidator>();
            services.AddTransient<CreateCategoyValidator>();
            services.AddTransient<CreateProductValidator>();
            services.AddTransient<CreateTableValidator>();

            #endregion
        }


        public static void AddKaficiDbContext(this IServiceCollection services, string conString)
        {
            services.AddTransient(x =>
            {
                var optionsBuilder = new DbContextOptionsBuilder();


                optionsBuilder.UseSqlServer(conString);

                var options = optionsBuilder.Options;

                return new KaficiProjekatDbContext(/*options*/);
            });
        }
    }
}
