using EntityFrameworkCore4.Data;
using Microsoft.EntityFrameworkCore;
using Spectre.Library;

namespace EntityFrameworkCore4;

internal partial class Program
{
    static void Main(string[] args)
    {
        using (var context = new Context())
        {
            var details = context.OrderDetails.Include(od => od.Product).ToList();
            foreach (var detail in details)
            {
                Console.WriteLine($"{detail.OrderId, -5}{detail.Product.ProductName,-35}{detail.UnitPrice,-9:C}{detail.Quantity,-5}{detail.RowTotal:C}");
            }
        }

        Prompts.ExitPrompt();
        Console.ReadLine();
    }
}