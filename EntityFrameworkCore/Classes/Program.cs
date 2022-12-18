﻿using System.Runtime.CompilerServices;

// ReSharper disable once CheckNamespace
namespace EntityFrameworkCore;

internal partial class Program
{
    [ModuleInitializer]
    public static void Init()
    {
        Console.Title = "Code sample: EF Core 7 using SQL-Server computed columns";
        WindowUtility.SetConsoleWindowPosition(WindowUtility.AnchorWindow.Center);
    }
}