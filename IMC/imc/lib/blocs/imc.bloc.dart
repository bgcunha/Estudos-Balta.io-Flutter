class ImcBloc {
  // var heightCtrl = new MaskedTextController(mask: "000");
  // var weightCtrl = new MaskedTextController(mask: "000");
  var result = 'Preencha os dados para calcular seu IMC';

  calculate() {
    var height = 1.75; //double.parse(heightCtrl.text);
    var weight = 70; //double.parse(weightCtrl.text);

    var imc = weight / (height * height);

    if (imc < 18.6) {
      result = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
    } else if (imc > 18.4 && imc < 25) {
      result = "Peso ideal (${imc.toStringAsPrecision(2)})";
    } else if (imc > 24.8 && imc < 30) {
      result = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
    } else if (imc > 29.8 && imc < 35) {
      result = "Obesidade grau I (${imc.toStringAsPrecision(2)})";
    } else if (imc > 34.8 && imc < 40) {
      result = "Obesidade grau II (${imc.toStringAsPrecision(2)})";
    } else if (imc > 39.9) {
      result = "Obesidade grau III (${imc.toStringAsPrecision(2)})";
    }
  }
}
