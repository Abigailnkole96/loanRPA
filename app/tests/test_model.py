# Test the model predictions or any logic related to it.

# test_model.py
import unittest
from app import model  # Assuming your model is loaded inside app.py

class TestLoanModel(unittest.TestCase):
    def test_prediction(self):
        prediction = model.predict([[60000, 750, 10000]])  # Example input
        self.assertEqual(prediction[0], 1)  # Expecting approval (1)
