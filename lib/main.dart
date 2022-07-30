import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_switch/flutter_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var result = "0.0";
  double resultFontSize = 66;
  double userFontSize = 40;
  bool isSwitched = false;
  late Color textColor;

  // color
  Color bgColor = const Color(0xFF17171C);
  Color btnPrimary = const Color(0xFF2E2F38);
  Color btnGrey = const Color(0xFF4E505F);
  Color btnBlueDark = const Color(0xFF4B5EFC);
  Color whiteColor = const Color(0xFFFFFFFF);
  Color blackColor = const Color(0xFF000000);

  List<String> buttons = [
    "AC",
    "x²",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "C",
    "=",
  ];

  // initialize the input controller
  late TextEditingController inputController;
  @override
  void initState() {
    inputController = TextEditingController()
      ..addListener(() {
        doCalculation();
      });
    super.initState();
  }

  // dispose
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        bgColor = const Color(0xFFF1F2F3);
        btnPrimary = whiteColor;
        btnGrey = const Color(0xFFD2D3DA);
      });
    } else {
      setState(() {
        isSwitched = false;
        bgColor = const Color(0xFF17171C);
        btnPrimary = const Color(0xFF2E2F38);
        btnGrey = const Color(0xFF4E505F);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            //output
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Switch(value: isSwitched, onChanged: toggleSwitch),
                    FlutterSwitch(
                      value: isSwitched,
                      onToggle: toggleSwitch,
                      padding: 6.0,
                      inactiveIcon: Image.asset(
                        "assets/moon.png",
                        width: 24,
                        height: 24,
                      ),
                      inactiveToggleColor: const Color(0xFF4E505F),
                      inactiveColor: const Color(0xFF2E2F38),
                      activeIcon: Image.asset(
                        "assets/sun.png",
                        width: 24,
                        height: 24,
                      ),
                      activeToggleColor: whiteColor,
                      activeColor: const Color(0xFFD2D3DA),
                    ),
                    TextField(
                      textAlign: TextAlign.right,
                      controller: inputController,
                      keyboardType: TextInputType.none,
                      style: TextStyle(
                        fontSize: userFontSize,
                        decoration: TextDecoration.none,
                        color: isSwitched
                            ? blackColor.withOpacity(0.50)
                            : whiteColor.withOpacity(0.50),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "0.0",
                        hintStyle: TextStyle(
                          color: isSwitched
                              ? blackColor.withOpacity(0.50)
                              : whiteColor.withOpacity(0.50),
                        ),
                        hintTextDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: resultFontSize,
                          color: isSwitched ? blackColor : whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // buttons
            Flexible(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return inputButton(buttons.elementAt(index));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doCalculation() {
    var expression = inputController.text;
    expression = expression.replaceAll("x", "*");
    Parser p = Parser();
    Expression mathExpression = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = mathExpression.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }

  Widget inputButton(String text) {
    Color btnColor;
    switch (text) {
      case '=':
        btnColor = btnBlueDark;
        textColor = whiteColor;
        break;
      case '+':
        btnColor = btnBlueDark;
        textColor = whiteColor;
        break;
      case '-':
        btnColor = btnBlueDark;
        textColor = whiteColor;
        break;
      case 'x':
        btnColor = btnBlueDark;
        textColor = whiteColor;
        break;
      case '/':
        btnColor = btnBlueDark;
        textColor = whiteColor;
        break;
      case '%':
        btnColor = btnGrey;
        textColor = isSwitched ? blackColor : whiteColor;
        break;
      case 'x²':
        btnColor = btnGrey;
        textColor = isSwitched ? blackColor : whiteColor;
        break;
      case 'AC':
        btnColor = btnGrey;
        textColor = isSwitched ? blackColor : whiteColor;
        break;
      default:
        btnColor = btnPrimary;
        textColor = isSwitched ? blackColor : whiteColor;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        setState(() {
          if (inputController.text.length >= 8) {
            resultFontSize = 36;
            userFontSize = 16;
          } else {
            resultFontSize = 66;
            userFontSize = 40;
          }

          if (text == "AC") {
            inputController.text = "";
            result = "0.0";
          } else if (text == "C") {
            inputController.text = inputController.text
                .substring(0, inputController.text.length - 1);
            if (inputController.text.isEmpty) {
              result = "0.0";
            }
          } else if (text == "x²") {
            inputController.text = "${inputController.text}^2";
          } else if (text == "=") {
            inputController.text;
          } else {
            inputController.text = inputController.text + text;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(
          12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24,
          ),
          color: btnColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
