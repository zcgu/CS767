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
		
			line_split = [s for s in line.split(' ') if s != '']
			data = [float(num) for num in line_split[:N + 1]]
			data[N] = 1 if data[N] > 0.5 else 0

			if -0.00001 < all(data[:N]) < 0.00001:
				continue
	
			count += 1
			if count > 10000: break
	
			datas.append(data)
	return datas


data1 = readFiles('train_center_on_fiber.txt')
data2 = readFiles('train_center_others.txt')

datas_origin = data1 + data2
random.shuffle(datas_origin)

for i in [100, 250, 500, 750, 1000, 2500, 5000, 7500, 10000, 20000]:
	print '\ni = ' + str(i) + '\n'
	datas = datas_origin[:i]

	l = len(datas) * 2 / 3
	x_train = np.array([data[:N] for data in datas[:l]])
	y_train = np.array([data[N] for data in datas[:l]])
	x_test  = np.array([data[:N] for data in datas[l:]])
	y_test  = np.array([data[N] for data in datas[l:]])


	model = buildModel()
	trainModel(x_train, y_train, model)
	print evaluateModel(x_test, y_test, model)

	y_pred = predict(x_test, model)
	print confusion_matrix(y_test, y_pred)

# f = open("simple750-1_output.txt", 'w')
# for num in predict(x_test, model):
# 	f.write(str(num)[1] + '\n')
# f.close()

