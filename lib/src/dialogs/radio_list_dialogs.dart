import 'package:commons/src/functions/navigation_functions.dart';
import 'package:commons/src/models/models.dart';
import 'package:flutter/material.dart';

class __RadioListDialog<T extends Data> extends StatefulWidget {
  final String title;
  final Set<T> dataSet;
  final Data selectedItem;
  final Function(T) onSubmit;

  __RadioListDialog(
    this.title,
    this.dataSet,
    this.onSubmit, {
    this.selectedItem,
  });

  @override
  ___RadioListDialogState createState() => ___RadioListDialogState<T>();
}

class ___RadioListDialogState<T extends Data> extends State<__RadioListDialog> {
  T _selectedItem;
  int _radioGroupId = 0;

  _optionItem(BuildContext context, T data) {
    return RadioListTile(
      groupValue: _radioGroupId,
      onChanged: (value) {
        print(value);
        setState(() {
          _radioGroupId = value;
          _selectedItem = data;
        });
      },
      value: data.id,
      title: Text("${data.title}"),
    );
  }

  _options() {
    var listItems = List<Widget>();
    widget.dataSet.forEach((item) {
      listItems.add(_optionItem(context, item));
    });
    return listItems;
  }

  _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Divider(
          color: Colors.black,
          height: 5,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ..._options(),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.black,
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                if (widget.onSubmit != null) widget.onSubmit(_selectedItem);
                pop(context); // To close the dialog
              },
              child: Text("Done"),
            ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.selectedItem != null) {
        _selectedItem = widget.selectedItem;
        _radioGroupId = widget.selectedItem.id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _dialogContent(context),
      elevation: 3,
    );
  }
}

radioListDialog<T extends Data>(
  BuildContext context,
  String title,
  Set<T> dataSet,
  Function(T) onSubmit, {
  Data selectedItem,
  autoClose = true,
}) {
  return showDialog(
    barrierDismissible: autoClose,
    context: context,
    builder: (c) => WillPopScope(
      onWillPop: () async => autoClose,
      child: __RadioListDialog(
        title,
        dataSet,
        onSubmit,
        selectedItem: selectedItem,
      ),
    ),
  );
}
