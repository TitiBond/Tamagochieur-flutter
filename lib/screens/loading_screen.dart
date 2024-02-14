import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamagochieur/components/buttons/primary_button.dart';

class TamagoLoadingScreen extends StatefulWidget {
  const TamagoLoadingScreen({super.key});

  @override
  State<TamagoLoadingScreen> createState() => _TamagoLoadingScreenState();
}

class _TamagoLoadingScreenState extends State<TamagoLoadingScreen>
    with SingleTickerProviderStateMixin {
  bool isButtonVisible = true;
  double buttonOpacity = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
        const Duration(milliseconds: 1500),
        () => {
              setState(
                () {
                  isButtonVisible = true;
                  Future.delayed(const Duration(milliseconds: 500));
                  buttonOpacity = 1;
                },
              )
            });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.yellow[100]!,
              Colors.yellow[300]!,
              Colors.yellow[500]!,
            ])),
        child: Stack(children: [
          Center(child: Image.asset('assets/images/tamago.png')),
          isButtonVisible
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 10),
                  alignment: Alignment.bottomCenter,
                  child: TamagoPrimaryButton(
                      buttonText: "Click here",
                      buttonOpacity: buttonOpacity,
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/tamago');
                      }),
                )
              : const SizedBox()
        ]),
      ),
    );
  }
}
