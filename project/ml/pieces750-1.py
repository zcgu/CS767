from keras.models import Sequential
from keras.layers import Dense, Activation, Dropout
import numpy as np
from keras.utils.np_utils import to_categorical
import random
from sklearn.metrics import confusion_matrix


N = 750		# num of features.

def buildModel():
	model = Sequential()

	model = Sequential()
	model.add(Dense(1024, input_dim=N, init='uniform', activation='sigmoid'))
	model.add(Dropout(0.5))
	model.add(Dense(1024, activation='sigmoid'))
	model.add(Dropout(0.5))
	model.add(Dense(1, activation='sigmoid'))

	model.compile(loss='binary_crossentropy',
	              optimizer='rmsprop',
	              metrics=['accuracy'])

	return model

def trainModel(X_train, Y_train, model):
	model.fit(X_train, Y_train, nb_epoch=5, batch_size=32)

def evaluateModel(X_test, Y_test, model):
	return model.evaluate(X_test, Y_test, batch_size=32)


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

			# count += 1
			# if count > 100: break

			if all(-0.00001 < data[i] < 0.00001 for i in range(N)):
				continue	

			if len(data) == 754:
				datas.append(data)

	return datas

datas = []
# for num in range(20, 21):
for num in range(20, 30):
	datas += readFiles('test_full' + str(num) + '.txt')
random.shuffle(datas)

print len(datas), len(datas[0])

x_train = np.array([data[:N] for data in datas])
y_train = np.array([data[N]  for data in datas])
p_train = [data[-3:]  for data in datas]

model = buildModel()
trainModel(x_train, y_train, model)

print 'Train done.\n'

f = open("pieces750-1_model.txt", 'w')
json_string = model.to_json()
f.write(json_string)
f.close()

model.save_weights('pieces750-1_weights.txt')


