﻿#nullable disable
namespace SqlDataProviders.Models;

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