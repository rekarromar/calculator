import 'package:calculator/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('del', "⌫");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: buttonColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 60,
        onPressed: () => buttonPressed(buttonText),
        icon: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
        ),

        // child: Text(
        //   buttonText,
        //   style: TextStyle(
        //     fontSize: 30.0,
        //     fontWeight: FontWeight.normal,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }

  SizedBox smallwidth = SizedBox(
    width: 10,
  );

  SizedBox smallHeight = SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Rekar's Calculator",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              width: 10,
              strokeAlign: StrokeAlign.outside,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(maxWidth: 450),
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          equation,
                          style: TextStyle(
                              fontSize: equationFontSize, color: Colors.white),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Text(
                          result,
                          style: TextStyle(
                              fontSize: resultFontSize, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "C",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "⌫",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "÷",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "×",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                        ],
                      ),
                    ),
                    smallHeight,
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "7",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "8",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "9",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "-",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                        ],
                      ),
                    ),
                    smallHeight,
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "4",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "5",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "6",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "+",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                        ],
                      ),
                    ),
                    smallHeight,
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "1",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "2",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "3",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "=",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                          smallwidth,
                        ],
                      ),
                    ),
                    smallHeight,
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              ".",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "0",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "00",
                              Colors.white,
                              Colors.black,
                            ),
                          ),
                          smallwidth,
                          Flexible(
                            flex: 1,
                            child: buildButton(
                              "000",
                              Colors.black,
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    smallHeight,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
