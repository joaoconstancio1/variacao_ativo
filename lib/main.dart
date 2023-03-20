import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:variacao_ativo/app_module.dart';
import 'package:variacao_ativo/app_widget.dart';
import 'package:variacao_ativo/modules/home/presenter/pages/homepage.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
