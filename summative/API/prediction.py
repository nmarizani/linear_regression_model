from fastapi import FastAPI
from pydantic import BaseModel, conint, confloat, constr
import joblib
import numpy as np
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd


# Load the preprocessor and model
preprocessor = joblib.load("preprocessor.pkl")
model = joblib.load("churn_model.pkl")

# Initialize FastAPI app
app = FastAPI()

# Allow Flutter frontend to access FastAPI
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this to your frontend URL if needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define input data schema
class CustomerData(BaseModel):
    CreditScore: conint(ge=300, le=850)
    Geography: constr(strip_whitespace=True)
    Gender: constr(strip_whitespace=True)
    Age: conint(ge=18, le=100)
    Tenure: conint(ge=0, le=10)
    Balance: confloat(ge=0.0)
    NumOfProducts: conint(ge=1, le=4)
    HasCrCard: conint(ge=0, le=1)
    IsActiveMember: conint(ge=0, le=1)
    EstimatedSalary: confloat(ge=0.0)

@app.post("/predict")
def predict_churn(data: CustomerData):
    try:
        # Convert input data to a DataFrame
        input_df = pd.DataFrame([data.dict()])  

        # Transform input data
        transformed_data = preprocessor.transform(input_df)

        # Make prediction
        prediction = model.predict(transformed_data)
        probability = model.predict_proba(transformed_data)[:, 1]  # Get probability of churn

        return {"churn_prediction": int(prediction[0]), "churn_probability": round(float(probability[0]), 2)}

    except Exception as e:
        return {"error": str(e)}

@app.get("/")
def home():
    return {
        "Welcome to the Customer Churn Prediction API!",
        "Visit /docs for the API documentation",
    }