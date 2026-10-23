# SQL Server files

Everything in this folder is written for **SQL Server 2016 or later** (including Azure SQL Database) and runs as-is.

| File                     | What it does                                   |
|--------------------------|------------------------------------------------|
| `novacart_sqlserver.sql` | Creates the NovaCart tables and loads the data |
| `solutions/chNN_*.sql`   | Solutions for one chapter (Chapters 4 to 27)   |
| `all_solutions.sql`      | Every solution in one file                     |

## Set up the database

**With SQL Server Management Studio (SSMS) or Azure Data Studio**

1. Run `CREATE DATABASE novacart;`
2. Choose `novacart` in the database drop-down.
3. Open `novacart_sqlserver.sql` and run the whole script (F5).

**With sqlcmd**

```bash
sqlcmd -S localhost -E -Q "CREATE DATABASE novacart"
sqlcmd -S localhost -E -d novacart -i novacart_sqlserver.sql
```

Use `-U <user> -P <password>` instead of `-E` if you sign in with a SQL Server login.

Check the row counts against the table in the [main README](../README.md#check-your-setup).

## Run a solution

Open the chapter file, highlight one query and press F5. Compare the number of rows returned with the **Check Your Result** line above it.

## Good to know

Exercise 81 starts with `SET DATEFIRST 1;` so that Monday is day 1. This setting lasts until you close the query window.
