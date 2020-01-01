import 'package:flutter/material.dart';

class WidgetViewScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> appBarActions;
  final bool centerTitle;

  WidgetViewScreen(this.title, this.child,
      {this.centerTitle = false, this.appBarActions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        centerTitle: centerTitle,
        actions: appBarActions,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
