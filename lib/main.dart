import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Job',
      home: LicensePageWidget(),
    ),
  );
}

class LicensePageWidget extends StatelessWidget {
  const LicensePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pub Versions'),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('pubspec.yaml'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            final pubspecContent = snapshot.data!;
            final yaml = loadYaml(pubspecContent);
            final dependencies = yaml['dependencies'] as YamlMap? ?? {};
            final devDependencies = yaml['dev_dependencies'] as YamlMap? ?? {};
            final allDependencies = {...dependencies, ...devDependencies};

            return ListView.builder(
              itemCount: allDependencies.length,
              itemBuilder: (BuildContext context, int index) {
                final dependency = allDependencies.keys.elementAt(index);
                final version = allDependencies[dependency];

                return ListTile(
                  title: Text('$dependency: $version'),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.library_books_rounded),
        onPressed: () {
          showLicensePage(
            context: context,
            applicationVersion: '1.1.2',
            applicationName: 'Job',
            applicationLegalese: '© 2021 Job',
            applicationIcon: const Text('display Logo here'),
          );
        },
      ),
    );
  }
}
