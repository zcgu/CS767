from keras.models import Sequential, model_from_json
from keras.layers import Dense, Activation, Dropout
import numpy as np
from keras.utils.np_utils import to_categorical
import random
from sklearn.metrics import confusion_matrix

N = 750

def predict(X_test, model):
	return model.predict_classes(X_test, batch_size=32)

def readFiles(fname):
	datas = []
	count = 0
	with open(fname) as f:
		for line in f:

			line_split = [s for s in line.strip('\r\n').split(' ') if s != '']
			data = [float(num) for num in line_split[:N + 1]]
			data[N] = 1 if data[N] > 0.5 else 0
			data += line_split[-3:]

			if all(-0.00001 < data[i] < 0.00001 for i in range(N)):
				continue
	
			# count += 1
			# if count > 100: break

			datas.append(data)

	return datas

datas = readFiles('train_center.txt')

model = None

with open("simple750-1_model.txt") as f:
	for line in f:
		model = model_from_json(line)
		break

model.load_weights('simple750-1_weights.txt')

x_test  = np.array([data[:N] for data in datas])
y_test  = np.array([data[N]  for data in datas])
p_test = [data[-3:]  for data in datas]

f = open("simple750-1_output.txt", 'w')
for i, num in enumerate(predict(x_test, model)):
	if str(num)[1] == '1':
		line = p_test[i]
		f.write(' '.join(line) + '\n')
f.close()

print 'Output done.\n'
