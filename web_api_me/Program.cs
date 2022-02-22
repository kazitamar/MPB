using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNet.Authorization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
//builder.Services.AddAuthorization();
/*builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("BasicAuthentication",new AuthorizationPolicyBuilder("BasicAuthentication").RequireAuthenticatedUser().Build());
});
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("BasicAuthentication", authBuilder =>
        {
            authBuilder.AddAuthenticationSchemes("BasicAuthentication");
            authBuilder.RequireClaim("NameIdentifier");
        });
});*/

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();
app.UseAuthentication();

app.MapControllers();

app.Run();