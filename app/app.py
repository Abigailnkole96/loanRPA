from flask import Flask, request, jsonify, render_template
import pickle
import numpy as np

app = Flask(__name__)

# Load the model and scaler
model = pickle.load(open('model.pkl', 'rb'))
scaler = pickle.load(open('scaler.pkl', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Get form data
    salary = float(request.form['salary'])  # Salary per month
    credit_score = int(request.form['credit_score'])
    loan_amount = float(request.form['loan_amount'])

    # Calculate Debt-to-Income (DTI) ratio
    annual_salary = salary * 12  # Convert monthly salary to annual
    dti_ratio = (loan_amount / annual_salary) * 100

    # Approval logic
    if salary >= 2500 and credit_score >= 700 and dti_ratio < 35:
        decision = "Approved"
        reason = "Your salary, credit score, and DTI ratio meet the approval criteria."
    elif salary < 2000:
        decision = "Rejected"
        reason = f"Your salary (€{salary}) is below the required minimum of €2,000 per month."
    elif credit_score < 650:
        decision = "Rejected"
        reason = f"Your credit score of {credit_score} is below the minimum required score of 650."
    elif dti_ratio > 40:
        decision = "Rejected"
        reason = f"Your debt-to-income (DTI) ratio of {dti_ratio:.2f}% exceeds the allowable limit of 40%."
    elif dti_ratio >= 35:
        decision = "Further review needed"
        reason = f"Your DTI ratio of {dti_ratio:.2f}% is between 35% and 40%, so further review is required."
    else:
        decision = "Further review needed"
        reason = "Some criteria do not meet the requirements, and further review is required."

    # Prepare the response to be sent back to the web app
    return render_template('result.html', 
                            decision=decision, 
                            reason=reason, 
                            salary=salary, 
                            credit_score=credit_score, 
                            loan_amount=loan_amount, 
                            dti_ratio=dti_ratio)

if __name__ == "__main__":
    app.run(debug=True)
