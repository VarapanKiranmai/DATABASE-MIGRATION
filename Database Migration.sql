import mysql.connector
import psycopg2
from psycopg2.extras import execute_values

# MySQL Connection
mysql_conn = mysql.connector.connect(
    host="your_mysql_host",
    user="your_mysql_user",
    password="your_mysql_password",
    database="your_mysql_database"
)
mysql_cursor = mysql_conn.cursor(dictionary=True)

# PostgreSQL Connection
pg_conn = psycopg2.connect(
    host="your_postgres_host",
    user="your_postgres_user",
    password="your_postgres_password",
    database="your_postgres_database"
)
pg_cursor = pg_conn.cursor()

# Fetch data from MySQL
mysql_cursor.execute("SELECT * FROM your_table")
data = mysql_cursor.fetchall()

# Insert data into PostgreSQL
if data:
    columns = data[0].keys()
    query = f"INSERT INTO your_table ({', '.join(columns)}) VALUES %s"
    values = [[row[col] for col in columns] for row in data]
    execute_values(pg_cursor, query, values)
    pg_conn.commit()

# Close connections
mysql_cursor.close()
mysql_conn.close()
pg_cursor.close()
pg_conn.close()

print("Data migration completed successfully.")
