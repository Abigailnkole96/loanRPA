import pandas as pd
from sklearn.model_selection import train_test_split, StratifiedKFold
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.preprocessing import StandardScaler
import numpy as np
import pickle

# Load sample data
data = pd.read_csv('../rpa/loan_applications.csv')

# EDA
print("Data Summary:")
print(data.describe())
print("Target distribution:")
print(data['approved'].value_counts())

# Feature Engineering
# Calculate gross annual income
data['gross_annual_income'] = data['salary'] * 12

# Calculate DTI ratio as (loan_amount / gross_annual_income) * 100
data['dti_ratio'] = (data['loan_amount'] / data['gross_annual_income']) * 100

# Features and target variable
X = data[['salary', 'credit_score', 'loan_amount', 'dti_ratio']]
y = data['approved']

# Standardize features
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Using Stratified K-Folds for evaluation
skf = StratifiedKFold(n_splits=2)

for train_index, test_index in skf.split(X_scaled, y):
    X_train, X_test = X_scaled[train_index], X_scaled[test_index] 
    y_train, y_test = y.iloc[train_index], y.iloc[test_index]

    # Train the ML model
    model = LogisticRegression(class_weight='balanced')
    model.fit(X_train, y_train)

    # Make predictions on the test set
    y_pred = model.predict(X_test)
    print("Predictions:", y_pred)

    # Evaluate the model
    print("Confusion Matrix:")
    print(confusion_matrix(y_test, y_pred))

    print("Classification Report:")
    print(classification_report(y_test, y_pred))

# Save the model and scaler to files
with open('model.pkl', 'wb') as model_file:
    pickle.dump(model, model_file)

with open('scaler.pkl', 'wb') as scaler_file:
    pickle.dump(scaler, scaler_file)
