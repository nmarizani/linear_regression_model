import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController creditScoreController = TextEditingController();
  final TextEditingController geographyController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController numOfProductsController = TextEditingController();
  final TextEditingController hasCrCardController = TextEditingController();
  final TextEditingController isActiveMemberController = TextEditingController();
  final TextEditingController estimatedSalaryController = TextEditingController();

  // Function to send prediction request
  Future<void> predictChurn() async {
  final url = Uri.parse("https://customer-churn-prediction-pfei.onrender.com/predict");

  Map<String, dynamic> inputData = {
    "CreditScore": int.parse(creditScoreController.text),
    "Geography": geographyController.text,
    "Gender": genderController.text,
    "Age": int.parse(ageController.text),
    "Tenure": int.parse(tenureController.text),
    "Balance": double.parse(balanceController.text),
    "NumOfProducts": int.parse(numOfProductsController.text),
    "HasCrCard": int.parse(hasCrCardController.text),
    "IsActiveMember": int.parse(isActiveMemberController.text),
    "EstimatedSalary": double.parse(estimatedSalaryController.text)
  };

  try {
    print("Sending data: ${jsonEncode(inputData)}"); // Debugging

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(inputData),
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String prediction = responseData['predicted_value'].toString();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(prediction: prediction)),
      );
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error: $error");  // Debugging
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $error")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Churn Prediction")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: creditScoreController, decoration: InputDecoration(labelText: "Credit Score")),
              TextFormField(controller: geographyController, decoration: InputDecoration(labelText: "Geography")),
              TextFormField(controller: genderController, decoration: InputDecoration(labelText: "Gender (Male/Female)")),
              TextFormField(controller: ageController, decoration: InputDecoration(labelText: "Age")),
              TextFormField(controller: tenureController, decoration: InputDecoration(labelText: "Tenure")),
              TextFormField(controller: balanceController, decoration: InputDecoration(labelText: "Balance")),
              TextFormField(controller: numOfProductsController, decoration: InputDecoration(labelText: "Number of Products")),
              TextFormField(controller: hasCrCardController, decoration: InputDecoration(labelText: "Has Credit Card (1/0)")),
              TextFormField(controller: isActiveMemberController, decoration: InputDecoration(labelText: "Is Active Member (1/0)")),
              TextFormField(controller: estimatedSalaryController, decoration: InputDecoration(labelText: "Estimated Salary")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: predictChurn, child: Text("Predict"))
            ],
          ),
        ),
      ),
    );
  }
}

