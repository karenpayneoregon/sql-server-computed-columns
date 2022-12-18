--- get a list of computed columns in a SQL Server database
SELECT SCHEMA_NAME(o.schema_id) AS schema_name, 
    c.name AS column_name, 
    OBJECT_NAME(c.object_id) AS table_name, 
    TYPE_NAME(user_type_id) AS data_type, 
    definition
FROM sys.computed_columns c
  JOIN sys.objects o ON o.object_id = c.object_id
ORDER BY schema_name, 
      table_name, 
      column_id;