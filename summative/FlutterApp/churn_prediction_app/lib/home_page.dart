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
  final TextEditingController ageController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController numOfProductsController = TextEditingController();
  final TextEditingController estimatedSalaryController = TextEditingController();

  // Dropdown values
  String selectedGeography = "France";
  String selectedGender = "Male";
  String selectedHasCrCard = "1";
  String selectedIsActiveMember = "1";

  // Function to send prediction request
  Future<void> predictChurn() async {
    final url = Uri.parse("https://customer-churn-prediction-6kqk.onrender.com/predict");

    Map<String, dynamic> inputData = {
      "CreditScore": int.parse(creditScoreController.text),
      "Geography": selectedGeography,
      "Gender": selectedGender,
      "Age": int.parse(ageController.text),
      "Tenure": int.parse(tenureController.text),
      "Balance": double.parse(balanceController.text),
      "NumOfProducts": int.parse(numOfProductsController.text),
      "HasCrCard": int.parse(selectedHasCrCard),
      "IsActiveMember": int.parse(selectedIsActiveMember),
      "EstimatedSalary": double.parse(estimatedSalaryController.text)
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String prediction = responseData['churn_prediction'].toString();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(prediction: prediction)),
        );
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Churn Prediction", style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text("Enter Customer Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    
                    _buildTextField(creditScoreController, "Credit Score"),
                    _buildDropdown(["France", "Germany", "Spain"], selectedGeography, "Geography", (val) => setState(() => selectedGeography = val!)),
                    _buildDropdown(["Male", "Female"], selectedGender, "Gender", (val) => setState(() => selectedGender = val!)),
                    _buildTextField(ageController, "Age"),
                    _buildTextField(tenureController, "Tenure"),
                    _buildTextField(balanceController, "Balance"),
                    _buildTextField(numOfProductsController, "Number of Products"),
                    _buildDropdown(["1", "0"], selectedHasCrCard, "Has Credit Card?", (val) => setState(() => selectedHasCrCard = val!)),
                    _buildDropdown(["1", "0"], selectedIsActiveMember, "Is Active Member?", (val) => setState(() => selectedIsActiveMember = val!)),
                    _buildTextField(estimatedSalaryController, "Estimated Salary"),
                    
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: predictChurn,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text("Predict", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String selectedValue, String label, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        items: items.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
        onChanged: onChanged,
      ),
    );
  }
}