import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:yaml/yaml.dart';

Future<String> resolveTemplatePath(String relativePath) async {
  final packageUri = Uri.parse('package:config_runner/templates/$relativePath');
  final resolvedUri = await Isolate.resolvePackageUri(packageUri);

  if (resolvedUri == null) {
    throw Exception('Could not resolve package URI: $packageUri');
  }

  final file = File.fromUri(resolvedUri);
  print(file.path);
  if (!await file.exists()) {
    throw Exception('Template not found at ${file.path}');
  }

  return await file.readAsString();
}

String applyTemplate(String template, Map<String, String> vars) {
  var content = template;
  vars.forEach((key, value) {
    content = content.replaceAll('{{$key}}', value);
  });
  return content;
}

///create the environment file
Future<void> _createEnvironment() async {
  try {
    final template = await resolveTemplatePath('env.txt');
    print('✅ creating your environment');

    final dir = Directory('lib/core');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    print('✅ adding environment.......');

    final outputFile = File('lib/core/environment.dart');
    await outputFile.writeAsString(template);
    print('✅ Environment created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

///create the APIURL file
Future<void> _createAPIURL() async {
  try {
    final template = await resolveTemplatePath('api_url.txt');
    print('✅ creating your api url class');

    final dir = Directory('lib/api');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('lib/api/api_url.dart');
    await outputFile.writeAsString(template);
    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createStatus() async {
  try {
    final template = await resolveTemplatePath('status.txt');
    print('✅ creating your api url class');

    final dir = Directory('lib/core');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('lib/core/status.dart');
    await outputFile.writeAsString(template);
    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createResource() async {
  try {
    final template = await resolveTemplatePath('resource.txt');
    print('✅ creating your api url class');

    final dir = Directory('lib/core');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('lib/core/resource.dart');
    await outputFile.writeAsString(template);
    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

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
      final template = await resolveTemplatePath('generate_api_url.txt');
      print(template);
      final content = template
          .replaceAll('{{className}}', element['className'])
          .replaceAll('{{env}}', element['env'])
          .replaceAll('{{projectName}}', projectName);

      print('✅ Here');

      final dir = Directory('lib/api');

      print('✅ generating.....');

      if (!await dir.exists()) {
        print('✅ creating model.......');
        await dir.create(recursive: true);
        print('✅ model created.......');
      }

      print('✅ adding file.......');

      final outputFile = File('lib/api/${element['file_name']}.dart');
      await outputFile.writeAsString(content);
      print('✅ File created');
    } catch (e, stackTrace) {
      log('Exception: $e $stackTrace');
    }
  });

  await _createStatus();

  await _createResource();
}

Future<void> _createRepo({required String moduleName}) async {
  try {
    final repoTemplate = await resolveTemplatePath('module/repo.txt');

    final repoImplementationTemplate =
        await resolveTemplatePath('module/repo_impl.txt');

    String repoClassName = '${_toPascalCase(moduleName)}Repo';

    String repoImplementationClassName = '${repoClassName}Implementation';

    String repoFileName = toCase(repoClassName);

    String repoImplementationFileName = toCase(repoImplementationClassName);

    final repoContext = repoTemplate.replaceAll('{{repoName}}', repoClassName);

    final repoImplementationContext = repoImplementationTemplate
        .replaceAll('{{className}}', repoImplementationClassName)
        .replaceAll('{{repoName}}', repoClassName)
        .replaceAll('{{repoFileName}}', repoFileName);

    print('✅ creating your repo');

    final dir = Directory('lib/module');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    print('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/repo');

    print('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('${dir2.path}/$repoFileName.dart');
    await outputFile.writeAsString(repoContext);

    final outputFile1 = File('${dir2.path}/$repoImplementationFileName.dart');
    await outputFile1.writeAsString(repoImplementationContext);

    print('repo added successfully ✅');

    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createProvider({required String moduleName}) async {
  try {
    final providerTemplate = await resolveTemplatePath('module/provider.txt');

    String providerClassName = '${_toPascalCase(moduleName)}Provider';

    String providerFileName = toCase(providerClassName);

    final providerContext =
        providerTemplate.replaceAll('{{className}}', providerClassName);

    print('✅ creating your provider');

    final dir = Directory('lib/module');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    print('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/provider');

    print('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('${dir2.path}/$providerFileName.dart');
    await outputFile.writeAsString(providerContext);

    print('provider added successfully ✅');

    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

Future<void> _createScreen({required String moduleName}) async {
  try {
    final screenTemplate = await resolveTemplatePath('module/screen.txt');

    String providerClassName = '${_toPascalCase(moduleName)}Provider';

    String providerFileName = toCase(providerClassName);

    String screenClassName = '${_toPascalCase(moduleName)}Screen';

    String screenFileName = toCase(screenClassName);

    final screenContext = screenTemplate
        .replaceAll('{{ClassName}}', screenClassName)
        .replaceAll('{{ProviderName}}', providerClassName)
        .replaceAll('{{provider_file_name}}', providerFileName);

    print('✅ creating your provider');

    final dir = Directory('lib/module');

    print('✅ generating.....');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final dir1 = Directory('lib/module/$moduleName');

    print('✅ generating.....');

    if (!await dir1.exists()) {
      await dir1.create(recursive: true);
    }

    final dir2 = Directory('lib/module/$moduleName/screen');

    print('✅ generating.....');

    if (!await dir2.exists()) {
      await dir2.create(recursive: true);
    }

    print('✅ adding file.......');

    final outputFile = File('${dir2.path}/$screenFileName.dart');
    await outputFile.writeAsString(screenContext);

    print('screen added successfully ✅');

    print('✅ File created at ${outputFile.path}');
  } catch (e, stackTrace) {
    log('Exception: $e $stackTrace');
  }
}

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

String toCase(String input) {
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
