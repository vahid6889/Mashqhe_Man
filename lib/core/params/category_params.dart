class CategoryParams {
  int? id;
  String? name;
  String? nameFa;
  int? color;
  int? icon;

  CategoryParams({
    this.id,
    this.name,
    this.nameFa,
    this.color,
    this.icon,
  });

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   // map[color.toString()] = {
  //   //   'name': name,
  //   //   'nameFa': nameFa,
  //   //   'color': color,
  //   // };
  //   map['name'] = name;
  //   map['nameFa'] = nameFa;
  //   map['color'] = color;
  //   return map;
  // }
}
