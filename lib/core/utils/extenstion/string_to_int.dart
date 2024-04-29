// string to int
extension StringToInt on String {
  int toInt() {
    return int.parse(isEmpty ? '0' : this);
  }
}