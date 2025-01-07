from flask import Flask, request, jsonify, render_template
import pickle
import numpy as np
import tensorflow as tf

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')                      

@app.route('/predict', methods=['POST'])
def predict():
    # Get form data
    salary = float(request.form['salary'])  # Salary per month
    credit_score = float(request.form['credit_score'])
    loan_amount = float(request.form['loan_amount'])

    model = tf.keras.models.load_model('./machine_learning/model.keras')
    input_data = np.array([[salary, credit_score, loan_amount]])
    output = round(model.predict(input_data)[0][0])
    if output == 0:
        decision = "Rejected"
    else:
        decision = "Approved"

    # Prepare the response to be sent back to the web app
    return render_template('result.html', 
                            decision=decision, 
                            salary=salary, 
                            credit_score=credit_score, 
                            loan_amount=loan_amount)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
                                           