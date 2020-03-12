import 'package:flutter/material.dart';

/// Private __SingleInputDialog class
class __SingleInputDialog extends StatefulWidget {
  final String title;
  final String label;
  final String value;
  final String positiveText;
  final String negativeText;
  final String neutralText;
  final Function positiveAction;
  final Function negativeAction;
  final Function neutralAction;
  final TextInputType keyboardType;
  final bool obscure;
  final int minLines;
  final int maxLines;
  final Function validator;

  __SingleInputDialog({
    this.title = "Input",
    this.label = "Input Field",
    this.value = "",
    this.positiveText = "Submit",
    this.positiveAction,
    this.negativeText = "Clear",
    this.negativeAction,
    this.neutralText = "Close",
    this.neutralAction,
    this.keyboardType,
    this.obscure = false,
    this.minLines,
    this.maxLines,
    this.validator,
  });

  @override
  __SingleInputDialogState createState() => __SingleInputDialogState();
}

class __SingleInputDialogState extends State<__SingleInputDialog> {
  final _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _isValid;

  _validateInput() {
    if (widget.validator != null) {
      setState(() {
        _isValid = widget.validator(_inputController.text.trim());
      });
      if (_isValid == null) {
        widget.positiveAction(_inputController.text.trim());
        Navigator.pop(context);
      }
    } else if (_isValid == null && widget.positiveAction != null) {
      widget.positiveAction(_inputController.text.trim());
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
//    if (widget.value != null && widget.value.trim().isNotEmpty) {
//      delay(Duration(milliseconds: 300), () {
//        _inputController.text = widget.value.trim();
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: MediaQuery.of(context).padding,
      child: AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        contentTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
        titleTextStyle: Theme.of(context).dialogTheme.titleTextStyle,
        contentPadding: EdgeInsets.all(16.0),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).dialogTheme.titleTextStyle,
              ),
              Divider(),
              TextField(
                obscureText: widget.obscure,
                autofocus: true,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                keyboardType: widget.keyboardType,
                controller: _inputController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.done,
                onEditingComplete: _validateInput,
                decoration: InputDecoration(
                  labelText: widget.label,
                  hintText: widget.value,
                  errorText: _isValid,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('${widget.neutralText ?? "Close"}'),
            onPressed: () {
              Navigator.pop(context);
              if (widget.neutralAction != null) {
                widget.neutralAction();
              }
            },
          ),
          if (widget.negativeAction != null)
            FlatButton(
              child: Text(widget.negativeText),
              onPressed: () {
                Navigator.pop(context);
                widget.negativeAction();
              },
            ),
          if (widget.positiveAction != null)
            FlatButton(
              child: Text(widget.positiveText),
              onPressed: _validateInput,
            ),
        ],
      ),
    );
  }
}

/// Single Input Dialog function
singleInputDialog(
  BuildContext context, {
  String title = "Input",
  String label = "Input Field",
  String value = "",
  String positiveText = "Submit",
  Function(String) positiveAction,
  String negativeText = "Clear",
  Function negativeAction,
  String neutralText = "Close",
  Function neutralAction,
  TextInputType keyboardType = TextInputType.text,
  bool autoClose = true,
  bool obscure = false,
  int minLines,
  int maxLines,
  String Function(String) validator,
}) {
  return showDialog(
    context: context,
    barrierDismissible: autoClose,
    builder: (_) => __SingleInputDialog(
      title: title,
      label: label,
      value: value,
      positiveText: positiveText,
      positiveAction: positiveAction,
      negativeText: negativeText,
      negativeAction: negativeAction,
      neutralText: neutralText,
      neutralAction: neutralAction,
      keyboardType: keyboardType,
      obscure: obscure,
      minLines: minLines,
      maxLines: maxLines,
      validator: validator,
    ),
  );
}
