using EntityFrameworkCore2.Data;
using EntityFrameworkCore2.Models;
using Microsoft.EntityFrameworkCore;
using Spectre.Library;
using VersioningLibrary;

namespace EntityFrameworkCore2;

internal partial class Program
{
    static void Main(string[] args)
    {

        var table = CreateTableEntityFramework();

        using var context = new Context();
        var apps = context.ApplicationSettings.ToList();
        foreach (var app in apps)
        {
            table.AddRow(
                app.Id.ToString(), 
                app.AppName, 
                app.TheVersion, 
                app.VersionMajor.ToString(), 
                app.VersionMinor.ToString(), 
                app.VersionBuild.ToString(), 
                app.VersionRevison.ToString());
        }

        AnsiConsole.Write(table);

        /*
        * Given that TheVersion property can be used to create a Version object let's do it.
        */
        ApplicationSettings firstApp = apps.FirstOrDefault();
        Version version = new Version(firstApp!.TheVersion);
        AnsiConsole.MarkupLine($"[cyan]{firstApp.Id,-3}{firstApp.AppName,-10}[/][yellow]{version}[/]");

        Console.WriteLine();
        AnsiConsole.MarkupLine("[cyan]Increment revision[/]");
        version = version.IncrementRevision(3);
        AnsiConsole.MarkupLine($"[white]{version}[/]");

        Console.WriteLine();
        AnsiConsole.MarkupLine("[cyan]Increment major[/]");
        version = version.IncrementMajor(1);
        AnsiConsole.MarkupLine($"[white]{version}[/]");

        AnsiConsole.MarkupLine("[yellow]Updating[/]");
        firstApp.VersionMajor = version.Major;
        firstApp.VersionRevison = version.Revision;
        context.Entry(firstApp).State = EntityState.Modified;
        context.SaveChanges();

        var modified = context.ApplicationSettings.FirstOrDefault();
        AnsiConsole.MarkupLine($"[cyan]Updated to[/] [white]{modified.TheVersion}[/]");

        // insert a new record
        ApplicationSettings app1 = new ApplicationSettings()
        {
            AppName = "App3", VersionMajor = 3, VersionMinor = 2, VersionRevison = 22, Identifier = 3

        };

        context.Add(app1);
        Console.WriteLine($"Saved result: {context.SaveChanges()}");

        Prompts.ExitPrompt();
        Console.ReadLine();

    }
    public static Table CreateTableEntityFramework()
        => new Table().RoundedBorder()
            .AddColumn("[cyan]Id[/]")
            .AddColumn("[cyan]Name[/]")
            .AddColumn("[cyan]Version[/]")
            .AddColumn("[cyan]Major[/]")
            .AddColumn("[cyan]Minor[/]")
            .AddColumn("[cyan]Build[/]")
            .AddColumn("[cyan]Revision[/]")
            .Alignment(Justify.Left)
            .BorderColor(Color.LightSlateGrey)
            .Title("[LightGreen]Application versions[/]");
}