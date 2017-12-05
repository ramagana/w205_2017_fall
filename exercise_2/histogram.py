import sys
import pprint
import psycopg2
 
def main():

    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")


    cur = conn.cursor()
 
    if len(sys.argv) == 3:
        lower_bound = min(sys.argv[1],sys.argv[2])
        upper_bound = max(sys.argv[1],sys.argv[2])

        cur.execute("SELECT * FROM tweetwordcount WHERE count BETWEEN %s AND %s ORDER BY count DESC", ( lower_bound, upper_bound))
        records = cur.fetchall()
        for record in records:
            print '(<%s> , %s)'% (record[0], record[1])

    else: print "Incorrect number of arguments entered.\n"
    
    conn.close()


    sys.exit()
 
if __name__ == "__main__":
    main()

