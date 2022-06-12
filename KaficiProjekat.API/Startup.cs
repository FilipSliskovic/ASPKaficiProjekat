using KaficiProjekat.API.Core;
using KaficiProjekat.Application.Loging;
using KaficiProjekat.Application.UseCases;
using KaficiProjekat.API.Extensions;
using KaficiProjekat.Domain;
using KaficiProjekat.Implementation;
using KaficiProjekat.Implementation.Logging;
using KaficiProjekat.Implementation.UseCases.UseCaseLogger;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using KaficiProjekat.Application.Emails;
using KaficiProjekat.Implementation.Emails;
using System.Reflection;
using System.IO;

namespace KaficiProjekat.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var settings = new AppSettings();
            Configuration.Bind(settings);
            services.AddSingleton(settings);
            services.AddJwt(settings);
            services.AddApplicationUser();
            services.AddHttpContextAccessor();
            services.AddKaficiDbContext(settings.ConnString);
            services.AddUseCases();
            services.AddTransient<IExeptionLogger, ConsoleExceptionLogger>();
            services.AddTransient<IUseCaseLogger>(x => new SPUseCaseLogger(settings.ConnString));
            services.AddTransient<IEmailSender>(x => new SmtpEmailSender(settings.EmailFrom, settings.EmailPassword));
            
            //services.AddTransient<IAplicationUser, AnonimousUser>();
            services.AddTransient<UseCaseHandler>();
            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "KaficiProjekat.API", Version = "v1" });


                var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                c.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));



            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "KaficiProjekat.API v1"));
                
            }

            app.UseRouting();
            app.UseMiddleware<GlobalExceptionHandler>();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseStaticFiles();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
