# The core RPA script that simulates the loan application review process. It reads loan applications from a CSV file, processes them, and uses the machine learning model to decide whether to approve or reject each loan.

# Why: This script automates the repetitive task of loan approval, demonstrating RPA in action.

# Process:

# Reads from the sample file loan_applications.csv.
# Loads the ML model from ml_model.py to predict approval or rejection.
# Processes each application and stores results for further action.

# Automating Decisions: This script processes a list of loan applications by running them through the trained machine learning model.
# RPA Workflow: The logic mimics what a human would do by reading a CSV file, using the ML model for decisions, and saving the results.

import pandas as pd
import pickle

# Load loan applications data
loan_data = pd.read_csv('loan_applications.csv')

# Load the pre-trained model
with open('model.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

# Process loan applications
loan_data['approved'] = model.predict(loan_data[['salary', 'credit_score', 'loan_amount']])

# Save the results
loan_data.to_csv('processed_loans.csv', index=False)
print("Loan applications processed successfully.")
