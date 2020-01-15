//part of commons;

import 'dart:io';

import 'package:commons/commons.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class StackTraceScreen extends StatefulWidget {
  final String stackTrace;
  final String errorMessage;
  final String className;
  final String mailTo;
  final String subject;
  final bool deviceInfo;
  final bool shareButton;

  StackTraceScreen(
      {this.stackTrace,
      this.errorMessage,
      this.className,
      this.mailTo,
      this.subject,
      this.deviceInfo,
      this.shareButton});

  @override
  _StackTraceScreenState createState() => _StackTraceScreenState();
}

class _StackTraceScreenState extends State<StackTraceScreen> {
  String _info = "";
  String _body = "";

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.deviceInfo != null && widget.deviceInfo ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stack Trace"),
          actions: <Widget>[
            widget.mailTo != null && widget.mailTo.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _mailTo,
                    tooltip: "Send error report",
                  )
                : SizedBox(),
            widget.shareButton != null && widget.shareButton
                ? IconButton(
                    icon: Icon(Icons.share),
                    onPressed: _share,
                    tooltip: "Share error report",
                  )
                : SizedBox(),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.warning),
                text: "Stack Trace",
              ),
              Tab(
                icon: Icon(Icons.error),
                text: "Error Message",
              ),
              if (widget.deviceInfo != null && widget.deviceInfo)
                Tab(
                  icon: Icon(Icons.perm_device_information),
                  text: "Device Info",
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.stackTrace}"),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.errorMessage}"),
              ),
            ),
            if (widget.deviceInfo != null && widget.deviceInfo)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$_info"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _mailTo() async {
    String url =
        "mailto:${widget.mailTo}?subject=${widget.subject ?? "Stack Trace"}&body=$_body";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      warningDialog(
        context,
        "Cannot send email to address '${widget.mailTo}'",
        closeOnBackPress: true,
        showNeutralButton: true,
      );
    }
  }

  _share() {
    Share.share(_body, subject: "Stack Trace");
  }

  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String platformVersion = await GetVersion.platformVersion;

      setState(() {
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
        _info += "Android OS: ${androidInfo.version.baseOS} $platformVersion\n";
        _info += "Code Name: ${androidInfo.version.codename}\n";
        _info += "Incremental: ${androidInfo.version.incremental}\n";
        _info += "Preview Sdk Int: ${androidInfo.version.previewSdkInt}\n";
        _info += "SDK Int: ${androidInfo.version.sdkInt}\n";
        _info += "Release: ${androidInfo.version.release}\n";
        _info += "Security Path: ${androidInfo.version.securityPatch}\n";
      });
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      String platformVersion = await GetVersion.platformVersion;

      setState(() {
        _info += "APPLE DEVICE INFO\n";
        _info += "IdentifierForVendor: ${iosInfo.identifierForVendor}\n";
        _info += "IsPhysicalDevice: ${iosInfo.isPhysicalDevice}\n";
        _info += "LocalizedModel: ${iosInfo.localizedModel}\n";
        _info += "Model: ${iosInfo.model}\n";
        _info += "Name: ${iosInfo.name}\n";
        _info += "SystemName: ${iosInfo.systemName}\n";
        _info += "SystemVersion: ${iosInfo.systemVersion} $platformVersion\n";
        _info += "Utsname.Machine: ${iosInfo.utsname.machine}\n";
        _info += "Utsname.Nodename: ${iosInfo.utsname.nodename}\n";
        _info += "Utsname.Release: ${iosInfo.utsname.release}\n";
        _info += "Utsname.Sysname: ${iosInfo.utsname.sysname}\n";
        _info += "Utsname.Version: ${iosInfo.utsname.version}\n";
      });
    }
    _body =
        "Stack Trace: ${widget.stackTrace}\nError Message: ${widget.errorMessage}\nDevice Info: $_info";
  }
}
