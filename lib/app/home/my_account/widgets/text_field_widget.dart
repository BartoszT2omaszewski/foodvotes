import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const TextFieldWidget(
      {Key? key,
      required this.title,
      required this.controller,
      this.onChanged,
      this.onTap})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  Color iconColor = Colors.white60;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      iconColor =
          widget.controller.text.isEmpty ? Colors.white : Colors.white60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white54,
            ),
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              suffixIcon: widget.onTap != null
                  ? IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white60,
                        size: 30,
                      ),
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              hintText: widget.title,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white54,
              ),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
