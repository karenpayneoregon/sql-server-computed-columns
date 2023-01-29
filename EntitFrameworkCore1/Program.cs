using EntityFrameworkCore1.Data;
using Spectre.Library;

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
        Prompts.ExitPrompt();
        Console.ReadLine();
    }
}