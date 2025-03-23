# Linear_regression_summative

# Customer Churn Prediction App 

**🚀 Project Goal**
The goal of this project is to predict customer churn (whether a customer will leave or stay with a company) based on various factors such as age, tenure, geography, balance, and estimated salary.

**This is implemented using:**
A Machine Learning API (FastAPI) – A backend service that processes user input and returns predictions.
A Flutter Mobile App – A user-friendly front-end where users enter customer details and receive churn predictions.

## Project Breakdown
A. Machine Learning Model
The ML model is trained using a dataset containing customer information and whether they churned or not. The pipeline includes:
1.  Data Preprocessing: Handling missing values, encoding categorical variables, and scaling numerical data.
2. Feature Engineering: Selecting relevant variables that affect churn.
3. Model Training: We trained two models (Decision Tree & Random Forest) and selected the best-performing one.
4. Performance Evaluation: Accuracy and feature importance analysis were used to validate the model.
5. Saving the Model: The final model was saved using joblib for later use in the API.

B.  FastAPI Backend (Machine Learning API) (**uses different dataset from machine learning model**)
A REST API was built using FastAPI to make real-time predictions. It:
1. Accepts input data via a POST request.
2. Uses the trained ML model to predict churn.
3. Returns predictions in JSON format.
4. Implements Pydantic validation for input constraints.
5. Uses CORS Middleware to allow communication with the Flutter app.
6. Hosted online on Render.

## Example API Request:
## 🌍 Live API Endpoint
**Base URL:**  
https://customer-churn-prediction-6kqk.onrender.com

## How to Test in Swagger UI
**Open Swagger UI.**
Access API Docs:https://customer-churn-prediction-6kqk.onrender.com/docs

Click on POST /predict.
Click Try it out and enter sample input.
{
    "CreditScore": 450,
    "Geography": "France",
    "Gender": "Male",
    "Age": 65,
    "Tenure": 2,
    "Balance": 120000,
    "NumOfProducts": 2,
    "HasCrCard": 0,
    "IsActiveMember": 0,
    "EstimatedSalary": 20000
  }'
Click Execute and check the response.

## 📱 Flutter Mobile App
**Installation & Running the App**
Clone this repository
git clone https://github.com/nmarizani/linear_regression_model.git

cd summative/FlutterApp/churn_prediction_app

**Install dependencies**
flutter pub get

**Run the app**
flutter run

## 📺 YouTube Demo
🎥 Watch the demo: https://youtu.be/84FmHXZ27rY
