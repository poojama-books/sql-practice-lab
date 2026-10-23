# PostgreSQL files

Everything in this folder is written for **PostgreSQL 10 or later** and runs as-is.

| File                      | What it does                                   |
|---------------------------|------------------------------------------------|
| `novacart_postgresql.sql` | Creates the NovaCart tables and loads the data |
| `solutions/chNN_*.sql`    | Solutions for one chapter (Chapters 4 to 27)   |
| `all_solutions.sql`       | Every solution in one file                     |

## Set up the database

**With pgAdmin**

1. Right-click **Databases** and choose **Create > Database**. Name it `novacart`.
2. Select `novacart`, open the **Query Tool**, open `novacart_postgresql.sql` and run it (F5).

**With psql**

```bash
createdb novacart
psql -d novacart -f novacart_postgresql.sql
```

Check the row counts against the table in the [main README](../README.md#check-your-setup).

## Run a solution

Open the chapter file in the Query Tool, highlight one query and press F5. Compare the number of rows returned with the **Check Your Result** line above it.
