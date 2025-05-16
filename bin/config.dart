import 'dart:developer';

import 'package:config_runner/bin/generator.dart';


void main(List<String> args) async {
  if (args.isEmpty) {
    log('Usage: dart run :generate <type>');
    return;
  }

  final type = args[0];

  switch (type) {
    case 'config':
      await generateAPI();
      break;
    default:
      log('Unknown type: $type');
  }
}
