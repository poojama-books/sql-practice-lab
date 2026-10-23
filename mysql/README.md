# MySQL files

Everything in this folder is written for **MySQL 8.0 or later** and runs as-is. Earlier versions do not support the CTEs and window functions used in later chapters.

| File                   | What it does                                   |
|------------------------|------------------------------------------------|
| `novacart_mysql.sql`   | Creates the NovaCart tables and loads the data |
| `solutions/chNN_*.sql` | Solutions for one chapter (Chapters 4 to 27)   |
| `all_solutions.sql`    | Every solution in one file                     |

## Set up the database

**With MySQL Workbench**

1. Run `CREATE DATABASE novacart;` and then `USE novacart;`
2. Choose **File > Open SQL Script**, open `novacart_mysql.sql` and run the whole script (the lightning-bolt button).

**With the mysql command line**

```bash
mysql -u root -p -e "CREATE DATABASE novacart"
mysql -u root -p novacart < novacart_mysql.sql
```

Check the row counts against the table in the [main README](../README.md#check-your-setup).

## Run a solution

Open the chapter file, place the cursor in one query and press Ctrl+Enter. Compare the number of rows returned with the **Check Your Result** line above it.
