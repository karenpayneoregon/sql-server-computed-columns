namespace VersioningLibrary;

public static class Extensions
{
    public static Version IncrementMajor(this Version sender, int increment = 1) 
        => new(sender.Major + increment, sender.Minor, sender.Build, sender.Revision);

    public static Version IncrementMinor(this Version sender, int increment = 1) 
        => new (sender.Major, sender.Minor + increment, sender.Build, sender.Revision);

    public static Version IncrementBuild(this Version sender, int increment = 1) 
        => new (sender.Major, sender.Minor, sender.Build + increment, sender.Revision);

    public static Version IncrementRevision(this Version sender, int increment = 1) 
        => new (sender.Major, sender.Minor, sender.Build, sender.Revision + increment);
}