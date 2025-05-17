import 'dart:developer';

import 'package:config_runner/config_runner.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    await generateAPI();
  } else {

    if(args.length < 2){
      log('dart run config_runner:config module <your-module-name>');
    }else{
      final type = args[0];

      final name = args[1];

      switch (type) {
        case 'module':
          await generateModule(moduleName: name);
          break;
        default:
          log('Unknown type: $type');
      }
    }
  }
}
