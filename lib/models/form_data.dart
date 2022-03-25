


class FormModel {
    FormModel({
        required this.title,
    });

    String title;

    
    factory FormModel.fromMap(Map<String, dynamic> json) => FormModel(
        title: json['title'] as String,
    );

     Map<String, dynamic> toMap() => <String,dynamic>{ 
        'title': title,
    };
}
