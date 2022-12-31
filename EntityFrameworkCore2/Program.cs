using EntityFrameworkCore2.Data;

namespace EntityFrameworkCore2;

internal partial class Program
{
    static void Main(string[] args)
    {

        var table = CreateTableEntityFramework();

        using (var context = new Context())
        {
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
            var firstApp = apps.FirstOrDefault();
            Version version = new Version(firstApp!.TheVersion);
            AnsiConsole.MarkupLine($"[cyan]{firstApp.Id,-3}{firstApp.AppName,-10}[/][yellow]{version}[/]");

        }

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
            .AddColumn("[cyan]Revison[/]")
            .Alignment(Justify.Left)
            .BorderColor(Color.LightSlateGrey)
            .Title("[LightGreen]Application versions[/]");
}