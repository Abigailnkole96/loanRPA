# Loan RPA Project

## Table of Contents

- [Loan RPA Project](#loan-rpa-project)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Features](#features)
  - [Tech Stack](#tech-stack)
  - [Installation](#installation)

## Introduction

The **Loan RPA Project** is a Robotic Process Automation (RPA) application designed to streamline loan processing tasks. This project automates various aspects of loan management, improving efficiency and accuracy in handling loan applications.

## Features

- Automated loan calculations based on user input.
- User-friendly interface for loan application submission.
- Integration with a database for storing and retrieving loan information.
- Detailed reporting features for loan status tracking.
- Error handling and validation for user inputs.

## Tech Stack

This project utilizes the following technologies:

- **Backend**: Python
- **Web Framework**: Flask
- **Database**: SQLite (or another database if applicable)
- **Testing**: Pytest
- **Version Control**: Git

## Installation

To set up the project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/loanRPA.git
   cd loanRPA

2. Create a virtual environment:
   python -m venv venv

3. Activate the virtual environment:

On Windows:
venv\Scripts\activate

On macOS/Linux:
source venv/bin/activate

4. Install the required packages:

pip install -r requirements.txt

Usage
To run the application, execute the following command:

flask run

Then, navigate to http://127.0.0.1:5000 in your web browser to access the application.

Endpoints
/: Home page
/apply: Loan application form
/status: Check the status of a loan application

Testing

To run the tests for this project, use the following command:

pytest app/tests/

Make sure you have Pytest installed, and your tests are organized correctly in the app/tests/ directory.


