using System.Data;
using Microsoft.Data.SqlClient;
using SqlDataProviders.Models;
using static ConfigurationLibrary.Classes.ConfigurationHelper;

namespace SqlDataProviders.Classes;
internal class DataOperations
{
    public static List<Contact> ReadContacts()
    {
        List<Contact> list = new();

        using var cn = new SqlConnection(ConnectionString());
        using var cmd = new SqlCommand
        {
            Connection = cn,
            CommandText = "SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear FROM dbo.Contact;"
        };

        cn.Open();
        var reader = cmd.ExecuteReader();
      
        while (reader.Read())
        {
            list.Add(new Contact()
            {
                Id = reader.GetInt32(0), 
                FirstName = reader.GetString(1), 
                LastName = reader.GetString(2), 
                BirthDate = reader.GetDateTime(3), 
                YearsOld = reader.GetInt32(4), 
                FullName = reader.GetString(5), BirthYear = reader.GetInt32(6)
            });
        }
        return list;
    }

    public static List<Contact> ReadContacts(int yearsOld)
    {
        List<Contact> list = new();

        using var cn = new SqlConnection(ConnectionString());
        using var cmd = new SqlCommand
        {
            Connection = cn,
            CommandText = 
                """
                SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear 
                FROM dbo.Contact 
                WHERE (YearsOld > @Old);
                """
        };

        cmd.Parameters.Add("@Old", SqlDbType.Int).Value = yearsOld;

        cn.Open();
        var reader = cmd.ExecuteReader();

        while (reader.Read())
        {
            list.Add(new Contact()
            {
                Id = reader.GetInt32(0),
                FirstName = reader.GetString(1),
                LastName = reader.GetString(2),
                BirthDate = reader.GetDateTime(3),
                YearsOld = reader.GetInt32(4),
                FullName = reader.GetString(5),
                BirthYear = reader.GetInt32(6)
            });
        }
        return list;
    }
}
