import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FinalViewState createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = (controller.duration! * controller.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 11),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff253439),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/c4.png"),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "@Countrol4offical",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ),
            ),
          ]),
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: WaveWidget(
                    config: CustomConfig(
                      colors: [
                        const Color(0xffB29E84).withOpacity(0.3),
                        const Color(0xffB29E84).withOpacity(0.3),
                        const Color(0xffB29E84).withOpacity(0.4),
                        //the more colors here, the more wave will be
                      ],
                      durations: [4000, 5000, 7000],
                      heightPercentages: [0.01, 0.05, 0.03],
                      blur: const MaskFilter.blur(BlurStyle.solid, 5),
                    ),
                    waveAmplitude: 35.00, //depth of curves
                    waveFrequency: 3, //number of curves in waves
                    //background colors
                    size: Size(
                      double.infinity,
                      controller.value * MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 150,
                  left: 150,
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FloatingActionButton.extended(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      controller.isAnimating ? 10 : 20)),
                              backgroundColor: controller.isAnimating
                                  ? Colors.white
                                  : const Color(0xff253439),
                              onPressed: () {
                                if (controller.isAnimating) {
                                  controller.stop();
                                } else {
                                  controller.reverse(
                                      from: controller.value == 0.0
                                          ? 1.0
                                          : controller.value);
                                }
                              },
                              icon: Icon(
                                controller.isAnimating
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: !controller.isAnimating
                                    ? Colors.white
                                    : const Color(0xff253439),
                              ),
                              label: Text(
                                controller.isAnimating ? "Pause" : "Play",
                                style: TextStyle(
                                  color: !controller.isAnimating
                                      ? Colors.white
                                      : const Color(0xff253439),
                                ),
                              )),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: CircularProgressIndicator(
                                      color: controller.value < 0.4821094
                                          ? const Color(0xff253439)
                                          : Colors.white,
                                      backgroundColor: controller.isAnimating
                                          ? const Color.fromARGB(74, 0, 0, 0)
                                          : const Color(0xffB29E84),
                                      strokeWidth: 20,
                                      value: controller.value,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "0$timerString",
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: controller.value < 0.4821094
                                                ? const Color(0xff253439)
                                                : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
