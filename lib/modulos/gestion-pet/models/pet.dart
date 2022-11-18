class Pet {
   int? id;
   String? type;
   String? name;
   String? attention;
   int? age;
   String? race;
   bool? isAdopted = false;
   int? userId;
   int? publicationId;
   bool? isPublished = false;
   String? gender;
   String? urlToImage;

  Pet.empty();
  Pet(this.id,this.type, this.name, this.attention, this.age, this.race, this.userId, this.publicationId, this.gender, this.urlToImage,this.isAdopted, this.isPublished);

  factory Pet.fromJson(Map<String, dynamic> json){
    return Pet(
      json['id'],
      json['type'],
      json['name'],
      json['attention'],
      json['age'],
      json['race'],
      json['userId'],
      json['publicationId'],
      json['gender'],
      json['urlToImage'],
      json['isAdopted'],
      json['isPublished']
    );
  }

}

