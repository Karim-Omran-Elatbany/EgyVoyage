import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField.customFormTextField({
    super.key,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.filled = false,
    this.textInputType,
    this.suicon,
    this.preicon,
    this.onChange,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.autofillHints,
    this.enabled,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final void Function()? onTap;
  final bool? obscureText;
  final bool filled;
  final String? errorText;
  final bool readOnly;
  final Icon? preicon;
  final IconButton? suicon;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        enabled: enabled,
        autofillHints: autofillHints,
        controller: controller,
        readOnly: readOnly,
        keyboardType: textInputType,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.bodyText1,
        obscureText: obscureText!,
        onTap: onTap,
        validator: validator ?? (data) {
          if (data!.isEmpty) {
            return 'Field is Required';
          }
          return null;
        },
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14),
          filled: filled,
          isDense: true,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          hintText: hintText,
          prefixIcon: preicon != null
              ? Icon(preicon!.icon, color: Theme.of(context).iconTheme.color)
              : null,
          suffixIcon: suicon,
          errorText: errorText,
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          enabledBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(24),
              right: Radius.circular(24),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.black,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(24),
              right: Radius.circular(24),
            ),
            borderSide: BorderSide(
              color: Color(0xffd0bb12),
            ),
          ),
        ),
      ),
    );
  }
}
