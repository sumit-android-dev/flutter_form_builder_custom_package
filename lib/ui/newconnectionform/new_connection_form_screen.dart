import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_package/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewConnectionFormScreen extends StatefulWidget {
  const NewConnectionFormScreen({super.key});

  @override
  State<NewConnectionFormScreen> createState() =>
      _NewConnectionFormScreenState();
}

class _NewConnectionFormScreenState extends State<NewConnectionFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  /// Image picker
  Future<void> _pickImage() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        final imagePath = image?.path ?? "";
        if(imagePath.isNotEmpty){
          _formKey.currentState?.fields['id_proof']?.didChange(getFileName(imagePath, "/"));
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        final imagePath = image?.path ?? "";
        if(imagePath.isNotEmpty){
          _formKey.currentState?.fields['id_proof']?.didChange(getFileName(imagePath, "/"));
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  String getFileName(String path, String delimiter) {
    int lastIndex = path.lastIndexOf(delimiter);
    if (lastIndex == -1) return path;
    return path.substring(lastIndex + 1);
  }

  ///--------------Image Picker---------------------

  void showCupertinoBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text(
                'Select Image from gallery',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _pickImageFromGallery();
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Take a photo from camera',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _pickImage();
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const SizedBox(
          width: double.infinity,
          child: Text(
            "New connection form",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextLabel("City/ULB Name"),
                const SizedBox(height: 4),
                _buildFormBuilderDropdown(),
                const SizedBox(height: 10),
                _buildTextLabel("e-Nagarpalika ID"),
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
                _buildTextLabel("Old ID"),
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
                _buildTextLabel("Mobile Number"),
                const SizedBox(height: 4),
                FormBuilderTextField(
                  name: 'mobile_number',
                  decoration: _buildInputDecoration("Enter mobile number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return _validator(value);
                  },
                ),
                const SizedBox(height: 10),
                _buildTextLabel("Address"),
                const SizedBox(height: 4),
                FormBuilderTextField(
                  name: 'address',
                  readOnly: true,
                  decoration: _buildInputDecoration(""),
                  keyboardType: TextInputType.phone,
                  initialValue: "Indore,m.p",
                  validator: (value) {
                    return _validator(value);
                  },
                ),
                const SizedBox(height: 10),
                _buildTextLabel("ID Proof"),
                const SizedBox(height: 4),
                FormBuilderField(
                  name: 'id_proof',
                  builder: (FormFieldState<String?> field) {
                    return TextFormField(
                      readOnly: true,
                      decoration: _buildInputDecoration("Select image"),
                      onTap: () {
                        showCupertinoBottomSheet(context);
                      },
                      validator: (value) {
                        return _validator(value);
                      },
                      controller: TextEditingController(
                        text: field.value,
                      ),
                    );
                  },
                ),
                /*FormBuilderTextField(
                  name: 'id_proof',
                  readOnly: true,
                  decoration: _buildInputDecoration("Select image"),
                  onTap: (){
                    showCupertinoBottomSheet(context);
                  },
                  validator: (value) {
                    return _validator(value);
                  },
                ),*/
                const SizedBox(height: 32),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildTextLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Set rounded corner radius
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            FocusScope.of(context).unfocus();
          }
          debugPrint(_formKey.currentState?.value.toString());
        },
        child: const Text('Save',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }

  void _printKeyValues() {
    Get.snackbar('Form Data', "${_formKey.currentState?.value.toString()}",
        snackPosition: SnackPosition.BOTTOM);
    var fields = _formKey.currentState?.fields;
    fields?.forEach((key, field) {
      if (key == "full_name") {
        if ("${field.value}" == "null") {
          Get.snackbar('Validation', "Please enter full name",
              snackPosition: SnackPosition.BOTTOM);
        }
      }
      print('Field $key has value ${field.value}');
    });
    debugPrint(_formKey.currentState?.value.toString());
  }

  FormBuilderDropdown<String> _buildFormBuilderDropdown() {
    return FormBuilderDropdown<String>(
      name: 'city_ulb_dropdown',
      style: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        focusedBorder: _border(),
        border: _border(),
        enabledBorder: _border(),
      ),
      onChanged: (value) {
        setState(() {});
      },
      hint: "Select city/ULB",
      validator: (value) {
        if (value == null) {
          return 'Please select a city/ULB name';
        }
        return null;
      },
      items: [
        'Indore',
        'Bhopal',
      ]
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
    );
  }
}
