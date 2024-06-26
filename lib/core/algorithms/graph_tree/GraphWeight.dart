import 'dart:math';

abstract class GraphWeight {
  Map<int, Map<int, int>> w_graph = {};
  Map<int, int> vertex_weights = {}; // Добавляем веса вершин

  Map<int, Map<int, int>> get weight_graph => this.w_graph;

  GraphWeight() {
    generate_graph();
  }

  void generate_graph();

  void create_empty_graph(var numberOfVertices) {
    for (var i = 1; i <= numberOfVertices; i++) {
      w_graph[i] = {};
      vertex_weights[i] = Random().nextInt(20) +
          1; // Генерируем случайный вес для каждой вершины
    }
  }

  void print_graph() {
    for (var element in w_graph.entries) {
      print(element);
    }
    print('\n');
    for (var element in vertex_weights.entries) {
      print(element);
    }
    print('\n');
  }
}
