
 import 'dart:developer';
import 'package:date_keeper/core/utils/help_padding.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class StatusItemSelector extends StatefulWidget {
  final TextEditingController? selectedColorText;

  StatusItemSelector({Key? key, this.selectedColorText}) : super(key: key);

  @override
  _StatusItemSelectorState createState() => _StatusItemSelectorState();
}

class _StatusItemSelectorState extends State<StatusItemSelector> {
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the passed value or default to 'None'
    _colorController = widget.selectedColorText ?? TextEditingController(text: 'None');
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the currently selected color name from TextEditingController
        Text(
          'Selected level status : ${_colorController.text}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _getColorFromString(_colorController.text),
          ),
        ),
        mediumPaddingHor,
        // Create a Row with color options
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorOption('High', Colors.red),
            _buildColorOption('Medium', Colors.orange),
            _buildColorOption('Low', Colors.green),
          ],
        ),
      ],
    );
  }

  // Helper function to build each color option
  Widget _buildColorOption(String colorName, Color color) {
    bool isSelected = _colorController.text == colorName;

    return GestureDetector(
      onTap: () {
        setState(() {
          _colorController.text = colorName; // Update the selected color in controller
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.7) : color,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: Colors.black, width: 2)
              : null, // Add border if selected
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.7) : color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 8),
            Text(
              colorName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get color based on the name
  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}



class DateItemSelector extends StatefulWidget {
  final TextEditingController dateController;
  const DateItemSelector({super.key, required this.dateController});

  @override
  State<DateItemSelector> createState() => _DateItemSelectorState();
}

class _DateItemSelectorState extends State<DateItemSelector> {
  // Function to pick a date and format it
  Future<void> _selectDate(BuildContext context, dateController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return TextFormField(
                controller: widget.dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context,widget.dateController),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              );
  }
}
