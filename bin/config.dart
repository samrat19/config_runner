import 'dart:developer';

import 'package:config_runner/config_runner.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    ///this generateAPI function gets called to configure all your core files and API configurations based on the environment
    ///
    ///
    await generateAPI();
  } else {
    if (args.length < 2) {
      log('dart run config_runner:config module <your-module-name>');
    } else {
      final type = args[0];

      final name = args[1];

      switch (type) {
        case 'module':

          ///this function gets called when it gets a moduleName and generate all the boiler plate code and folder structure for the specific module
          await generateModule(moduleName: name);
          break;
        default:
          log('Unknown type: $type');
      }
    }
  }
}
