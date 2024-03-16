using EntityFrameworkCore3.Data;

namespace EntityFrameworkCore3;

internal partial class Program
{
    static void Main(string[] args)
    {
        AnsiConsole.MarkupLine("[cyan]Products[/]");

        using (var context = new Context())
        {
            var products = context.Products.ToList();

            foreach (var product in products)
            {
                Console.WriteLine($"{product.Id,-4}{product.ProductName,-20}{product.PriceRaw,-15}{product.Price}");
            }
        }

        Console.ReadLine();
    }
}