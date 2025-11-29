enum Priority {
  low(60),
  normal(30),
  high(10),
  critical(0);

  final int deliveryTimeMinutes;
  const Priority(this.deliveryTimeMinutes);

  String toJson() => name.toUpperCase();

  static Priority fromJson(String value) {
    try {
      return Priority.values.firstWhere(
        (e) => e.name.toUpperCase() == value.toUpperCase(),
      );
    } catch (_) {
      return Priority.normal;
    }
  }
}