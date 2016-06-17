import time
import schedule

def print_time():
    print("Inside print_time: ",time.ctime())


schedule.every(1).minutes.do(print_time)

while True:
    print time.ctime()
    schedule.run_pending()
    time.sleep(10)
