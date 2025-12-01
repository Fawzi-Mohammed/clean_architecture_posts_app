import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.isUpdatePost,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      
      style: ButtonStyle(
        
     shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // no rounding → rectangle
      ),
    ),
        backgroundColor: WidgetStateProperty.all(Color(0xff082659)),
        iconColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: onPressed,
      icon: isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
      label: Text(
        isUpdatePost ? "Update" : "Add",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
