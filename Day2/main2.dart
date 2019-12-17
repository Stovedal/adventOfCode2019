import 'dart:io';
import 'dart:core';

void main() {
  readFileAsync().then((content) {
    List<String> input = content.split(",");
    for (int noun = 0; noun < 100; noun++) {
      for (int verb = 0; verb < 100; verb++) {
        List<int> commands = [];

        input.forEach((line) {
          commands.add(int.parse(line));
        });

        var output = compute(noun, verb, commands);
        if (output == 19690720) {
          print("Noun " +
              noun.toString() +
              " and verb " +
              verb.toString() +
              " produced " +
              output.toString() +
              " gives answer: " + (100 * noun + verb).toString()
               
              );
        }
      }
    }
  });
}

int compute(int noun, int verb, List<int> commands) {
  commands[1] = noun;
  commands[2] = verb;
  int i = 0;
  while (i < commands.length) {
    if (commands[i] == 1) {
      commands[commands[i + 3]] =
          commands[commands[i + 1]] + commands[commands[i + 2]];
      i = i + 4;
    } else if (commands[i] == 2) {
      commands[commands[i + 3]] =
          commands[commands[i + 1]] * commands[commands[i + 2]];
      i = i + 4;
    } else if (commands[i] == 99) {
      break;
    } else {
      print("ERROR at: " +
          i.toString() +
          " with value " +
          commands[i].toString());
      print("Code at error: " + commands.toString());
      throw Error();
    }
  }
  return commands[0];
}

Future<String> readFileAsync() async {
  File file = new File('./input.txt');
  return file.readAsString();
}
