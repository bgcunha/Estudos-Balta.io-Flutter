class Item {
  String title = '';
  bool done = false;

  // ignore: non_constant_identifier_names
  Item({title, done}) {
    this.title = title;
    this.done = done;
  }

  Item.fromJason(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJason() {
    var data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = done;
    return data;
  }
}
