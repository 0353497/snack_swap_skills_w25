import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/own_button.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/models/country.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/pages/login.dart';
import 'package:snack_swap/utils/auth_bloc.dart';
import 'package:snack_swap/utils/box_manager.dart';

class AddSnackPage extends StatefulWidget {
  const AddSnackPage({super.key});

  @override
  State<AddSnackPage> createState() => _AddSnackPageState();
}

class _AddSnackPageState extends State<AddSnackPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  List<Country> availableCountries = [];
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final User? _currentUser = AuthBloc().currentUserValue;

  @override
  void initState() {
    super.initState();
    if (_currentUser == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }


  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: $e')),
      );
      }
    }
  }
  void _saveSnack() async {
    if (_validateForm()) {
      final currentUser = AuthBloc().currentUserValue;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You need to be logged in to add a snack')),
        );
        return;
      }

      try {
        String? imagePath;
        if (_imageFile != null) {
          imagePath = await BoxManager.saveImage(_imageFile!);
        }

        final newSnack = Snack(
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          country: currentUser.country,
          userID: currentUser.userID,
          countryImgUrl: currentUser.countryImgUrl,
          imageImgUrl: imagePath,
          haveTraded: [],
        );

        await BoxManager.addSnack(newSnack);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Snack added successfully!')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving snack: $e')),
        );
        }
      }
    }
  }

  bool _validateForm() {
    String? errorMessage;
    
    if (nameController.text.trim().isEmpty) {
      errorMessage = 'Please enter a name for the snack';
    } else if (descriptionController.text.trim().isEmpty) {
      errorMessage = 'Please enter a description for the snack';
    } else if (_imageFile == null) {
      errorMessage = 'Please select an image';
    }
    
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return false;
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Add New Snack'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Snack",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: RoundedSheet(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildFormLabel(context, 'Name'),
                        _buildTextField(
                          controller: nameController,
                          hint: 'Enter snack name',
                        ),
                        const SizedBox(height: 24),
                        
                        _buildFormLabel(context, 'Description'),
                        _buildTextField(
                          controller: descriptionController,
                          hint: 'Enter snack description',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        
                        _buildFormLabel(context, 'Image'),
                        const SizedBox(height: 8),
                        _buildImageSelector(),
                        const SizedBox(height: 32),
                        
                        OwnButton(
                          text: "Save Snack",
                          onTap: _saveSnack,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const OwnBottomSheet(currentIndex: 2),
    );
  }

  Widget _buildFormLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xff3B5067),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Color(0xff222222)
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xff222222)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xffFFA87C),
            width: 2
          )
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xffFFA87C),
            width: 2
          )
        ),
      ),
    );
  }

  Widget _buildImageSelector() {
    return Center(
      child: InkWell(
        onTap: () => _pickImage(ImageSource.gallery),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xffF6D097),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xffFFA87C), width: 2),
              ),
              child: _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                      color: Color(0xffDC6B32),
                    ),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _imageFile == null ? 'Tap to select an image' : 'Tap to change image',
              style: const TextStyle(color: Color(0xff222222)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}