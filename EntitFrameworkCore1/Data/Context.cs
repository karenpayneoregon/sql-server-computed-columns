using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using EntityFrameworkCore1.Models;
using ConfigurationLibrary.Classes;
using Microsoft.Extensions.Logging;

namespace EntityFrameworkCore1.Data;

internal class Context : DbContext
{
    public DbSet<Person> Persons { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(ConfigurationHelper.ConnectionString())
            .EnableSensitiveDataLogging()
            .LogTo(message => Debug.WriteLine(message), LogLevel.Information)
            .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Person>()
            .Property(p => p.DisplayName)
            .HasComputedColumnSql("[Title] + ' ' + [FirstName] + ' ' + [LastName]");
        modelBuilder.Entity<Person>().HasData(
            new Person() { Id = 1, FirstName = "Karen", LastName = "Payne", Title = "Miss" },
            new Person() { Id = 2, FirstName = "Jane", LastName = "Adams", Title = "Miss" }
        );
    }
}
