using SqlDataProviders.Classes;
using SqlDataProviders.Models;
using static Spectre.Library.Prompts;

namespace SqlDataProviders;

internal partial class Program
{
    static void Main(string[] args)
    {
        AnsiConsole.MarkupLine("[yellow]Data provider[/]");
        Console.WriteLine();

        AllContacts();

        ReadForRetirement();

        ExitPrompt();
    }

    private static void AllContacts()
    {
        AnsiConsole.MarkupLine("[white on blue]All contacts[/]");

        var contacts = DataOperations.ReadContacts();

        foreach (Contact item in contacts)
        {
            Console.WriteLine($"{item.Id,-3}{item.FullName,-15}Is {item.YearsOld,-3}years old born {item.BirthYear}");
        }

        Console.WriteLine();
    }

    private static void ReadForRetirement()
    {
        int yearsOld = 65;
        AnsiConsole.MarkupLine($"[white on blue]Ready for retirement, age > [/][yellow on blue]{yearsOld}[/]");
        var contacts = DataOperations.ReadContacts(yearsOld);

        foreach (Contact item in contacts)
        {
            Console.WriteLine($"{item.Id,-3}{item.FullName,-15}Is {item.YearsOld,-3}years old born {item.BirthYear}");
        }

        Console.WriteLine();

    }
}