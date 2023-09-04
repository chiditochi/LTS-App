using Long_Term_Segregation.Data;
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Services.Implementations;
using Long_Term_Segregation.Services.interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

var logger = new LoggerConfiguration()
                .ReadFrom.Configuration(builder.Configuration)
                .Enrich.FromLogContext()
                .CreateLogger();

builder.Logging.AddSerilog(logger);

// Add services to the container.
builder.Services.AddIdentity<AppUser, AppRole>(config =>
                {
                    config.Password.RequireLowercase = true;
                })
                .AddEntityFrameworkStores<AppDbContext>()
                .AddDefaultTokenProviders();

//AppDB service
var timeout = Convert.ToInt32(builder.Configuration.GetSection("App:DBTimeOutInMinutes").Value);

builder.Services.AddDbContextPool<AppDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("AppConnectionString"),
        opts => opts.CommandTimeout(timeout)
 ));

// Add services to the container.
builder.Services.AddControllersWithViews();
// Add services to the container.
builder.Services.AddHttpClient("patient", options =>{
    var baseUri = builder.Configuration.GetSection("App:NewPatientApi").Value;
    options.BaseAddress = new Uri(baseUri);
});
//custom services 
//var wenv = builder.Host.ConfigureWebHost()
var path = ((IWebHostEnvironment)builder.Environment).ContentRootPath;
builder.Services.AddSingleton(new AppDataContext(path));


//register custom services 
builder.Services.AddScoped<IAppDataService, AppDataService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
