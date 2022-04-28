import 'package:flutter/material.dart';
import 'package:flutter_calculator/constants/app_constants.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget calcButtons(String buttonText, Color buttonColor,
      {double buttonHeight = 1}) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 8),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  equation,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),

            // Using an Expanded widget makes a child of a Row, Column, or Flex expand to fill the available space along the main axis (e.g., horizontally for a Row or vertically for a Column).
            Expanded(
              child: Divider(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        calcButtons(
                          "C",
                          resultButtons,
                        ),
                        calcButtons(
                          "⌫",
                          operatorButtons,
                        ),
                        calcButtons(
                          "÷",
                          operatorButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "7",
                          digitButtons,
                        ),
                        calcButtons(
                          "8",
                          digitButtons,
                        ),
                        calcButtons(
                          "9",
                          digitButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "4",
                          digitButtons,
                        ),
                        calcButtons(
                          "5",
                          digitButtons,
                        ),
                        calcButtons(
                          "6",
                          digitButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "1",
                          digitButtons,
                        ),
                        calcButtons(
                          "2",
                          digitButtons,
                        ),
                        calcButtons(
                          "3",
                          digitButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          ".",
                          digitButtons,
                        ),
                        calcButtons(
                          "0",
                          digitButtons,
                        ),
                        calcButtons(
                          "00",
                          digitButtons,
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        calcButtons(
                          "×",
                          operatorButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "-",
                          operatorButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "+",
                          operatorButtons,
                        ),
                      ]),
                      TableRow(children: [
                        calcButtons(
                          "=",
                          resultButtons,
                          buttonHeight: 2,
                        ),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
