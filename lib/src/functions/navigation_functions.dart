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
pop<T extends Object>(BuildContext context, [T result]) {
  var canPop = _canPop(context);
  assert(canPop, "Cannot pop initial route.");
  Navigator.of(context).pop<T>(result);
}

mustPop<T extends Object>(BuildContext context, [T result]) {
  Navigator.of(context).pop<T>(result);
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

  popThis<T extends Object>([T result]) {
    pop(context, result);
  }

  mustPopThis<T extends Object>([T result]) {
    mustPop(context, result);
  }

  Future<T> popAndPushThis<T extends Object>(Widget route) {
    pop(context);
    return push(context, route);
  }
}
