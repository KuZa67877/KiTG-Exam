import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightFlow.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightPath.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_weight_vizualizer.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/little_path_graph_vizualization.dart';
import 'package:dmiti_project/core/textfield/field_cell.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class GraphWeightPathTask extends StatefulWidget {
  final GraphWeightPath myGraph;
  final bool isEducation;
  const GraphWeightPathTask(
      {super.key, required this.myGraph, required this.isEducation});

  @override
  State<GraphWeightPathTask> createState() => _GraphWeightPathTaskState();
}

class _GraphWeightPathTaskState extends State<GraphWeightPathTask> {
  List<List<TextEditingController>> controllers = [];
  late List<List<int>> correctAnswer;
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.myGraph.find_path();
    for (int i = 0; i < correctAnswer.length; i++) {
      controllers.add(List.generate(
          correctAnswer[i].length, (index) => TextEditingController()));
    }
    widget.myGraph.print_graph();
    print(correctAnswer);
    if (widget.isEducation) {
      steps = widget.myGraph.findPathSteps();
    }
  }

  @override
  void dispose() {
    for (var controllerRow in controllers) {
      for (var controller in controllerRow) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void checkAnswer() {
    bool isCorrect = true;

    for (int i = 0; i < correctAnswer.length; i++) {
      for (int j = 0; j < correctAnswer[i].length; j++) {
        if (controllers[i][j].text.trim() != correctAnswer[i][j].toString()) {
          isCorrect = false;
          break;
        }
      }
      if (!isCorrect) break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultDialog(
          context: context,
          colorButton: isCorrect ? AppColors.green : AppColors.redBackground,
          mainText: isCorrect ? "Успех" : "Неудача",
          infoText:
              isCorrect ? "Вы успешно решили задачу" : "Повторите попытку",
          buttonText: "Начать заново",
          onPressedFunction: () {
            Navigator.of(context).pop(); // Закрыть диалоговое окно
            for (var controllerRow in controllers) {
              for (var controller in controllerRow) {
                controller.clear(); // Очистить все поля ввода
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            children: [
              if (widget.isEducation) SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Путь между двумя вершинами графа - это путь с наименьшим весом (суммой весов ребер) между этими вершинами.",
                  style: getTheme().textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Найдите кратчайший путь для каждой вершины",
                style: getTheme().textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: Container(
                    height: 250,
                    width: 200,
                    child: GraphLittlePathWidget(
                      graphWeight: widget.myGraph,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: List.generate(correctAnswer.length, (i) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(correctAnswer[i].length, (j) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.all(4),
                          child: FieldCell(
                            answer: correctAnswer[i][j],
                            controller: controllers[i][j],
                            isExample: widget.isEducation,
                            isEducation: widget.isEducation,
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
              DefaultButton(
                info: "Отправить",
                buttonColor: AppColors.green,
                onPressedFunction: widget.isEducation ? () {} : checkAnswer,
                isSettings: false,
              ),
              if (widget.isEducation) ...[
                Text(
                  "Пошаговая демонстрация нахождения решения:",
                  style: getTheme().textTheme.bodyLarge,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    steps[currentStep],
                    style: getTheme().textTheme.bodyLarge,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultButton(
                        info: "Предыдущий шаг",
                        buttonColor: AppColors.green,
                        onPressedFunction: previousStep,
                        isSettings: false,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DefaultButton(
                        info: "Следующий шаг",
                        buttonColor: AppColors.green,
                        onPressedFunction: nextStep,
                        isSettings: false,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
