﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using EntityFrameworkCore4.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace EntityFrameworkCore4.Data.Configurations;

public partial class ProductsConfiguration : IEntityTypeConfiguration<Products>
{
    public void Configure(EntityTypeBuilder<Products> entity)
    {
        entity.HasKey(e => e.ProductID);

        entity.Property(e => e.ProductName)
            .IsRequired()
            .HasMaxLength(40);
        entity.Property(e => e.QuantityPerUnit).HasMaxLength(20);
        entity.Property(e => e.UnitPrice).HasColumnType("money");

        OnConfigurePartial(entity);
    }

    partial void OnConfigurePartial(EntityTypeBuilder<Products> entity);
}