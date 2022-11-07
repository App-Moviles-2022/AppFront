
class Announcement{
  final String dateTime;
  final String title;
  final String description;

  final String urlToImage;
  final bool promoted;
  Announcement({
    required this.dateTime,
    required this.description,
    required this.promoted,
    required this.title,
    required this.urlToImage
  });
}