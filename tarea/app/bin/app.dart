import 'dart:async';
import 'dart:math';

List<String> vehiculos = [
  "Cris en bicicleta", "Andy a pata", "Carro de Blasco", 
  "Deportivo Táchira Móvil", "Tayni Móvil", "Caballo"
];

List<String> eventos = [
  "tomó una curva cerrada con habilidad del carajo, esta loco",
  "se le jodió la caja y perdió velocidad",
  "se sacó la monda y pasó a varios competidores",
  "se salió de la pista pero logró volver, así como mis amigos con los ex",
  "se hizo mierda contra una barrera, pero ya se está recuperando",
  "evitó un obstáculo en el último segundo",
  "su caucho hizo *puff*, pero siguió adelante",
  "fue alcanzado por una nube de polvo porque pasó un furro y perdió visibilidad",
  "se sacó la monda y realizó un adelantamiento impresionante en la recta final"
];

List<String> seleccionarVehiculos() {
  Random random = Random();
  return List.generate(5, (_) => vehiculos[random.nextInt(vehiculos.length)]);
}

Stream<String> carreraStream(List<String> competidores) async* {
  Random random = Random();
  Map<String, int> adelantamientos = {for (var v in competidores) v: 0}; 
  bool hayGanador = false;

  while (!hayGanador) {
    await Future.delayed(Duration(milliseconds: random.nextInt(1000) + 500));

    String vehiculo = competidores[random.nextInt(competidores.length)];
    String evento = eventos[random.nextInt(eventos.length)];
    bool adelanto = random.nextBool();

    if (adelanto) {
      adelantamientos[vehiculo] = adelantamientos[vehiculo]! + 1;
      yield "🔹 $vehiculo adelantó a un rival y ahora tiene ${adelantamientos[vehiculo]} adelantamientos.";
    } else {
      yield "🔹 $vehiculo $evento.";
    }

    if (adelantamientos[vehiculo] == 4) {
      hayGanador = true;
      yield "\n🎉 ¡La carrera ha terminado! 🎉\n🏆 El ganador es: $vehiculo al adelantar a todos sus rivales. 🏆";
    }
  }
}

Future<void> iniciarCarrera() async {
  print("🏁 ¡Bienvenidos a la gran carrera del año! 🏁");

  List<String> competidores = seleccionarVehiculos();
  print("Los corredores de hoy son:");
  for (var vehiculo in competidores) {
    print("🚗 $vehiculo");
  }

  print("\n🔥 ¡Comienza la carrera! 🔥\n");

  await for (String evento in carreraStream(competidores)) {
    print(evento);
  }
}

void main() async {
  await iniciarCarrera();
}
