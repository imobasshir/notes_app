import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descreptionController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String text;

  const DialogBox({
    Key? key,
    required this.titleController,
    required this.descreptionController,
    required this.onSave,
    required this.onCancel,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descreptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
            ),
            const SizedBox(height: 8),
            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                ElevatedButton(
                  onPressed: onSave,
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 8),
                // cancel button
                ElevatedButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
