import 'dart:io';
import 'dart:core';

void main() {
  readFileAsync().then((content) {
    List<String> input = content.split(",");
    List<int> commands = [];
    input.forEach((line) {
      commands.add(int.parse(line));
    });
    print("code " + commands.toString());
    commands[1] = 12;
    commands[2] = 2;
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
        print("ERROR at: " + i.toString() + " with value " + commands[i].toString());
        print("Code at error: " + commands.toString());
        throw Error();
      }
    }

    print("result " + commands.toString());
  });

}

Future<String> readFileAsync() async {
  File file = new File('./input.txt');
  return file.readAsString();
}
