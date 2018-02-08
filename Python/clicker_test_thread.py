from timeit import default_timer as timer
from requests.auth import HTTPBasicAuth
import requests
import sys
import random
import threading

def getRandomAns():
    choice = 'abcd'
    ans = random.choice(choice)
    return ans

def runtest(loop):
    numTest = 0
    answer_array=[0,0,0,0]
    succes_count=0
    fail_count=0
    for i in range(loop):
        numTest = numTest+1 
        ans = getRandomAns()
        if ans=='a': answer_array[0]=answer_array[0]+1
        if ans=='b': answer_array[1]=answer_array[1]+1
        if ans=='c': answer_array[2]=answer_array[2]+1
        if ans=='d': answer_array[3]=answer_array[3]+1

        response = requests.post('http://test.hicc.cs.kumamoto-u.ac.jp/moodle-php5/local/ClickerProject/student.php?questionID=1', auth=HTTPBasicAuth('hicc-admin', '803Mukyosh!tsU'),data={'clicker':ans})
        print("test #"+str(i+1)+": ")
        print("answer:"+ans)
        if response.status_code == requests.codes.ok:
            print("SUCCESS")
            succes_count=succes_count+1
        else:
            print("FAILED")
            fail_count=fail_count+1
        numTest=numTest+1

        print("\n")
    return answer_array,numTest,succes_count,fail_count

loop = int(input("please insert the number of test:"))
#answer_array,numTest,succes_count,fail_count,thread=Thread(target = runtest, args(loop)).start()
threading.Thread(target = runtest, args = (loop, )).start()
start = timer()
print("begin test with  "+str(loop)+" response....\n")
test_time = timer() - start
print("----------------------------------------------------")
print("test is done in %f seconds!" % test_time)
#print("number of success: "+str(succes_count)+" number of fail: "+str(fail_count))
#print("----------------------------------------------------")
#print("clicker summary A: "+str(answer_array[0])+" B: "+str(answer_array[1])+" C: "+str(answer_array[2])+" D: "+str(answer_array[3]))

