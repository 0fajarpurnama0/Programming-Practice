currency_japan = [10000, 1000, 500, 100, 50, 10, 5, 1]
currency = sorted(currency_japan, reverse=True)
price = input('Enter the price: ')
debug = input('Insert [1] for debugging mode, other characters for non debugging: ')
change = []
while price > 0:
    for i in xrange(len(currency)):
        if price >= currency[i]:
            if debug == 1:
                print "price 'Y %d' is >= currency 'Y %d'" % (price, currency[i])
                print "new price = current price 'Y %d' - currenty 'y %d'" % (price, currency[i])
            price -= currency[i]
            if debug == 1:
                print "new price = Y %d" % (price)
            change.append(currency[i])
            break
        if debug == 1:
            print "price 'Y %d' is < currency 'Y %d', >>> move to next currency 'Y %d'" % (price, currency[i], currency[i+1])
#print currency
print "Your change is:"
for i in xrange(len(change)):
    print "Y %d" % (change[i])
