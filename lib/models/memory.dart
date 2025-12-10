class Memory {
  static const operations = ["%", "+", "-", "x", "/", "="];
  String _value = "0";
  late final List<double> _buffer; // inicializamos no construtor
  int _bufferIndex = 0;
  String _operation = "";
  bool _wipeValue = false;
  String _lastCommand = "";

  Memory() {
    _buffer = List.filled(2, 0.0); // garante buffer sempre válido
  }

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == "AC") {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != "=" &&
        command != "=";
  }

  void _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      if (newOperation == "=") {
        return;
      }
      _operation = newOperation;
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith(".0") ? _value.split('.')[0] : _value;

      bool isEqualSign = newOperation == "=";
      _operation = isEqualSign ? "" : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

    _wipeValue = true;
  }

  void _addDigit(String digit) {
    //print('Digit recebido: $digit');
    //print('_buffer antes: $_buffer, _bufferIndex: $_bufferIndex');

    final isDot = digit == ".";
    final wipeValue = (_value == "0" && !isDot) || _wipeValue;

    if (isDot && _value.contains(".") && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? "0" : "";
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    // proteção extra para Web
    final valueToParse = _value.isEmpty ? "0" : _value;
    if (_bufferIndex < 0 || _bufferIndex >= _buffer.length) {
      _bufferIndex = 0;
    }

    _buffer[_bufferIndex] = double.tryParse(valueToParse) ?? 0;

    // print('_buffer: $_buffer');
    // print(operations.indexOf(_operation));
  }

  void _allClear() {
    _value = "0";
    _buffer[0] = 0.0;
    _buffer[1] = 0.0;
    _bufferIndex = 0;
    _operation = "";
    _wipeValue = false;
  }

  _calculate() {
    switch (_operation) {
      case "+":
        return _buffer[0] + _buffer[1];
      case "-":
        return _buffer[0] - _buffer[1];
      case "x":
        return _buffer[0] * _buffer[1];
      case "/":
        return _buffer[1] != 0 ? _buffer[0] / _buffer[1] : 0;
      case "%":
        return _buffer[1] != 0 ? _buffer[0] % _buffer[1] : 0;
      default:
        return _buffer[0];
    }
  }

  String get value => _value;
}
