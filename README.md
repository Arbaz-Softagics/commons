# Commons

Commons Flutter package can used for Flutter **Android** and **IOS** applications.
 
[https://pub.dev/packages/commons](https://pub.dev/packages/commons)
[example/lib/main.dart](https://github.com/Arbaz-Softagics/commons/blob/master/example/lib/main.dart)
 
 **Includes**
 - Alert dialog
 - Toast messages
 - Single input dialog
 - Single select dialog
 - Multi select dialog
 - Radio list dialog
 - Options dialog
 - Loading screen
 - Extensions functions
 - Stack trace screen
 - Shared Preferences functions
 - Value validators
 - Date and Time functions
 - Connection Functions
 - http rest client api functions
 - list view screen with search

# How to use

**Required Dart version >= 2.6+**

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:
```yaml
dependencies:  
  commons: ^0.7.8+3
```

### 2. Install it

You can install packages from the command line:

with Flutter:
```sh
$ flutter pub get
```
Alternatively, your editor might support  `flutter pub get`. Check the docs for your editor to learn more.

### 3. Import it

Now in your Dart code, you can use:
```dart
import 'package:commons/commons.dart';
```

## Dialogs

- Success Dialog
- Error Dialog
- Warning Dialog
- Info Dialog
- Confirmation Dialog
- Wait Dialog
- Single Input Dialog
- option dialog
- Single select dialog
- Multi select dialog
- Radio list dialog

<p align="center">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/success.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/error.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/warning.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/info.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/confirm.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/wd.gif" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/stacktrace.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/od.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/ssd.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/msd.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/rld.png" width="240">
</p>

## How to use

### Success Dialog

```dart
successDialog(  
    context,  
    "Success message",  
    negativeText: "Try Again",  
    negativeAction: () {},  
    positiveText: "Details",  
    positiveAction: () {},  
);
```

### Confirm Dialog

```dart
confirmationDialog(
    context, 
    "Confirm demo dialog", 
    positiveText: "Delete", 
    positiveAction: () {}
);
```

### Single Input Dialog
```dart
singleInputDialog(
    context,
    title: "Input Dialog",
    label: "Name",
    validator: (value) {
      print("Validator: $value");
      return value.isEmpty ? "Required!" : null;
    },
    positiveAction: (value) {
      print("Submit: $value");
    },
    negativeAction: () {
      print("negative action");
    },
    neutralAction: () {
      print("neutral action");
    },
);
```

### Options dialog
```dart
var options = List<Option>()
              ..add(Option.edit())
              ..add(Option.view())
              ..add(Option.details())
              ..add(Option.delete())
              ..add(Option.item(Text("Custom"), icon: Icon(Icons.details)));
optionsDialog(context, "Options", options);
```

### Single select dialog
```dart
var list = Set<SimpleItem>()
                  ..add(SimpleItem(1, "Version 1.0"))
                  ..add(SimpleItem(1, "Version 2.0"))
                  ..add(SimpleItem(1, "Version 3.0"))
                  ..add(SimpleItem(1, "Version 4.0"))
                  ..add(SimpleItem(2, "Version 5.0"))
                  ..add(SimpleItem(3, "Version 6.0"))
                  ..add(SimpleItem(4, "Version 7.0"));
singleSelectDialog(context, "Single Select", list, (item) {
  print(item);
});
```

### Multi select dialog
```dart
Set<SimpleItem> list = Set()
                  ..add(SimpleItem(1, "Version 1.0"))
                  ..add(SimpleItem(1, "Version 2.0"))
                  ..add(SimpleItem(1, "Version 3.0"))
                  ..add(SimpleItem(1, "Version 4.0"))
                  ..add(SimpleItem(2, "Version 5.0"))
                  ..add(SimpleItem(3, "Version 6.0"))
                  ..add(SimpleItem(4, "Version 7.0"))
                  ..add(SimpleItem(4, "Version 8.0"))
                  ..add(SimpleItem(4, "Version 9.0"))
                  ..add(SimpleItem(4, "Version 10.0"));
multiSelectDialog(
  context,
  "Multi Selects",
  list,
  _selectedItems,
  (values) {
    setState(() {
      _selectedItems = values;
    });
    print(values);
  },
);
```

### Radio list dialog
```dart
Set<SimpleItem> set = Set<SimpleItem>()
                  ..add(SimpleItem(1, "One"))
                  ..add(SimpleItem(2, "Two"))
                  ..add(SimpleItem(3, "Three"));
radioListDialog(
  context,
  "Select one",
  set,
  (item) {
    print(item);
  },
);
```

## Toasts

- Success Toast
- Error Toast
- Warning Toast
- Info Toast

<p align="center">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/s.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/e.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/w.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/i.png" width="240">
</p>

## How to use

Commons used [OKToast](https://pub.dev/packages/oktoast) dart package please check [OKToast](https://pub.dev/packages/oktoast) requirements first.
```dart
successToast("Success toast");
```

# Loading screen

<p align="center">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/ls.gif" width="240">
</p>

```dart
push(
    context,
    loadingScreen(  
        context,  
        duration: Duration(  
            seconds: 5,  
        ),  
        loadingType: LoadingType.JUMPING,
    ),
);
```

# Complete Example

```dart
import 'package:commons/commons.dart';
import 'package:example/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: OKToast(
        child: MaterialAppWithTheme(),
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Commons Example',
      theme: theme.getTheme(),
      home: MyHomePage(title: 'Commons Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _online = false;
  bool _connected = false;
  var listener;
  String singleInput = "";
  Set<SimpleItem> _selectedItems = Set();

  _checkInternet() async {
    listener = await ConnectionChecker()
        .getInstance()
        .setDuration(Duration(
          seconds: 1,
        ))
        .listener(
      connected: () {
        setState(() {
          _online = true;
        });
      },
      disconnected: () {
        setState(() {
          _online = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Light Theme"),
              onTap: () => _themeChanger.setTheme(ThemeData.light()),
            ),
            ListTile(
              title: Text("Dark Theme"),
              onTap: () => _themeChanger.setTheme(ThemeData.dark()),
            ),
            ListTile(
              onTap: () {
                checkInternet().then((connected) {
                  setState(() {
                    _connected = connected;
                  });
                });
              },
              title: Text("Connected: $_connected"),
              subtitle: Text("Click to check internet connection"),
            ),
            ListTile(
              title: Text("Connected: $_online"),
              subtitle: Text("Connection listener"),
            ),
            ListTile(
              onTap: () {
                var now = DateTime.now();
                print("${now.format()}");
                print("${now.toDateString()}");
                print("${now.toTimeString()}");
                print("${now.toDateTimeString()}");
                print("${now.toDateTimeWithMillisecondsString()}");
                print(
                    "sqlDateFormat: ${DateTimeAPI.sqlDateFormat(DateTime.now())}");
                print(
                    "sqlDateTimeFormat: ${DateTimeAPI.sqlDateTimeFormat(DateTime.now())}");
                print(
                    "sqlStartDateTimeFormat: ${DateTimeAPI.sqlStartDateTimeFormat(DateTime.now())}");
                print(
                    "sqlEndDateTimeFormat: ${DateTimeAPI.sqlEndDateTimeFormat(DateTime.now())}");
                print(
                    "formatDateOnly: ${DateTimeAPI.formatDateOnly(DateTime.now())}");
                print(
                    "formatTimeOnly: ${DateTimeAPI.formatTimeOnly(DateTime.now())}");
                print(
                    "formatDateTime: ${DateTimeAPI.formatDateTime(DateTime.now())}");
                print("lastDateOfMonth: ${DateTimeAPI.lastDateOfMonth()}");
                print("firstDateOfMonth: ${DateTimeAPI.firstDateOfMonth()}");
                print(
                    "add: ${DateTimeAPI.add(DateTime.now(), Duration(days: 5))}");
                print(
                    "subtract: ${DateTimeAPI.subtract(DateTime.now(), Duration(days: 5))}");
                print("addDay: ${DateTimeAPI.addDay(DateTime.now(), 5)}");
                print(
                    "subtractDay: ${DateTimeAPI.subtractDay(DateTime.now(), 5)}");
                print("addMonth: ${DateTimeAPI.addMonth(DateTime.now(), 1)}");
                print(
                    "subtractMonth: ${DateTimeAPI.subtractMonth(DateTime.now(), 1)}");
                print(
                    "difference: ${DateTimeAPI.difference(DateTime.now(), DateTime.now() + Duration(days: 5)).inDays}");

                print("Numbers");
                int i = 123456;
                double a = 123456.566;
                print(i.format());
                print(a.format());
              },
              title: Text("DateTime Test (see the log)"),
            ),
            ListTile(
              onTap: () {
                successDialog(context, "Success demo dialog");
              },
              title: Text("Success Dialog"),
            ),
            ListTile(
              onTap: () {
                errorDialog(
                  context,
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in " +
                      "Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de " +
                      "Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32." +
                      "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from "
                          "the 1914 translation by H. Rackham.",
                  negativeText: "Try Again",
                  negativeAction: () {},
                  positiveText: "Details",
                  positiveAction: () {},
                );
              },
              title: Text("Error Dialog"),
            ),
            ListTile(
              onTap: () {
                warningDialog(context, "Warning demo dialog");
              },
              title: Text("Warning Dialog"),
            ),
            ListTile(
              onTap: () {
                infoDialog(context, "Info demo dialog");
              },
              title: Text("Info Dialog"),
            ),
            ListTile(
              onTap: () {
                confirmationDialog(context, "Confirm demo dialog",
                    positiveText: "Delete", positiveAction: () {});
              },
              title: Text("Confirm Dialog"),
            ),
            ListTile(
              onTap: () {
                dialog(
                  context,
                  Colors.pink,
                  "Title",
                  "Some message",
                  false,
                  true,
                  customIcon: Icon(
                    Icons.ac_unit,
                    size: 64,
                    color: Colors.white,
                  ),
                );
              },
              title: Text("Custom Dialog"),
            ),
            ListTile(
              onTap: () {
                singleInputDialog(
                  context,
                  title: "Input Dialog",
                  label: "Name",
                  value: singleInput,
                  errorText: "Required!",
                  validator: (value) {
                    print("Validator: $value");
                    return value.isNotEmpty;
                  },
                  positiveAction: (value) {
                    print("Submit: $value");
                    setState(() {
                      singleInput = value;
                    });
                  },
                  negativeAction: () {
                    print("negative action");
                  },
                  neutralAction: () {
                    print("neutral action");
                  },
                );
              },
              title: Text("Single input dialog"),
              subtitle: Text("$singleInput"),
            ),
            ListTile(
              onTap: () {
                waitDialog(context, duration: Duration(seconds: 3));
              },
              title: Text("Wait Dialog"),
            ),
            ListTile(
              onTap: () {
                List<SimpleItem> list = List()
                  ..add(SimpleItem(1, "First", remarks: "sub title"))
                  ..add(SimpleItem(2, "Second", remarks: "sub title"))
                  ..add(SimpleItem(3, "Third", remarks: "sub title"))
                  ..add(SimpleItem(4, "Forth", remarks: "sub title"));
                push(
                  context,
                  ListViewScreen(
                    "List View Example",
                    list,
                    (item, index, searchValue) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        elevation: 1,
                        child: ListTile(
                          onTap: () {
                            pop(context);
                            print("$item at index $index");
                          },
                          title: highlightTitleTextWidget(
                              context, item.title, searchValue),
                        ),
                      );
                    },
                    searchCriteria: (item, text) => item.title.contains(text),
                  ),
                );
              },
              title: Text("List View Screen"),
            ),
            ListTile(
              onTap: () {
                tryCatch(context, this, () {
                  throw Exception("throw exception manully...");
                });
              },
              title: Text("Stack Trace Screen"),
            ),
            ListTile(
              onTap: () {
                var options = List<Option>()
                  ..add(Option.edit())
                  ..add(Option.view())
                  ..add(Option.details())
                  ..add(Option.delete())
                  ..add(Option.item(Text("Custom"), icon: Icon(Icons.details)));
                optionsDialog(context, "Options", options);
              },
              title: Text("Options Dialog"),
            ),
            ListTile(
              onTap: () {
                var list = Set<SimpleItem>()
                  ..add(SimpleItem(1, "Version 1.0"))
                  ..add(SimpleItem(1, "Version 2.0"))
                  ..add(SimpleItem(1, "Version 3.0"))
                  ..add(SimpleItem(1, "Version 4.0"))
                  ..add(SimpleItem(2, "Version 5.0"))
                  ..add(SimpleItem(3, "Version 6.0"))
                  ..add(SimpleItem(4, "Version 7.0"));
                singleSelectDialog(context, "Single Select", list, (item) {
                  print(item);
                });
              },
              title: Text("Single select dialog"),
            ),
            ListTile(
              onTap: () {
                Set<SimpleItem> list = Set()
                  ..add(SimpleItem(1, "Version 1.0"))
                  ..add(SimpleItem(1, "Version 2.0"))
                  ..add(SimpleItem(1, "Version 3.0"))
                  ..add(SimpleItem(1, "Version 4.0"))
                  ..add(SimpleItem(2, "Version 5.0"))
                  ..add(SimpleItem(3, "Version 6.0"))
                  ..add(SimpleItem(4, "Version 7.0"))
                  ..add(SimpleItem(4, "Version 8.0"))
                  ..add(SimpleItem(4, "Version 9.0"))
                  ..add(SimpleItem(4, "Version 10.0"));
                multiSelectDialog(
                  context,
                  "Multi Selects",
                  list,
                  _selectedItems,
                  (values) {
                    setState(() {
                      _selectedItems = values;
                    });
                    print(values);
                  },
                );
              },
              title: Text("Multi select dialog"),
            ),
            ListTile(
              onTap: () {
                Set<SimpleItem> set = Set<SimpleItem>()
                  ..add(SimpleItem(1, "One"))
                  ..add(SimpleItem(2, "Two"))
                  ..add(SimpleItem(3, "Three"));
                radioListDialog(
                  context,
                  "Select one",
                  set,
                  (item) {
                    print(item);
                  },
                );
              },
              title: Text("Radio list dialog"),
            ),
            ListTile(
              onTap: () {
                successToast("Success toast");
              },
              title: Text("Success toast"),
            ),
            ListTile(
              onTap: () {
                errorToast("Error toast");
              },
              title: Text("Error toast"),
            ),
            ListTile(
              onTap: () {
                warningToast("Warning toast");
              },
              title: Text("Warning toast"),
            ),
            ListTile(
              onTap: () {
                infoToast("Info toast");
              },
              title: Text("Info toast"),
            ),
            ListTile(
              onTap: () {
                push(
                  context,
                  loadingScreen(
                    context,
                    duration: Duration(
                      seconds: 5,
                    ),
                    loadingType: LoadingType.JUMPING,
                  ),
                );
              },
              title: Text("Loading Screen"),
            ),
            ListTile(
              onTap: () {
                getPackageInfo().then((info) {
                  infoDialog(context, info, textAlign: TextAlign.start);
                });
              },
              title: Text("Package Info Dialog"),
            ),
            ListTile(
              onTap: () {
                getDeviceInfo().then((info) {
                  infoDialog(context, info, textAlign: TextAlign.start);
                });
              },
              title: Text("Device Info Dialog"),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```
# Documentation

For help getting started with Commons, view our online [Documentation](https://pub.dev/documentation/commons/latest/).
Get complete code from [Github](https://github.com/Arbaz-Softagics/commons).
Author: [Ch Arbaz Mateen](http://arbazmateen.com/)
