import 'dart:io';
import 'dart:core';

void main(){
  
  readFileAsync().then((content){
    List<String> input = content.split("\n");
    double totalFuel = 0;
    input.forEach((line) {
      var mass = double.parse(line);
      var fuel = calcFuel(mass);
      print(fuel);
      totalFuel += fuel;
      });
      print("TOTAL FUEL " + totalFuel.toString());
  });
  
}

double calcFuel(double mass){
  var fuel = ((mass - (mass % 3)) / 3) - 2;
  if (fuel > 0) {
    return fuel + calcFuel(fuel);
  } else {
    return 0;
  }
}

Future<String> readFileAsync () async {
  File file = new File('./input.txt'); 
  return  file.readAsString();
}

