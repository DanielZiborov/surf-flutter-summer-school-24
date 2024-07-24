class PhotoEntity {
  final String id;
  final String url;
  final DateTime? createdAt;

  const PhotoEntity(
    {
      required this.id,
      required this.url,
      required this.createdAt,
    }
  );

  String get getId => id;
  String get getUrl => url;
  DateTime? get getCreatedAt => createdAt;

  String get formattedCreatedAt {
    if (createdAt != null) {
      return "${createdAt!.day.toString().padLeft(2, '0')}.${createdAt!.month.toString().padLeft(2, '0')}.${createdAt!.year}";
    }
    return "Неизвестная дата";
  }
}