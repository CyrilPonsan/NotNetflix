// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:not_netflix/repositories/data_repository.dart';
import 'package:not_netflix/ui/screens/home_screen.dart';
import 'package:not_netflix/utils/constantes.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    //  todo: appel api
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    //  on initialise nos différentes listes de films
    await dataProvider.initData();
    //  ensuite on part sur la page HomeScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/netflix_logo_1.png'),
        SpinKitFadingCircle(
          color: kPrimaryColor,
          size: 20,
        )
      ]),
    );
  }
}
