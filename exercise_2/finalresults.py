import sys
import pprint
import psycopg2
 
def main():

    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
    cur = conn.cursor()
 
    if len(sys.argv) == 1:
        cur.execute("SELECT * FROM tweetwordcount ORDER BY  word ASC")
        records = cur.fetchall()
        for record in records:
            print '(<%s> , %s)'% (record[0], record[1])
    elif len(sys.argv) == 2:
        word = sys.argv[1]
        cur.execute("SELECT count FROM tweetwordcount WHERE word = %s", (word,))
        records = cur.fetchone()
        print 'Count of "%s": %d'% (word, records[0])
    else: print 'Incorrect number of arguments.\n'

    conn.close()    
    sys.exit()
 
if __name__ == "__main__":
    main()
