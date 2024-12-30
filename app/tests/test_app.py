##Test the routes and functionality of the Flask app.

import unittest
from app import app

class TestLoanApp(unittest.TestCase):
    def setUp(self):
        # Set up a test client for the app
        self.app = app.test_client()
        self.app.testing = True

    def test_index_page(self):
        # Test the home page
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Loan Application', response.data)

    def test_loan_approval(self):
        # Test the result page for an approved loan
        response = self.app.post('/result', data={
            'salary': '60000',
            'credit_score': '750',
            'loan_amount': '10000'
        })
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Your loan application is: Approved', response.data)

    def test_loan_rejection(self):
        # Test the result page for a rejected loan
        response = self.app.post('/result', data={
            'salary': '20000',
            'credit_score': '500',
            'loan_amount': '50000'
        })
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Your loan application is: Rejected', response.data)

if __name__ == '__main__':
    unittest.main()
