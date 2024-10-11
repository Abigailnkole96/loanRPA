# Contains the logic for training and saving the machine learning model that predicts loan approvals based on loan applicant data (salary, credit score, loan amount).

# The model will be trained using sample data and saved to disk so the RPA system can use it.

# Why: Machine learning adds intelligence to the RPA system by predicting loan approvals based on applicant data.

# Example Model:

# A logistic regression or decision tree classifier that predicts loan approval probabilities.

# Training the Model: This code trains a logistic regression model to predict whether a loan is approved or rejected based on salary, credit score, and loan amount.
# Model Persistence: The trained model is saved to model.pkl for use in the Flask app.

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
import pickle

# Load sample data
data = pd.read_csv('loan_applications.csv')

# Features and target variable
X = data[['salary', 'credit_score', 'loan_amount']]
y = data['approved']

# Train/test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train the ML model
model = LogisticRegression()
model.fit(X_train, y_train)

# Save the model to a file
with open('model.pkl', 'wb') as model_file:
    pickle.dump(model, model_file)
