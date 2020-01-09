import 'package:commons/src/dialogs/alert_dialogs.dart';
import 'package:commons/src/functions/navigation_functions.dart';
import 'package:commons/src/screens/stack_trace_screen.dart';
import 'package:flutter/material.dart';

/// try catch with error dialog function
tryCatch(BuildContext context, State state, Function action) {
  try {
    action();
  } on FormatException catch (e, s) {
    print("CLASS: ${state.runtimeType}");
    print(
        "FORMATEXCEPTION: E: $e\n\nM: ${e.message.toString()}\n\nS: ${e.source.toString()}");
    print("STACK TRACE: $s");

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
  } on Exception catch (e, s) {
    print("CLASS: ${state.runtimeType}");
    print("EXCEPTION: $e");
    print("STACK TRACE: $s");

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
  } on Error catch (e, s) {
    print("CLASS: ${state.runtimeType}");
    print("ERROR: $e");
    print("STACK TRACE: $s");

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
  } catch (e, s) {
    print("CLASS: ${state.runtimeType}");
    print("CATCH: $e");
    print("STACK TRACE: $s");

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
