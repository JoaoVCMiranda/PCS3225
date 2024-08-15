for x in range(16):
    for y in range(16):
        print('{0:04b}'.format(x), '{0:04b}'.format(y), '{0:08b}'.format(x*y))
