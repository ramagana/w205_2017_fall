import sys
import pprint
import psycopg2

#import matplotlib.pyplot as plt


def main():

    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")


    cur = conn.cursor()
 
    if len(sys.argv) == 1:
        cur.execute("SELECT * FROM tweetwordcount ORDER BY count DESC LIMIT 20")
        records = cur.fetchall()
        print '['
        for record in records:
            print '("%s", %s),'% (record[0], record[1])
        print ']'

    else: print 'Incorrect number of arguments.'


#    plt.figure()
#    words = [record[0] for record in records]
#    counts = [record[1] for record in records]

#    plt.bar(range(len(words)), counts)
#    plt.xticks(range(len(words)), words, rotation = 60)
#    plt.title("Top 20 Words")
#    plt.show()
    
    conn.close()

    sys.exit()
 
if __name__ == "__main__":
    main()







