using EnityFrameworkCoreOffice.Data;
using EnityFrameworkCoreOffice.Models;

namespace EnityFrameworkCoreOffice;

internal partial class Program
{
    static void Main(string[] args)
    {
        using var context = new Context();
        List<Office> offices =
        [
            new Office()
            {
                City = "New York",
                PostalCode = "10001",
                State = "NY"
            },

            new Office()
            {
                City = "Salem",
                PostalCode = "98001",
                State = "OR"
            }
        ];

        context.Office.AddRange(offices);
        context.SaveChanges();

        var list = context.Office.ToList();

        foreach (var office in list)
        {
            Console.WriteLine($"{office.Id,-3}{office.Computed,-12}{office.State}");
        }

        AnsiConsole.MarkupLine("[yellow]Hello[/]");
        Console.ReadLine();
    }
}