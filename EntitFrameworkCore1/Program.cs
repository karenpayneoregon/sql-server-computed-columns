using EntityFrameworkCore1.Data;

namespace EntityFrameworkCore1;

internal partial class Program
{
    static void Main(string[] args)
    {
        using (var context = new Context())
        {
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();
            var people = context.Persons.ToList();

            foreach (var person in people)
            {
                Console.WriteLine(person.DisplayName);
            }
        }
        AnsiConsole.MarkupLine("[yellow]Hello[/]");
        Console.ReadLine();
    }
}