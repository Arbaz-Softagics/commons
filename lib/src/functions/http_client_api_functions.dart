import 'dart:convert';

import 'package:commons/src/dialogs/alert_dialogs.dart';
import 'package:commons/src/functions/navigation_functions.dart';
import 'package:commons/src/screens/stack_trace_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

enum RequestMethod { POST, GET, POST_JSON }

//class RequestMethod {
//  static const POST = "post";
//  static const GET = "get";
//  static const POST_JSON = "postJson";
//}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int REDIRECT_ERROR = 3;
  static const int CLIENT_ERROR = 4;
  static const int SERVER_ERROR = 5;

  static int codeType(int code) {
    if (code >= 500 && code < 600)
      return SERVER_ERROR;
    else if (code >= 400 && code < 500)
      return CLIENT_ERROR;
    else if (code >= 300 && code < 400)
      return REDIRECT_ERROR;
    else
      return SUCCESS;
  }

  static showErrorCode(BuildContext context, int responseCode) {
    var codeType = ResponseCode.codeType(responseCode);
    if (codeType == ResponseCode.SERVER_ERROR) {
      errorDialog(context, "Internal SERVER error!",
          title: "Error Code: $responseCode");
    } else if (codeType == ResponseCode.CLIENT_ERROR) {
      errorDialog(context, "Found error on CLIENT side!",
          title: "Error Code: $responseCode");
    } else if (codeType == ResponseCode.REDIRECT_ERROR) {
      errorDialog(context, "Found REDIRECT error!",
          title: "Error Code: $responseCode");
    } else {
      errorDialog(context, "Failed to Connect!, Error Unknown!",
          title: "Error Code: $responseCode");
    }
  }
}

acceptJsonTypeXForm() => {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
acceptJsonTypeXFormWithAuth(String authKey) => {
      "Auth": "$authKey",
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
acceptJsonTypeJson() =>
    {"Accept": "application/json", "Content-Type": "application/json"};
acceptJsonTypeJsonWithAuth(String authKey) => {
      "Auth": "$authKey",
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
acceptJsonWithAuth(String authKey) =>
    {"Auth": "$authKey", "Accept": "application/json"};

encodingUTF8() => Encoding.getByName("utf-8");

Future<Response> postRequest(String url, Map header, {Map body, log: true}) {
  if (log) {
    print(">>>>>>>>>>>>>>>>>>>>>> POST $url");
    print(">>>>>>>>>>>>>>>>>>>>>> POST HEADERS $header");
    if (body != null) print(">>>>>>>>>>>>>>>>>>>>>> POST PRAMS $body");
  }
  return http.post(url, headers: header, body: body, encoding: encodingUTF8());
}

Future<Response> postJsonRequest(String url, Map header, Map body,
    {log: true}) {
  if (log) {
    print(">>>>>>>>>>>>>>>>>>>>>> POST $url");
    print(">>>>>>>>>>>>>>>>>>>>>> POST HEADERS $header");
    print(">>>>>>>>>>>>>>>>>>>>>> JSON PRAM ${json.encode(body)}");
  }
  return http.post(url,
      headers: header, body: json.encode(body), encoding: encodingUTF8());
}

Future<Response> getRequest(String url, Map header,
    {Map<String, String> body, log: true}) {
  if (log) {
    print(">>>>>>>>>>>>>>>>>>>>>> GET $url");
    print(">>>>>>>>>>>>>>>>>>>>>> GET HEADERS $header");
    if (body != null) print(">>>>>>>>>>>>>>>>>>>>>> GET PRAMS $body");
  }
  if (body != null) {
    String domainUrl = url.replaceFirst('http://', '');
    String domain = domainUrl.substring(0, domainUrl.indexOf('/'));
    String path = domainUrl.substring(domainUrl.indexOf('/'));
    var uri = Uri.https(domain, path, body);
    return http.get(uri, headers: header);
  } else {
    return http.get(url, headers: header);
  }
}

Future<Response> request(
  BuildContext context,
  State<StatefulWidget> state,
  RequestMethod requestMethod,
  String url,
  Map headers, {
  Map prams,
  bool dialog = false,
  bool log = true,
  bool showErrorDialogs = true,
}) async {
  bool _dialog = dialog;
  Response response;
  try {
    if (requestMethod == RequestMethod.POST) {
      response = await postRequest(url, headers, body: prams, log: log);
    } else if (requestMethod == RequestMethod.GET) {
      response = await getRequest(url, headers, body: prams, log: log);
    } else if (requestMethod == RequestMethod.POST_JSON) {
      response = await postJsonRequest(url, headers, prams, log: log);
    }

    if (_dialog) {
      _dialog = false;
      pop(context);
    }

    if (response != null) {
      var code = response.statusCode;

      print("Response Status Code => $code");

      if (code == ResponseCode.SUCCESS) {
        print("Successfully getting response.");
        return response;
      } else {
        print("Response error code: $code");
      }
    } else {
      print("Response is null");
    }
  } on FormatException catch (e, s) {
    if (_dialog) {
      _dialog = false;
      pop(context);
    }

    print("CLASS: ${state.runtimeType}");
    print(
        "FORMATEXCEPTION: E: $e\n\nM: ${e.message.toString()}\n\nS: ${e.source.toString()}");
    print("STACK TRACE: $s");

    if (showErrorDialogs) {
      errorDialog(
        context,
        "$e",
        showNeutralButton: true,
        positiveText: "Details",
        positiveAction: () {
          push(
            context,
            StackTraceScreen(
              stackTrace: "$s",
              errorMessage:
                  "E: $e\n\nM: ${e.message.toString()}\n\nS: ${e.source.toString()}",
            ),
          );
        },
        closeOnBackPress: true,
      );
    }
  } on Exception catch (e, s) {
    if (_dialog) {
      _dialog = false;
      pop(context);
    }

    print("CLASS: ${state.runtimeType}");
    print("EXCEPTION: $e");
    print("STACK TRACE: $s");

    if (showErrorDialogs) {
      errorDialog(
        context,
        "$e",
        showNeutralButton: true,
        positiveText: "Details",
        positiveAction: () {
          push(
            context,
            StackTraceScreen(
              stackTrace: "$s",
              errorMessage: "$e",
            ),
          );
        },
        closeOnBackPress: true,
      );
    }
  } on Error catch (e, s) {
    if (_dialog) {
      _dialog = false;
      pop(context);
    }

    print("CLASS: ${state.runtimeType}");
    print("ERROR: $e");
    print("STACK TRACE: $s");

    if (showErrorDialogs) {
      errorDialog(
        context,
        "$e",
        showNeutralButton: true,
        positiveText: "Details",
        positiveAction: () {
          push(
            context,
            StackTraceScreen(
              stackTrace: "$s",
              errorMessage: "$e",
            ),
          );
        },
        closeOnBackPress: true,
      );
    }
  } catch (e, s) {
    if (_dialog) {
      _dialog = false;
      pop(context);
    }

    print("CLASS: ${state.runtimeType}");
    print("CATCH: $e");
    print("STACK TRACE: $s");

    if (showErrorDialogs) {
      errorDialog(
        context,
        "$e",
        showNeutralButton: true,
        positiveText: "Details",
        positiveAction: () {
          StackTraceScreen(
            stackTrace: "$s",
            errorMessage: "$e",
          );
        },
        closeOnBackPress: true,
      );
    }
  }
  return response;
}
