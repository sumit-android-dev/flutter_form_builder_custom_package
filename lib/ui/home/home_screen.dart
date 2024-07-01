import 'package:flutter/material.dart';
import 'package:form_builder_custom_package/ui/newconnectionform/new_connection_form_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const SizedBox(
          width: double.infinity,
          child: Text(
            "Home Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NewConnectionFormScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
