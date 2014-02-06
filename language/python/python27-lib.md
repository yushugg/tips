datetime
constants:
    datetime.MINYEAR = 1
    datetime.MAXYEAR = 9999

class:
    datetime.date
        year
        month
        day
        today()--当前的date
        fromtimestamp(timestamp)--timestamp e.g.time.time()
        fromordinal(ordinal)
    datetime.time
        hour
        minute
        second
        microsecond
        tzinfo
    datetime.datetime--combination of a date and a time
        year
        month
        day
        hour
        minute
        second
        microsecond
        tzinfo
        today()--现在所在的时区的时间
        now([tz])--现在所在的时区的时间
        utcnow()--即格林威治时间
        fromtimestamp(timestamp[, tz])
        utcfromtimestamp(timestamp)
    datetime.timedelta--描述两个date或者time或者datetime实例的间距
        datetime.timedelta([days[, seconds[, microseconds[, milliseconds[, minutes[, hours[, weeks]]]]]]])
        min
        max
        resolution
        total_seconds()--这个duration的总秒数
    datetime.tzinfo--抽象基类，时区
        

sqlite3
1. conn = sqlite3.connect('example.db')
2. c = conn.cursor()
c.execute('select * from xxx where symbol=?', t)
c.executemany(多条语句)
c.fetchall()--return a list
c.fetchone()
c.fetchmany([size=cursor.arraysize])
conn.commit()
conn.close()


csv
functions:
    csv.reader(csvfile, dialect='excel', **fmtparams)
        返回一个read object，csvfile是file object(要以rb方式读取)或者list objects
    with open('eggs.csv', 'rb') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for row in spamreader:
            print ', '.join(row)

    csv.writer(csvfile, dialect='excel', **fmtparams)
    csvwriter.writerow(row)
    csvwriter.writerows(rows)
