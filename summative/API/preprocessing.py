import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import joblib

# Load dataset
df = pd.read_csv("Churn_Modelling.csv")

# Drop irrelevant columns
df.drop(columns=["RowNumber", "CustomerId", "Surname"], inplace=True)

# Define features and target
X = df.drop(columns=["Exited"])
y = df["Exited"]

# Define preprocessing steps
categorical_features = ["Geography", "Gender"]
numerical_features = ["CreditScore", "Age", "Tenure", "Balance", "NumOfProducts", "HasCrCard", "IsActiveMember", "EstimatedSalary"]

preprocessor = ColumnTransformer([
    ("num", StandardScaler(), numerical_features),
    ("cat", OneHotEncoder(drop='first'), categorical_features)
])

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Fit preprocessor
X_train = preprocessor.fit_transform(X_train)
X_test = preprocessor.transform(X_test)

# Save processed data and transformer
joblib.dump((X_train, X_test, y_train, y_test), "processed_data.pkl")
joblib.dump(preprocessor, "preprocessor.pkl")

print("Preprocessing complete. Data saved.")
