class Memory {
  String _value = "0";
  void applyCommand(String command) {
    // Lógica para aplicar o comando e atualizar _value
    _value += command; // Exemplo simples: apenas define o valor como o comando
  }

  String get value {
    return _value;
  }
}
