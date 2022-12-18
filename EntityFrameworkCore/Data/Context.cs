﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using ConfigurationLibrary.Classes;
using EntityFrameworkCore.Models;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using Microsoft.Extensions.Logging;

namespace EntityFrameworkCore.Data;

public partial class Context : DbContext
{
    public Context()
    {
    }

    public virtual DbSet<Contact> Contact { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(ConfigurationHelper.ConnectionString())
            .EnableSensitiveDataLogging()
            .LogTo(message => Debug.WriteLine(message), LogLevel.Information)
            .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Contact>(entity =>
        {
            entity.Property(e => e.BirthDate)
                .HasColumnType("date");
            entity.Property(e => e.BirthYear)
                .HasComment("Computes birth year from BirthDate")
                .HasComputedColumnSql("(datepart(year,[BirthDate]))", false);
            entity.Property(e => e.FullName)
                .HasComputedColumnSql("(([FirstName]+' ')+[LastName])", false);
            entity.Property(e => e.YearsOld)
                .HasComment("Computes years old from BirthDate")
                .HasComputedColumnSql("(datediff(year,[BirthDate],getdate()))", false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}