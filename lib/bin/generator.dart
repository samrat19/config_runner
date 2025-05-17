import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:yaml/yaml.dart';

Future<String> _resolveTemplatePath(String relativePath) async {
  final packageUri = Uri.parse('package:config_runner/templates/$relativePath');
  final resolvedUri = await Isolate.resolvePackageUri(packageUri);

  if (resolvedUri == null) {
    throw Exception('Could not resolve package URI: $packageUri');
  }

  final file = File.fromUri(resolvedUri);
  log(file.path);
  if (!await file.exists()) {
    throw Exception('Template not found at ${file.path}');
  }

  return await file.readAsString();
}

///create the environment file
Future<void> _createEnvironment() async {
  try {
    final template = await _resolveTemplatePath('env.txt');
    log('✅ creating your environment');

    final dir = Directory('lib/core');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    log('✅ adding environment.......');

    final outputFile = File('lib/core/environment.dart');
    await outputFile.writeAsString(template);
    log('✅ Environment created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

///create the API URL file
Future<void> _createAPIURL() async {
  try {
    final template = await _resolveTemplatePath('api_url.txt');
    log('✅ creating your api url class');

    final dir = Directory('lib/api');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('lib/api/api_url.dart');
    await outputFile.writeAsString(template);
    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createStatus() async {
  try {
    final template = await _resolveTemplatePath('status.txt');
    log('✅ creating your api url class');

    final dir = Directory('lib/core');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('lib/core/status.dart');
    await outputFile.writeAsString(template);
    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createResource() async {
  try {
    final template = await _resolveTemplatePath('resource.txt');
    log('✅ creating your api url class');

    final dir = Directory('lib/core');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('lib/core/resource.dart');
    await outputFile.writeAsString(template);
    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

///generate api based on environment specified on to documentation
///
///
Future<void> generateAPI() async {
  await _createEnvironment();

  await _createAPIURL();

  String? projectName = await _getProjectName();

  List<Map<String, dynamic>> env = [
    {
      'className': 'DevAPIURL',
      'file_name': 'dev_api_url',
      'env': 'development'
    },
    {'className': 'UatAPIURL', 'file_name': 'uat_api_url', 'env': 'uat'},
    {
      'className': 'ProdAPIURL',
      'file_name': 'prod_api_url',
      'env': 'production'
    },
  ];

  Future.forEach(env, (element) async {
    try {
      final template = await _resolveTemplatePath('generate_api_url.txt');
      log(template);
      final content = template
          .replaceAll('{{className}}', element['className'])
          .replaceAll('{{env}}', element['env'])
          .replaceAll('{{projectName}}', projectName);

      log('✅ Here');

      final dir = Directory('lib/api');

      log('✅ generating.....');

      if (!await dir.exists()) {
        log('✅ creating model.......');
        await dir.create(recursive: true);
        log('✅ model created.......');
      }

      log('✅ adding file.......');

      final outputFile = File('lib/api/${element['file_name']}.dart');
      await outputFile.writeAsString(content);
      log('✅ File created');
    } catch (e, stackTrace) {
      log('Exception: $e $stackTrace');
    }
  });

  await _createStatus();

  await _createResource();
}

Future<void> _createRepo({required String moduleName}) async {
  try {
    final repoTemplate = await _resolveTemplatePath('module/repo.txt');

    final repoImplementationTemplate =
        await _resolveTemplatePath('module/repo_impl.txt');

    String repoClassName = '${_toPascalCase(moduleName)}Repo';

    String repoImplementationClassName = '${repoClassName}Implementation';

    String repoFileName = _toCase(repoClassName);

    String repoImplementationFileName = _toCase(repoImplementationClassName);

    final repoContext = repoTemplate.replaceAll('{{repoName}}', repoClassName);

    final repoImplementationContext = repoImplementationTemplate
        .replaceAll('{{className}}', repoImplementationClassName)
        .replaceAll('{{repoName}}', repoClassName)
        .replaceAll('{{repoFileName}}', repoFileName);

    log('✅ creating your repo');

    final dir = Directory('lib/module');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    log('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/repo');

    log('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('${dir2.path}/$repoFileName.dart');
    await outputFile.writeAsString(repoContext);

    final outputFile1 = File('${dir2.path}/$repoImplementationFileName.dart');
    await outputFile1.writeAsString(repoImplementationContext);

    log('repo added successfully ✅');

    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createProvider({required String moduleName}) async {
  try {
    final providerTemplate = await _resolveTemplatePath('module/provider.txt');

    String providerClassName = '${_toPascalCase(moduleName)}Provider';

    String providerFileName = _toCase(providerClassName);

    final providerContext =
        providerTemplate.replaceAll('{{className}}', providerClassName);

    log('✅ creating your provider');

    final dir = Directory('lib/module');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    log('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/provider');

    log('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('${dir2.path}/$providerFileName.dart');
    await outputFile.writeAsString(providerContext);

    log('provider added successfully ✅');

    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createScreen({required String moduleName}) async {
  try {
    final screenTemplate = await _resolveTemplatePath('module/screen.txt');

    String providerClassName = '${_toPascalCase(moduleName)}Provider';

    String providerFileName = _toCase(providerClassName);

    String screenClassName = '${_toPascalCase(moduleName)}Screen';

    String screenFileName = _toCase(screenClassName);

    final screenContext = screenTemplate
        .replaceAll('{{ClassName}}', screenClassName)
        .replaceAll('{{ProviderName}}', providerClassName)
        .replaceAll('{{provider_file_name}}', providerFileName);

    log('✅ creating your provider');

    final dir = Directory('lib/module');

    log('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    log('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/screen');

    log('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    log('✅ adding file.......');

    final outputFile = File('${dir2.path}/$screenFileName.dart');
    await outputFile.writeAsString(screenContext);

    log('screen added successfully ✅');

    log('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

///generate module base boiler-plate code based on your command 
///
/// 
Future<void> generateModule({required String moduleName}) async {
  ///create repo
  ///
  await _createRepo(moduleName: moduleName.toLowerCase());

  ///create provider
  ///
  await _createProvider(moduleName: moduleName.toLowerCase());

  ///create screen
  ///
  _createScreen(moduleName: moduleName.toLowerCase());
}

Future<String> _getProjectName() async {
  final pubspec = File('pubspec.yaml');
  final contents = await pubspec.readAsString();
  final doc = loadYaml(contents);
  return doc['name'] ?? 'add-project-name-here';
}

String _toPascalCase(String input) {
  return input
      .split('-')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join();
}

String _toCase(String input) {
  final buffer = StringBuffer();
  for (int i = 0; i < input.length; i++) {
    String char = input[i];
    if (char.toUpperCase() == char && i != 0) {
      buffer.write('_');
    }
    buffer.write(char.toLowerCase());
  }
  return buffer.toString();
}
