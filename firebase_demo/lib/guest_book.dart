import 'dart:async';
import 'guest_book_message.dart';
import 'package:flutter/material.dart';

import 'src/widgets.dart';

class GuestBook extends StatefulWidget {
  // Modify the following line:
  const GuestBook({
    super.key, 
    required this.addMessage, 
    required this.messages,
  });

  final FutureOr<void> Function(String message, Color c) addMessage;
  final List<GuestBookMessage> messages; // new

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();
  MessageColor messageColor =  MessageColor.black;

  @override
   Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ...to here.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                DropdownButton<MessageColor>(
                  value: messageColor,
                  onChanged: (MessageColor? newValue){
                    setState(() {
                      messageColor = newValue!;
                    });
                  },
                  items: MessageColor.values.map((MessageColor classType){
                    return DropdownMenuItem<MessageColor>(
                      value: classType, child: Text(classType.name));
                  }).toList()),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text, messageColor.rgbcolor);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Text('${message.name}: ${message.message}', style: TextStyle(color: Color(int.parse(message.color)))),
        const SizedBox(height: 8),
      ],
    );
  }
}