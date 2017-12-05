
from __future__ import absolute_import, print_function, unicode_literals

import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


def main():

    # Connect to the database
    conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

    #Create the Database

    try:
        # CREATE DATABASE can't run inside a transaction
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cur = conn.cursor()
        cur.execute("CREATE DATABASE tcount")
        cur.close()
        conn.close()
    except:
        print("Could not create tcount.\n tcount database may already exist.")

    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    cur = conn.cursor()
    
    # User input if they would like to a new table if the table already exists

    cur.execute("SELECT NOT EXISTS (SELECT datname FROM pg_database WHERE datname = 'tcount')")
    if cur.fetchone()[0] == True:
    # Create the tweetwordcount table
        cur = conn.cursor()
        cur.execute('''CREATE TABLE tweetwordcount
            (word TEXT PRIMARY KEY     NOT NULL,
            count INT     NOT NULL);''')
        conn.commit()


    else: 
        while True:
            clear_table = raw_input("tweetwordcount table already exists in tcount database.  Would you like to delete and create a new one? (yes/no/abort):").lower().strip()           
            if clear_table == 'yes':
                cur.execute("DROP TABLE tweetwordcount")
                conn.commit()
                cur.close()

                # Create the tweetwordcount table
                cur = conn.cursor()
                cur.execute('''CREATE TABLE tweetwordcount
                (word TEXT PRIMARY KEY     NOT NULL,
                count INT     NOT NULL);''')
                conn.commit()

                cur.close()
                break
            elif clear_table == 'no':
                print('data will be added to existing database')
                cur.close()
                break
            elif clear_table == 'abort':
                conn.close()
                sys.exit()
                break
            else:
                print("Invalid entry")
                continue

    cur.close()
    conn.close()
    print("Exit db_create.py")

    sys.exit()


if __name__ == "__main__":
    main()


