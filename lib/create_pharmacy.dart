// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';

class TimeSlot {
  TimeOfDay openTime;
  TimeOfDay closeTime;
  TimeSlot({required this.openTime, required this.closeTime});
}

class CreatePharmacy extends StatefulWidget {
  const CreatePharmacy({super.key});

  @override
  State<CreatePharmacy> createState() => _CreatePharmacyState();
}

class _CreatePharmacyState extends State<CreatePharmacy> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  List<TimeSlot> timeSlots = [];

  // Form controllers
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? _imageFile =
        await picker.pickImage(source: ImageSource.gallery);
  }

  Future<TimeOfDay?> _selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
  }

  void _addTimeSlot() async {
    final TimeOfDay? openTime = await _selectTime(context, TimeOfDay.now());
    if (openTime != null) {
      final TimeOfDay? closeTime = await _selectTime(context, openTime);
      if (closeTime != null) {
        setState(() {
          timeSlots.add(TimeSlot(openTime: openTime, closeTime: closeTime));
        });
      }
    }
  }

  void _removeTimeSlot(int index) {
    setState(() {
      timeSlots.removeAt(index);
    });
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: null,
        elevation: 0,
        primary: true,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor!.withAlpha(200),
        toolbarHeight: 90,
        title: const Text(
          "Farmace",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://picsum.photos/800/900",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8,
              sigmaY: 8,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 180),
                            // Image picker
                            ImagePickerButton(),
                            const SizedBox(height: 24),
                            // Name field
                            NameField(nameController: _nameController),
                            const SizedBox(height: 16),
                            // Address field
                            AddressField(),
                            const SizedBox(height: 16),
                            // Time slots section

                            PhoneField(),
                            const SizedBox(height: 16),
                            // Phone field
                            TimeSelector(),
                            const SizedBox(height: 24),
                            // Submit button
                            ConfirmButton(context),
                            const SizedBox(height: 16),
                            // Cancel button
                            const SizedBox(height: 26),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  if (timeSlots.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add at least one opening time'),
                      ),
                    );
                    return;
                  }
                  // TODO: Implement pharmacy creation logic
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Create Pharmacy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  GestureDetector ImagePickerButton() {
    return GestureDetector(
      onTap: _pickImage, // FIX: Crashes the app while trying to pick the image
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: _imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.white.withOpacity(0.9),
              ),
      ),
    );
  }

  TextFormField AddressField() {
    return TextFormField(
      controller: _addressController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        labelText: 'Address',
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        prefixIcon: const Icon(Icons.location_on, color: Colors.white),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter address';
        }
        return null;
      },
    );
  }

  Container TimeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Opening Hours',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: _addTimeSlot,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...timeSlots.asMap().entries.map((entry) {
            final index = entry.key;
            final slot = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_formatTimeOfDay(slot.openTime)} - ${_formatTimeOfDay(slot.closeTime)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () => _removeTimeSlot(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          if (timeSlots.isEmpty)
            Center(
              child: Text(
                'Add opening hours',
                style: TextStyle(color: Colors.white.withOpTimeSelector(),acity(0.5)),
              ),
            ),
        ],
      ),
    );
  }

  TextFormField PhoneField() {
    return TextFormField(
      controller: _phoneController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        labelText: 'Phone Number',
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        prefixIcon: const Icon(Icons.phone, color: Colors.white),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        labelText: 'Pharmacy Name',
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        prefixIcon: const Icon(Icons.store, color: Colors.white),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter pharmacy name';
        }
        return null;
      },
    );
  }
}
