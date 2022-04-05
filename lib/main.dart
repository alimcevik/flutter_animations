import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _title = "Flutter Animations";
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController alphaAnimationController;
  late Animation<double> alphaAnimation;

  late AnimationController scaleAnimationController;
  late Animation<double> scaleAnimation;

  late AnimationController rotateAnimationController;
  late Animation<double> rotateAnimation;

  late AnimationController translateAnimationController;
  late Animation<double> translateAnimation;

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);

  @override
  void initState() {
    super.initState();

    initAlphaAnimation();
    initScaleAnimation();
    initRotateAnimation();
    initTranslateAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    alphaAnimationController.dispose();
    scaleAnimationController.dispose();
    rotateAnimationController.dispose();
    translateAnimationController.dispose();
  }

  initAlphaAnimation() {
    alphaAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    alphaAnimation = Tween(
      begin: 1.0,
      end: 0.4,
    ).animate(alphaAnimationController)
      ..addListener(() {
        setState(() {});
        debugPrint(alphaAnimationController.status.toString());
      });
  }

  initScaleAnimation() {
    scaleAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    scaleAnimation = Tween(
      begin: 250.0,
      end: 125.0,
    ).animate(scaleAnimationController)
      ..addListener(() {
        setState(() {});
        debugPrint(scaleAnimationController.status.toString());
      });
  }

  initRotateAnimation() {
    rotateAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    rotateAnimation = Tween(
      begin: 0.0,
      end: pi / 2,
    ).animate(rotateAnimationController)
      ..addListener(() {
        setState(() {});
        debugPrint(rotateAnimationController.status.toString());
      });
  }

  initTranslateAnimation() {
    translateAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    translateAnimation = Tween(
      begin: 0.0,
      end: 50.0,
    ).animate(translateAnimationController)
      ..addListener(() {
        setState(() {});
        debugPrint(translateAnimationController.status.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.restore),
        tooltip: "Reset Animation",
        onPressed: () {
          alphaAnimationController.reverse();
          scaleAnimationController.reverse();
          rotateAnimationController.reverse();
          translateAnimationController.reverse();
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: _opacityTween.evaluate(alphaAnimation),
                child: Transform.translate(
                  offset: Offset(translateAnimation.value, 0.0),
                  child: Transform.rotate(
                    angle: rotateAnimation.value,
                    child: SizedBox(
                      height: scaleAnimation.value,
                      child: Image.asset(
                        "assets/dash.png",
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: _opacityTween.evaluate(alphaAnimation),
                child: Transform.translate(
                  offset: Offset(translateAnimation.value, 0.0),
                  child: Transform.rotate(
                    angle: rotateAnimation.value,
                    child: SizedBox(
                      height: scaleAnimation.value,
                      child: Image.asset(
                        "assets/dash.png",
                      ),
                    ),
                  ),
                ),
              ),
              myButton(
                color: Colors.red,
                title: "Example 1 - Alpha Animation",
                onTap: () {
                  alphaAnimationController.forward();
                },
              ),
              myButton(
                color: Colors.orange,
                title: "Example 2 - Scale Animation",
                onTap: () {
                  scaleAnimationController.forward();
                },
              ),
              myButton(
                color: Colors.blue,
                title: "Example 3 - Rotate Animation",
                onTap: () {
                  rotateAnimationController.forward();
                },
              ),
              myButton(
                color: Colors.brown,
                title: "Example 4 - Translate Animation",
                onTap: () {
                  translateAnimationController.forward();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  myButton({
    @required String? title,
    @required Function()? onTap,
    @required Color? color,
  }) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: height * 0.01),
        child: Container(
          height: height * 0.04,
          width: width / 2,
          color: color,
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
