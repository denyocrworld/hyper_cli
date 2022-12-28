import 'dart:io';

import 'package:hyper_cli/hyper_cli.dart' as hyper_cli;

void main(List<String> arguments) {
  print('Hello world: ${hyper_cli.calculate()}!');
  print("arguments: $arguments");

  if (arguments[0] == "create") {
    String moduleName = arguments[1];

    print("Kamu sedang mencoba membuat module $moduleName");

    var viewDir = Directory("./lib/module/$moduleName/view/");
    viewDir.createSync(recursive: true);

    var controllerDir = Directory("./lib/module/$moduleName/controller/");
    controllerDir.createSync(recursive: true);

    createView(moduleName, viewDir);
    createController(moduleName, controllerDir);
  }
}

createView(
  String moduleName,
  Directory viewDir,
) {
  String viewTemplate = """
import 'package:flutter/material.dart';
import '../controller/import_name_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => LoginController();

  build(BuildContext context, LoginController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: const [
          //content
        ],
      ),
    );
  }
}
""";
  //product_form
  String className = moduleName.toPascalCase();
  String variableName = moduleName.toCamelCase();
  String lowerCaseWithUnderscore = moduleName.toLowerCaseWithUnderscore();
  viewTemplate = viewTemplate.replaceAll("Login", className);
  viewTemplate = viewTemplate.replaceAll("login", variableName);
  viewTemplate =
      viewTemplate.replaceAll("import_name", lowerCaseWithUnderscore);

  //                                   login_view.dart
  var viewFile = File("${viewDir.path}/${moduleName}_view.dart");
  File(viewFile.path).createSync();
  viewFile.writeAsStringSync(viewTemplate);
}

createController(
  String moduleName,
  Directory controllerDir,
) {
  String controllerTemplate = """
import 'package:flutter/material.dart';
import '../view/import_name_view.dart';

class LoginController extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}

""";
  String className = moduleName.toPascalCase();
  String variableName = moduleName.toCamelCase();
  String lowerCaseWithUnderscore = moduleName.toLowerCaseWithUnderscore();

  controllerTemplate = controllerTemplate.replaceAll("Login", className);
  controllerTemplate = controllerTemplate.replaceAll("login", variableName);
  controllerTemplate =
      controllerTemplate.replaceAll("import_name", lowerCaseWithUnderscore);
  //                                   login_view.dart
  var controllerFile =
      File("${controllerDir.path}/${moduleName}_controller.dart");
  File(controllerFile.path).createSync();
  controllerFile.writeAsStringSync(controllerTemplate);
}
/*
hyper_cli create login
lib/module/view/login_view.dart
lib/module/view/login_controller.dart
*/

extension StringExtension on String {
  String toPascalCase() {
    var words = split(' ');
    var pascalCase = '';
    for (var word in words) {
      pascalCase += word[0].toUpperCase() + word.substring(1);
    }
    return pascalCase;
  }

  String toCamelCase() {
    var words = split(' ');
    var result = '';
    for (var i = 0; i < words.length; i++) {
      if (i == 0) {
        result += words[i].toLowerCase();
      } else {
        result += words[i].substring(0, 1).toUpperCase() +
            words[i].substring(1).toLowerCase();
      }
    }
    return result;
  }

  String toLowerCaseWithUnderscore() {
    return replaceAll(' ', '_').toLowerCase();
  }
}
