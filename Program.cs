using Long_Term_Segregation.Data;
using Long_Term_Segregation.Services.Implementations;
using Long_Term_Segregation.Services.interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

//custom services 
//var wenv = builder.Host.ConfigureWebHost()
var path = ((IWebHostEnvironment)builder.Environment).ContentRootPath;
builder.Services.AddSingleton(new AppDataContext(path));


//register custom services 
builder.Services.AddSingleton<IAppDataService, AppDataService>();

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
