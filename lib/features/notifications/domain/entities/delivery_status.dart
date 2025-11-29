enum DeliveryStatus {
  pending,
  sent,
  delivered,
  failed,
  read;

  String toJson() => name.toUpperCase();

  static DeliveryStatus fromJson(String value) {
    try {
      return DeliveryStatus.values.firstWhere(
        (e) => e.name.toUpperCase() == value.toUpperCase(),
      );
    } catch (_) {
      return DeliveryStatus.pending;
    }
  }
}