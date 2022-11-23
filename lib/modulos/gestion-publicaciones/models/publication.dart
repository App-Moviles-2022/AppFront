import 'dart:ui';

class Publication {
  int publicationId;
  int petId;
  int userId;
  String type;
  String name;
  String image;
  String comment;

  Publication(this.publicationId, this.petId, this.userId, this.type, this.image, this.name, this.comment);

}

class AdoptionRequest {
  int userIdFrom;
  int userIdAt;
  int publicationId;
  String message;
  int status;

  AdoptionRequest(this.userIdFrom, this.userIdAt, this.publicationId, this.message, this.status);
}