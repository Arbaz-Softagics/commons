import 'package:flutter/material.dart';

/// Navigator push function
Future<T> push<T extends Object>(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (c) => route,
    ),
  );
}

/// Navigator push replacement function
Future<T> replaceWith<T extends Object>(BuildContext context, Widget route) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (c) => route,
    ),
  );
}

/// Navigator pop function
bool pop<T extends Object>(BuildContext context, [T result]) {
  var canPop = _canPop(context);
  assert(canPop, "Cannot pop initial route.");
  return Navigator.of(context).pop<T>(result);
}

bool mustPop<T extends Object>(BuildContext context, [T result]) {
  return Navigator.of(context).pop<T>(result);
}

_canPop(BuildContext context) {
  return Navigator.canPop(context);
}

/// Stateful, Stateless widgets extension function of push, pop, replaceWith
extension NavigatorExtension on State {
  Future<T> pushThis<T extends Object>(Widget route) {
    return push(context, route);
  }

  Future<T> replaceWithThis<T extends Object>(Widget route) {
    return replaceWith(context, route);
  }

  bool popThis<T extends Object>([T result]) {
    return pop(context, result);
  }

  bool mustPopThis<T extends Object>([T result]) {
    return mustPop(context, result);
  }

  Future<T> popAndPushThis<T extends Object>(Widget route) {
    var ok = pop(context);
    assert(ok, "Cannot pop initial route.");
    return push(context, route);
  }
}
