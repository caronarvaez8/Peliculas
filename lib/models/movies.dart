class Movies {
  String? logo_path;
  String? name;

  Movies({this.logo_path, this.name});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(logo_path: json['logo_path'], name: json['name']);
  }
}