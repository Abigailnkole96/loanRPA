import csv
from sklearn.model_selection import train_test_split
import numpy as np
import tensorflow as tf


X = []
Y = []
with open('./data.csv', mode ='r')as file:
  csvFile = csv.reader(file)
  for lines in csvFile:
        line = []
        for i in range(1, 4):
            line.append(float(lines[i]))

        X.append(line)
        Y.append(int(lines[4]))

X_train, X_test, Y_train, Y_test = train_test_split(np.array(X), np.array(Y), test_size=0.2, random_state=42)


tf.random.set_seed(42)
tf.config.set_visible_devices([], 'GPU')
model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(1, activation='sigmoid')
])

model.compile(
    loss=tf.keras.losses.BinaryCrossentropy(),
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    metrics=[
        tf.keras.metrics.BinaryAccuracy(name='accuracy')
    ]
)

history = model.fit(X_train, Y_train, epochs=100, validation_data=(X_test, Y_test))

model.save('model.keras')