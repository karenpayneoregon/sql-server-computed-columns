using Spectre.Console;

namespace Spectre.Library;
public class Prompts
{
    private static void Render(Rule rule)
    {
        AnsiConsole.Write(rule);
        AnsiConsole.WriteLine();
    }
    public static void ExitPrompt(string text = "Press ENTER to exit")
    {
        AnsiConsole.WriteLine();
        Render(new Rule($"[white on blue]{text}[/]")
            .RuleStyle(Style.Parse("cyan"))
            .Centered());
        
    }
}
