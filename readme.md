# SQL-Server: Computed columns



## What is a Computed Column?

A [Computed Column](https://learn.microsoft.com/en-us/sql/relational-databases/tables/specify-computed-columns-in-a-table?view=sql-server-ver16) is a column whose values are derived or computed by an expression. The expression might be a constant, function or combination of values from one or more columns in the same table. 

The code samples provided are based on an expressions with emphasis for [EF Core](https://learn.microsoft.com/en-us/ef/core/) while provides a data provider sample also.


Sample from code samples to get a year from the column BirthYear.

![Screen1](assets/screen1.png)

## Limitations and Restrictions

*Microsoft* [docs](https://learn.microsoft.com/en-us/sql/relational-databases/tables/specify-computed-columns-in-a-table?view=sql-server-ver16#Limitations):

- A computed column cannot be used as a DEFAULT or FOREIGN KEY constraint definition or with a NOT NULL constraint definition. However, if the computed column value is defined by a deterministic expression and the data type of the result is allowed in index columns, a computed column can be used as a key column in an index or as part of any PRIMARY KEY or UNIQUE constraint. For example, if the table has integer columns a and b, the computed column a + b may be indexed, but computed column a + DATEPART(dd, GETDATE()) cannot be indexed, because the value might change in subsequent invocations.
- A computed column cannot be the target of an INSERT or UPDATE statement.
- `SET QUOTED_IDENTIFIER` must be ON when you are creating or changing indexes on computed columns or indexed views. For more information, see [SET QUOTED_IDENTIFIER](https://learn.microsoft.com/en-us/sql/t-sql/statements/set-quoted-identifier-transact-sql?view=sql-server-ver16) (Transact-SQL).


> **Note**
> When a formula combines two expressions of different data types, the rules for data type precedence specify that the data type with the lower precedence is converted to the data type with the higher precedence. If the conversion is not a supported implicit conversion, the error **Error validating the formula for column column_name.** is returned. Use the CAST or CONVERT function to resolve the data type conflict. 

# Add a new computed column

*Microsoft* SSMS [docs](https://learn.microsoft.com/en-us/sql/relational-databases/tables/specify-computed-columns-in-a-table?view=sql-server-ver16#SSMSProcedure) using [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) (SQL-Server Management Studio)



**Note** this can be done with EF Core also. Given the following model

```csharp
public partial class Contact
{
    public int Id { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public DateTime? BirthDate { get; set; }
    public int? YearsOld { get; set; }
    public string FullName { get; set; }
    public int? BirthYear { get; set; }
}
```

Configuration for the model, see project [Context](EntityFrameworkCore/Data/Context.cs) `OnModelCreating`.


```csharp
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
```

Here is what the raw definition looks like in SSMS.

![Schema](assets/schema.png)

## EF Core reading data from Contacts

First example reads all contacts while the second example asserts for contacts ready for retirement using the computed column YearsOld. Both examples display FirstName and LastName using the computed column FullName.

```csharp
private static void AllContacts()
{
    using var context = new Context();
    var contacts = context.Contact.ToList();
    foreach (Contact item in contacts)
    {
        Console.WriteLine($"{item.Id,-3}{item.FullName,-15}Is {item.YearsOld,-3}years old born {item.BirthYear}");
    }

    Console.WriteLine();
}
private static void ReadForRetirement()
{
    using var context = new Context();
    int yearsOld = 65;

    var readyForRetirement = context.Contact.Where(contact => contact.YearsOld > yearsOld).ToList();

    foreach (Contact item in readyForRetirement)
    {
        Console.WriteLine($"{item.Id,-3}{item.FullName,-15}Is {item.YearsOld,-3}years old born {item.BirthYear}");
    }
        
    Console.WriteLine();
}
```

Suppose a user interface displays `FullName`, we can use the computed column FullName to find the contact.

```csharp
private static void FindByFullName()
{
    var fullName = "Karen Payne";
    using var context = new Context();
    var contact = context.Contact.FirstOrDefault(item => item.FullName == fullName);
    Console.WriteLine(contact.Id);
    Console.WriteLine();
}
```

Computed columns are very powerful. Entity Framework Core with its fluent API allows them to be easily added. Before using computed columns in production databases run test in SSMS on larger datasets than you would normally run, determine if performance is acceptable along with testing with proper indices.

# See also

- EF Core [Computed columns](https://learn.microsoft.com/en-us/ef/core/modeling/generated-properties?tabs=data-annotations#computed-columns)
- [FORMAT is a convenient but expensive SQL Server function](https://www.mssqltips.com/sqlservertip/7145/sql-date-format-comparison-computed-column-materialized-column/)

# Required

Microsoft Visual Studio 2022 version 17.4 or higher

# NuGet packages

- [ConfigurationLibrary](https://www.nuget.org/packages/ConfigurationLibrary/) is used for obtaining connection strings from `appsettings` in both projects. This is a great solution when not using dependency injection.
- [Spectre.Console](https://www.nuget.org/packages/Spectre.Console/0.45.1-preview.0.47) for enhanced console writting.


# You also might like

- [EF Core 7 code sample](https://github.com/karenpayneoregon/ef-core-7-samples)
- [SQL-Server: Exploration of datetime2(7) precision](https://github.com/karenpayneoregon/sql-server-datetime2)
- [EF Core: Working with TimeOnly](https://github.com/karenpayneoregon/ef-core-dateonly-timeonly)
- [Storing passwords in SQL-Server database](https://github.com/karenpayneoregon/sql-server-password-secure)

# Summary

This repository contents provide working code samples focused on using computed columns with EF Core and for those using a data provider [System.Data.SqlClient](https://www.nuget.org/packages/System.Data.SqlClient) for instance computed columns work too.

:small_blue_diamond: Not all possiblities are presented, code sample have been kept simple for the sake of easy learning.