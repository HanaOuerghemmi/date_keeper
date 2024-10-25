
 import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

 class StatusItemSelector extends StatefulWidget {
   StatusItemSelector({super.key,  this.selectedColor});
Color? selectedColor;
  @override
  State<StatusItemSelector> createState() => _StatusItemSelectorState();
}

class _StatusItemSelectorState extends State<StatusItemSelector> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
                height: 80,
                child: Center(
                  child: BlockPicker(
                    pickerColor: widget.selectedColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        widget.selectedColor = color;
                      });
                    },
                    availableColors: [
                      Colors.red,
                      Colors.yellow,
                      Colors.green
                    ],
                  ),
                ),
              );
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

class UserItemsSelector extends StatefulWidget {
   UserEntity? selectedUser;
  final List<UserEntity> users ;
   UserItemsSelector({super.key, required this.selectedUser, required this.users});

  @override
  State<UserItemsSelector> createState() => _UserItemsSelectorState();
}

class _UserItemsSelectorState extends State<UserItemsSelector> {
  @override
  Widget build(BuildContext context) {
    return 

      Container(
                  child: DropdownButton<UserEntity>(
                    value: widget.selectedUser,
                    hint: Text('Select a user'),
                    isExpanded: true,
                    onChanged: (UserEntity? newValue) {
                      setState(() {
                        widget.selectedUser = newValue;
                      });
                    },
                    items: widget.users.map((UserEntity user) {
                      return DropdownMenuItem<UserEntity>(
                        value: user,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user.profilePictureUrl!),
                              radius: 16,
                            ),
                            SizedBox(width: 10),
                            Text(user.username!),
                          ],
                        ),
                      ); }).toList(),
                  ),
                );
    
  }
}