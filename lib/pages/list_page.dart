import 'package:chat2/widgets/app_bar.dart';
import 'package:flutter/material.dart';

abstract class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  Widget? getDrawer(BuildContext context) {
    return null;
  }
  ///Le titre présent dans l'app bar
  Widget? getTitle() {
    return null;
  }
  ///Retourne le contenu de l'écran
  Widget getBody();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: getAppBar(title: getTitle()),
        drawer: getDrawer(context),
        body: getBody(),
      );
    }
}