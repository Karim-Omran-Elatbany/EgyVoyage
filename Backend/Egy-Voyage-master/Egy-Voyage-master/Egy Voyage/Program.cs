using EgyVoyageApi.Data;
using Microsoft.EntityFrameworkCore;
using EgyVoyageApi.Repository.Abastract;
using EgyVoyageApi.Repository.Implementation;
using Microsoft.Extensions.FileProviders;

using System;



var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddCors();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var conn = builder.Configuration.GetSection("constr").Value;
builder.Services.AddDbContext<AppDbContext>(options => options.UseSqlServer(conn));

builder.Services.AddTransient<IFileService, FileService>();
builder.Services.AddTransient<IProductRepository, ProductRepostory>();
builder.Services.AddTransient<IEmailService, EmialService>();
//model
//builder.Services.AddPredictionEnginePool<ModelInput, ModelOutput>()
//    .FromFile(modelName: "mobilenet_modell", filePath: "D:\\crash course\\LEARNING ASP\\EgyVoyageApi\\EgyVoyageApi\\mobilenet_model.zip", watchForChanges: true);


var app = builder.Build();


//var predictionHandler =
//    async (PredictionEnginePool<ModelInput, ModelOutput> predictionEnginePool, ModelInput input) =>
//        await Task.FromResult(predictionEnginePool.Predict(modelName: "mobilenet_modell", input));

//app.MapPost("/predict", predictionHandler);

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors(o => o.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());
//to create folder
var uploadsPath = Path.Combine(builder.Environment.ContentRootPath, "Uploads");
Console.WriteLine($"{builder.Environment.ContentRootPath}/model");
if (!Directory.Exists(uploadsPath))
{
    Directory.CreateDirectory(uploadsPath);
}
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
           Path.Combine(builder.Environment.ContentRootPath, "Uploads")),
    RequestPath = "/Resources"
});

app.UseAuthorization();

app.MapControllers();

app.Run();
