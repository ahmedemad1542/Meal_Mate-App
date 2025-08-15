import 'package:flutter/material.dart';
import 'package:meal_mate/features/home_screen/model/meal_model.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String? imagePath;

  Future<void> pickImage() async {}

  Future<void> saveMeal() async {
    final meal = MealModel(
      name: nameController.text,
      cookingTime: int.tryParse(timeController.text) ?? 0,
      describtion: descController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.cyan);

  }
}
