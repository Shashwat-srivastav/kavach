// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyGaurd {
  static List<gaurdian> details = [];
}

class MyHospital {
  static List<hospital> details = [];
}

class MyPolice {
  static List<police> details = [];
}

class police {
  String name;
  int contact;
  String url;
  police({
    required this.name,
    required this.contact,
    required this.url,
  });

  police copyWith({
    String? name,
    int? contact,
    String? url,
  }) {
    return police(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contact': contact,
      'url': url,
    };
  }

  factory police.fromMap(Map<String, dynamic> map) {
    return police(
      name: map['name'] as String,
      contact: map['contact'] as int,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory police.fromJson(String source) =>
      police.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'police(name: $name, contact: $contact, url: $url)';

  @override
  bool operator ==(covariant police other) {
    if (identical(this, other)) return true;

    return other.name == name && other.contact == contact && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ contact.hashCode ^ url.hashCode;
}

class hospital {
  String name;
  int contact;
  String url;
  hospital({
    required this.name,
    required this.contact,
    required this.url,
  });

  hospital copyWith({
    String? name,
    int? contact,
    String? url,
  }) {
    return hospital(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contact': contact,
      'url': url,
    };
  }

  factory hospital.fromMap(Map<String, dynamic> map) {
    return hospital(
      name: map['name'] as String,
      contact: map['contact'] as int,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory hospital.fromJson(String source) =>
      hospital.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'hospital(name: $name, contact: $contact, url: $url)';

  @override
  bool operator ==(covariant hospital other) {
    if (identical(this, other)) return true;

    return other.name == name && other.contact == contact && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ contact.hashCode ^ url.hashCode;
}

class gaurdian {
  String name;
  int contact;
  String mail;
  int age;
  gaurdian({
    required this.name,
    required this.contact,
    required this.mail,
    required this.age,
  });

  gaurdian copyWith({
    String? name,
    int? contact,
    String? mail,
    int? age,
  }) {
    return gaurdian(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      mail: mail ?? this.mail,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contact': contact,
      'mail': mail,
      'age': age,
    };
  }

  // factory gaurdian.fromMap(Map<String, dynamic> map) {
  //   return gaurdian(
  //     name: String.fromMap(map['name'] as Map<String, dynamic>),
  //     contact: int.fromMap(map['contact'] as Map<String, dynamic>),
  //     mail: String.fromMap(map['mail'] as Map<String, dynamic>),
  //     age: int.fromMap(map['age'] as Map<String, dynamic>),
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory gaurdian.fromJson(String source) =>
      gaurdian.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'gaurdian(name: $name, contact: $contact, mail: $mail, age: $age)';
  }

  @override
  bool operator ==(covariant gaurdian other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.contact == contact &&
        other.mail == mail &&
        other.age == age;
  }

  @override
  int get hashCode {
    return name.hashCode ^ contact.hashCode ^ mail.hashCode ^ age.hashCode;
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'name': name,
  //     'contact': contact,
  //     'mail': mail,
  //     'age': age,
  //   };
  // }

  factory gaurdian.fromMap(Map<String, dynamic> map) {
    return gaurdian(
      name: map['name'] as String,
      contact: map['contact'] as int,
      mail: map['mail'] as String,
      age: map['age'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory gaurdian.fromJson(String source) =>
  //     gaurdian.fromMap(json.decode(source) as Map<String, dynamic>);
}
