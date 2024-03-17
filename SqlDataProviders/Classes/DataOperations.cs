using System.Data;
using Dapper;
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
            CommandText = 
                """
                SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear 
                FROM dbo.Contact;
                """
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
    
    /// <summary>
    /// Same as <seealso cref="ReadContacts()"/>
    /// </summary>
    public static List<Contact> ReadContactsDapper()
    {

        using var cn = new SqlConnection(ConnectionString());
  
        return cn.Query<Contact>("""
                                 SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear
                                 FROM dbo.Contact;
                                 """).AsList(); 
    }

    public static async Task<List<Contact>> ReadContactsDapperAsync()
    {
        await using var cn = new SqlConnection(ConnectionString());

        return  (await cn.QueryAsync<Contact>("""
                                                  SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear
                                                  FROM dbo.Contact;
                                                  """)).AsList();
    }

    public static List<Contact> ReadContactsDapper(int yearsOld)
    {
        List<Contact> list = new();

        using var cn = new SqlConnection(ConnectionString());
        return cn.Query<Contact>("""
                                 SELECT Id, FirstName, LastName, BirthDate, YearsOld, FullName, BirthYear 
                                 FROM dbo.Contact 
                                 WHERE (YearsOld > @Old);
                                 """, new {Old = yearsOld}).AsList();
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
