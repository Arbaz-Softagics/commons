class Data {
  final int id;
  final String title;
  bool selected;

  Data(this.id, this.title, this.selected);

  @override
  bool operator ==(Object other) {
    return (identical(this, other) ||
        other is Data &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title);
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return title;
  }
}

class SimpleItem extends Data {
  @override
  int id;
  @override
  String title;
  @override
  bool selected;
  final String remarks;

  SimpleItem(this.id, this.title, {this.selected = false, this.remarks = ""})
      : super(id, title, selected);

  factory SimpleItem.fromJson(Map<String, dynamic> json) {
    return SimpleItem(
      int.parse(json['id'].toString()),
      json['title'],
      remarks: json.containsKey('remarks') ? json['remarks'] : "",
    );
  }
}
