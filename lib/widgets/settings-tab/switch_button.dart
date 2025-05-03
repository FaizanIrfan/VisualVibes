import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isSwitched = true; // Initial state

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.black,
      value: _isSwitched,
      onChanged: (value) {
        setState(() {
          _isSwitched = value; // Toggle switch state
        });
      },
    );
  }
}