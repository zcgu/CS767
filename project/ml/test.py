f = open('d.txt', 'w')

for _ in range(10):
	line = ['0'] * 350 + ['10'] * 400 + ['0']
	f.write(' '.join(line))
	f.write('\n')

for _ in range(10):
	line = ['10'] * 350  + ['0'] * 400 + ['1']
	f.write(' '.join(line))
	f.write('\n')

f.close()
