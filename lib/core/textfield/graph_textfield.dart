import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

//Переписать следующим образом: передавать в клетку правильный ответ, в случае, если бул равен тру, вставлять ответ в ячейку, иначе делать длину ввода в качестве длины числа
class GraphTextField extends StatefulWidget {
  final TextEditingController controller;
  const GraphTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<GraphTextField> createState() => _GraphTextFieldState();
}

class _GraphTextFieldState extends State<GraphTextField> {
  Color _textFieldColor = AppColors.grayContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: _textFieldColor, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        style: getTheme().textTheme.bodyLarge,
        decoration: InputDecoration(
            hintStyle: getTheme().textTheme.bodyLarge,
            border: InputBorder.none,
            counterText: '',
            fillColor: _textFieldColor),
        // onSubmitted: (value) {
        //   if (widget.isEducation) {
        //     setState(() {
        //       _textFieldColor = value == widget.answer.toString()
        //           ? AppColors.grayContainer
        //           : AppColors.red;
        //     });
        //   }
        // },
      ),
    );
  }
}
