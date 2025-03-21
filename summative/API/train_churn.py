import joblib
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Load processed data
X_train, X_test, y_train, y_test = joblib.load("processed_data.pkl")

# Train a model
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluate model
predictions = model.predict(X_test)
accuracy = accuracy_score(y_test, predictions)
print(f"Model Accuracy: {accuracy:.4f}")

# Save trained model
joblib.dump(model, "churn_model.pkl")
print("Model training complete. Model saved as churn_model.pkl")
