# Commons

Commons Flutter package can used for Flutter **Android** and **IOS** applications.
 
 **Includes**
 - [Alert dialog](#Dialogs)
 - [Toast messages](#Toasts)
 - Loading screen
 - Extensions functions
 - Stack trace screen
 - Shared Preferences functions
 - Value validators
 - Date and Time functions
 - Connection Functions
 - http rest client api functions

# How to use

### 1. Depend on it

Add this to your package's pubspec.yaml file:
```yaml
dependencies:  
  commons: ^0.4.0
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
import  'package:commons/commons.dart';
```

## Dialogs

- Success Dialog
- Error Dialog
- Warning Dialog
- Info Dialog
- Confirmation Dialog
- Wait Dialog

<p align="center">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/success.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/error.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/warning.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/info.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/confirm.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/wait.png" width="240">
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/stacktrace.png" width="240">
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
	<img src="https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/loading.png" width="240">
</p>

```dart
push(
    loadingScreen(  
        context,  
        duration: Duration(  
            seconds: 5,  
        ),  
        loadingType: LoadingType.JUMPING,
    )  
)
```

# Documentation

For help getting started with Commons, view our online [Documentation](https://pub.dev/documentation/commons/latest/)
Get complete code from [Github](https://github.com/Arbaz-Softagics/commons)
[Ch Arbaz Mateen](http://arbazmateen.com/)
