import 'package:aog/widgets/input.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'loading-button.widget.dart';

class SubmitForm extends StatelessWidget {
  var gasCtrl = new MoneyMaskedTextController();
  var alcCtrl = new MoneyMaskedTextController();
  var busy = false;
  late Function submitFunc;

  SubmitForm(MoneyMaskedTextController gasCtrl,
      MoneyMaskedTextController alcCtrl, bool busy, Function submitFunc) {
    this.gasCtrl = gasCtrl;
    this.alcCtrl = alcCtrl;
    this.busy = busy;
    this.submitFunc = submitFunc;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Input(
            'Gasolina',
            gasCtrl,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Input(
            'Álcool',
            alcCtrl,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        LoadingButton(busy, false, submitFunc, 'CALCULAR'),
      ],
    );
  }
}
