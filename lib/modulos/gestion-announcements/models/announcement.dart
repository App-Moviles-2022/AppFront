
class Announcement{
  final int id;
  final String dateTime;
  final String title;
  final String description;
  final int discount;
  final String urlToImage;
  final bool promoted;
  Announcement({
    required this.id,
    required this.dateTime,
    required this.description,
    required this.promoted,
    required this.discount,
    required this.title,
    required this.urlToImage,
  });
}