import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:package_info/package_info.dart';

/// future delay
delay(Duration duration, Function fun) {
  return Future.delayed(duration, () {
    fun();
  });
}

/// package info function
Future<String> getPackageInfo() async {
  String _info = "";
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String platformVersion = await GetVersion.platformVersion;

  _info = "App Name: ${packageInfo.appName}\n";
  _info += "Package Name: ${packageInfo.packageName}\n";
  _info += "Version: ${packageInfo.version}\n";
  _info += "Build Number: ${packageInfo.buildNumber}\n";
  _info += "Running On: $platformVersion";

  return _info;
}

/// device info function
Future<String> getDeviceInfo() async {
  String _info = "";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String platformVersion = await GetVersion.platformVersion;

    _info = "App Name: ${packageInfo.appName}\n";
    _info += "Package Name: ${packageInfo.packageName}\n";
    _info += "Version: ${packageInfo.version}\n";
    _info += "Build Number: ${packageInfo.buildNumber}\n";
    _info += "Running On: $platformVersion\n\n";

    _info += "ANDROID DEVICE INFO\n";
    _info += "AndroidId: ${androidInfo.androidId}\n";
    _info += "Board: ${androidInfo.board}\n";
    _info += "Bootloader: ${androidInfo.bootloader}\n";
    _info += "Brand: ${androidInfo.brand}\n";
    _info += "Device: ${androidInfo.device}\n";
    _info += "Display: ${androidInfo.display}\n";
    _info += "Fingerprint: ${androidInfo.fingerprint}\n";
    _info += "Hardware: ${androidInfo.hardware}\n";
    _info += "Host: ${androidInfo.host}\n";
    _info += "ID: ${androidInfo.id}\n";
    _info += "IsPhysicalDevice: ${androidInfo.isPhysicalDevice}\n";
    _info += "Manufacturer: ${androidInfo.manufacturer}\n";
    _info += "Model: ${androidInfo.model}\n";
    _info += "Product: ${androidInfo.product}\n";
    _info += "Supported32BitAbis: ${androidInfo.supported32BitAbis}\n";
    _info += "Supported64BitAbis: ${androidInfo.supported64BitAbis}\n";
    _info += "SupportedAbis: ${androidInfo.supportedAbis}\n";
    _info += "Tags: ${androidInfo.tags}\n";
    _info += "Type: ${androidInfo.type}\n\n";
    _info += "VERSION\n";
    _info += "Android OS: ${androidInfo.version.baseOS}\n";
    _info += "Code Name: ${androidInfo.version.codename}\n";
    _info += "Incremental: ${androidInfo.version.incremental}\n";
    _info += "Preview Sdk Int: ${androidInfo.version.previewSdkInt}\n";
    _info += "SDK Int: ${androidInfo.version.sdkInt}\n";
    _info += "Release: ${androidInfo.version.release}\n";
    _info += "Security Path: ${androidInfo.version.securityPatch}\n";
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String platformVersion = await GetVersion.platformVersion;

    _info = "App Name: ${packageInfo.appName}\n";
    _info += "Package Name: ${packageInfo.packageName}\n";
    _info += "Version: ${packageInfo.version}\n";
    _info += "Build Number: ${packageInfo.buildNumber}\n";
    _info += "Running On: IOS $platformVersion\n\n";

    _info += "APPLE DEVICE INFO\n";
    _info += "IdentifierForVendor: ${iosInfo.identifierForVendor}\n";
    _info += "IsPhysicalDevice: ${iosInfo.isPhysicalDevice}\n";
    _info += "LocalizedModel: ${iosInfo.localizedModel}\n";
    _info += "Model: ${iosInfo.model}\n";
    _info += "Name: ${iosInfo.name}\n";
    _info += "SystemName: ${iosInfo.systemName}\n";
    _info += "SystemVersion: ${iosInfo.systemVersion}\n";
    _info += "Utsname.Machine: ${iosInfo.utsname.machine}\n";
    _info += "Utsname.Nodename: ${iosInfo.utsname.nodename}\n";
    _info += "Utsname.Release: ${iosInfo.utsname.release}\n";
    _info += "Utsname.Sysname: ${iosInfo.utsname.sysname}\n";
    _info += "Utsname.Version: ${iosInfo.utsname.version}\n";
  }
  return _info;
}

/// highlight title textfun
Widget highlightTitleTextWidget(
  BuildContext context,
  String string,
  String word, {
  TextStyle stringStyle,
  bool boldTitle = true,
  TextStyle wordStyle,
}) {
  if (stringStyle == null) {
    if (boldTitle) {
      stringStyle = Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(fontWeight: FontWeight.bold);
    } else {
      stringStyle = Theme.of(context).textTheme.subtitle1;
    }
  }

  if (wordStyle == null) {
    wordStyle = stringStyle.copyWith(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    );
  }

  if (word == null || word.isEmpty) {
    return Text(
      string,
      style: stringStyle,
    );
  } else {
    final spans = _getSpans(string, word, wordStyle);

    return RichText(
      text: TextSpan(
        style: stringStyle,
        children: spans,
      ),
    );
  }
}

/// highlight sub title text
Widget highlightSubTitleTextWidget(
  BuildContext context,
  String string,
  String word, {
  TextStyle stringStyle,
  TextStyle wordStyle,
}) {
  if (stringStyle == null) {
    stringStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Theme.of(context).textTheme.caption.color);
  }

  if (wordStyle == null) {
    wordStyle = stringStyle.copyWith(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    );
  }

  if (word == null || word.isEmpty) {
    return Text(
      string,
      style: stringStyle,
    );
  } else {
    final spans = _getSpans(string, word, wordStyle);

    return RichText(
      text: TextSpan(
        style: stringStyle,
        children: spans,
      ),
    );
  }
}

List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
  List<TextSpan> spans = [];
  int spanBoundary = 0;

  List<String> values;
  var length = 0;
  if (matchWord.contains(' ')) {
    values = matchWord.split(' ');
    length = values.length;
  }

  if (length > 1) {
    var currentIndex = 0;

    do {
      // look for the next match
      var startIndex =
          text.toLowerCase().indexOf(values[0].toLowerCase(), spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        startIndex =
            text.toLowerCase().indexOf(values[1].toLowerCase(), spanBoundary);
        currentIndex = 1;

        if (startIndex == -1) {
          if (length > 2) {
            startIndex = text
                .toLowerCase()
                .indexOf(values[2].toLowerCase(), spanBoundary);
            currentIndex = 2;

            if (startIndex == -1) {
              spans.add(TextSpan(text: text.substring(spanBoundary)));
              return spans;
            }
          } else {
            spans.add(TextSpan(text: text.substring(spanBoundary)));
            return spans;
          }
        }
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + values[currentIndex].length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);
  } else {
    do {
      // look for the next match
      final startIndex =
          text.toLowerCase().indexOf(matchWord.toLowerCase(), spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);
  }

  return spans;
}
