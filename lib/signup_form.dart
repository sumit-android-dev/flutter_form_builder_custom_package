import 'package:flutter/material.dart';
import 'package:form_builder_package/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  _border([Color color = Colors.grey]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      );

  _buildInputDecoration(String labelText) => InputDecoration(
      labelText: null,
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      focusedBorder: _border(),
      border: _border(),
      enabledBorder: _border());

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This is required field";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New connection form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "City/ULB Name",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                FormBuilderDropdown<String>(
                  name: 'city_ulb_dropdown',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: null,
                    hintText: "",
                    hintStyle: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    focusedBorder: _border(),
                    border: _border(),
                    enabledBorder: _border(),
                  ),
                  initialValue: "Select City/ULB",
                  onChanged: (value) {
                    setState(() {});
                  },

                  validator: (value) {
                    if (value == null || value == "Select City/ULB") {
                      return 'Please select a city/ULB name';
                    }
                    return null;
                  },
                  items: [
                    'Select City/ULB',
                    'Indore',
                    'Bhopal',
                  ]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
                const Text(
                  "e-Nagarpalika ID",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                FormBuilderTextField(
                  name: 'e_nagar_palika_id',
                  decoration: _buildInputDecoration("Enter e-Nagarpalika ID"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return _validator(value);
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Old ID",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                FormBuilderTextField(
                  name: 'old_id',
                  decoration: _buildInputDecoration("Enter old ID"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return _validator(value);
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Mobile Number",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                FormBuilderTextField(
                  name: 'mobile_number',
                  decoration: _buildInputDecoration("Enter mobile number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return _validator(value);
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set rounded corner radius
                      ),
                      backgroundColor: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        Get.snackbar('Form Data',
                            "${_formKey.currentState?.value.toString()}",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                      var fields = _formKey.currentState?.fields;
                      // Loop through each field
                      fields?.forEach((key, field) {
                        // Print or check the field's value
                        if (key == "full_name") {
                          if ("${field.value}" == "null") {
                            Get.snackbar('Validation', "Please enter full name",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }
                        print('Field $key has value ${field.value}');
                      });
                      debugPrint(_formKey.currentState?.value.toString());
                    },
                    child: const Text('Search',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
