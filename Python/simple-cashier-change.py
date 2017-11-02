currency_japan = [10000, 1000, 500, 100, 50, 10, 5, 1]
currency = sorted(currency_japan, reverse=True)
price = input('Enter the price: ')
change = []

while price > 0:
    for i in xrange(len(currency)):
        if price >= currency[i]:
            price -= currency[i]
            change.append(currency[i])
            break

print "Your change is:"
for i in xrange(len(change)):
    print "Y %d" % (change[i])
