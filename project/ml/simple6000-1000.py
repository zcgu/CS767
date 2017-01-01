from keras.models import Sequential
from keras.layers import Dense, Activation
import numpy as np
from keras.utils.np_utils import to_categorical

def buildModel():
	model = Sequential()

	model.add(Dense(output_dim=3000, input_dim=6000))
	model.add(Activation("relu"))
	# model.add(Dense(output_dim=1000))
	model.add(Dense(output_dim=2))
	model.add(Activation("softmax"))

	model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

	return model

def trainModel(X_train, Y_train, model):
	model.fit(X_train, Y_train, nb_epoch=5, batch_size=32)

def evaluateModel(X_test, Y_test, model):
	loss_and_metrics = model.evaluate(X_test, Y_test, batch_size=32)
	return loss_and_metrics


def readFiles(fname):
	x = []
	y = []
	count = 0
	with open(fname) as f:
		for line in f:
			count += 1
			if count > 100: break

			line_split = [s for s in line.split(' ') if s != '']
			x.append([float(num) for num in line_split[:6000]])
			# y.append([float(num) for num in line_split[6000:]])

			c = 1 if float(line_split[6555]) > 0.5 else 0
			y.append([c])
	return x, y


x, y = readFiles('train.txt')
print len(x), len(x[0]), len(y), len(y[0])
print to_categorical(np.array(y[:len(y) / 2]), 2)
x_train, y_train = np.array(x[:len(x) / 2]), to_categorical(np.array(y[:len(y) / 2]))
x_test, y_test = np.array(x[len(x) / 2:]), to_categorical(np.array(y[len(y) / 2:]))

model = buildModel()
trainModel(x_train, y_train, model)
print evaluateModel(x_test, y_test, model)