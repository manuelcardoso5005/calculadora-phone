class Memory {
  static const operations = ["%", "+", "-", "x", "/", "="];

  String _value = "0"; // valor exibido
  late final List<double> _buffer; // buffer para cálculos
  int _bufferIndex = 0; // indica qual buffer está ativo
  String _operation = ""; // operação atual
  bool _wipeValue = false; // indica se o display deve ser limpo ao digitar
  String _lastCommand = ""; // guarda último comando para lógica de substituição
  double _lastOperand = 0.0; // guarda o último número usado em '='

  Memory() {
    _buffer = List.filled(2, 0.0); // inicializa buffer com 0.0
  }

  // Aplica comando recebido (número, operador ou AC)
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

  // Verifica se o operador atual deve substituir o anterior
  bool _isReplacingOperation(String command) {
    final lastIsOp = operations.contains(_lastCommand) && _lastCommand != "=";
    final currentIsOp = operations.contains(command) && command != "=";
    if (command == "%") return false; // '%' não substitui operador
    return lastIsOp && currentIsOp;
  }

  // Define operação e calcula resultado se necessário
  void _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      // Primeiro número digitado
      if (newOperation == "=") {
        // '=' pressionado sem segundo número: nada a fazer
        return;
      }
      _operation = newOperation;
      _bufferIndex = 1; // agora vamos receber o segundo número
    } else {
      // Calcula resultado
      if (_lastCommand == "=") {
        // Pressionando operador após '='
        _buffer[1] = _lastOperand;
      }

      _buffer[0] = _calculate();
      _value = _formatValue(_buffer[0]);

      if (newOperation == "=") {
        // '=': mantém resultado, prepara para repetição
        _lastOperand = _buffer[1];
        _bufferIndex = 0;
        _operation = "";
      } else {
        _operation = newOperation;
        _bufferIndex = 1;
        _buffer[1] = 0.0;
      }
    }

    _wipeValue = true;
  }

  // Adiciona dígito ao valor atual
  void _addDigit(String digit) {
    final isDot = digit == ".";
    final wipeValue = (_value == "0" && !isDot) || _wipeValue;

    if (isDot && _value.contains(".") && !wipeValue) return;

    final emptyValue = isDot ? "0" : "";
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    // Proteção para web
    final valueToParse = _value.isEmpty ? "0" : _value;
    if (_bufferIndex < 0 || _bufferIndex >= _buffer.length) {
      _bufferIndex = 0;
    }

    _buffer[_bufferIndex] = double.tryParse(valueToParse) ?? 0;
  }

  // Limpa todos os valores
  void _allClear() {
    _value = "0";
    _buffer[0] = 0.0;
    _buffer[1] = 0.0;
    _bufferIndex = 0;
    _operation = "";
    _wipeValue = false;
    _lastCommand = "";
    _lastOperand = 0.0;
  }

  // Calcula resultado baseado no operador atual
  double _calculate() {
    switch (_operation) {
      case "+":
        return _buffer[0] + _buffer[1];
      case "-":
        return _buffer[0] - _buffer[1];
      case "x":
        return _buffer[0] * _buffer[1];
      case "/":
        // Tratamento de divisão por zero
        return _buffer[1] != 0 ? _buffer[0] / _buffer[1] : double.nan;
      case "%":
        // % transforma o segundo número em porcentagem do primeiro
        return _buffer[0] * (_buffer[1] / 100);
      default:
        return _buffer[0];
    }
  }

  // Formata valor para display: remove ".0" se inteiro e limita casas decimais
  String _formatValue(double val) {
    if (val.isNaN) return "Erro"; // exibe erro para divisão por zero
    return val % 1 == 0
        ? val.toInt().toString()
        : val
              .toStringAsFixed(8)
              .replaceFirst(RegExp(r'0+$'), '')
              .replaceFirst(RegExp(r'\.$'), '');
  }

  String get value => _value;
}
