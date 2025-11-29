enum DeliveryMethod {
  push,
  email,
  both,
  none;

  String toJson() => name.toUpperCase();

  static DeliveryMethod fromJson(String value) {
    try {
      return DeliveryMethod.values.firstWhere(
        (e) => e.name.toUpperCase() == value.toUpperCase(),
      );
    } catch (_) {
      return DeliveryMethod.push;
    }
  }
}