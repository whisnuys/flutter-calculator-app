import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import './constant.dart';

void main() {
  runApp(MyApp());
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

  List<String> buttons = [
    "AC",
    "+/-",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
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
                    TextField(
                      textAlign: TextAlign.right,
                      controller: inputController,
                      keyboardType: TextInputType.none,
                      style: TextStyle(
                        fontSize: userFontSize,
                        decoration: TextDecoration.none,
                        color: whiteColor.withOpacity(0.50),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "0.0",
                        hintStyle: TextStyle(
                          color: whiteColor.withOpacity(0.50),
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
                          color: whiteColor,
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
        break;
      case '+':
        btnColor = btnBlueDark;
        break;
      case '-':
        btnColor = btnBlueDark;
        break;
      case 'x':
        btnColor = btnBlueDark;
        break;
      case '/':
        btnColor = btnBlueDark;
        break;
      case '%':
        btnColor = btnGreyDark;
        break;
      case '+/-':
        btnColor = btnGreyDark;
        break;
      case 'AC':
        btnColor = btnGreyDark;
        break;
      default:
        btnColor = btnPrimaryDark;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        setState(() {
          if (inputController.text.length >= 6) {
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
          } else if (text == "=") {
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
            color: whiteColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
