// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//         "id": 1,
//         "filePath": "/home/sajak/Downloads/bb.pdf"
//     }
class FileModel {
  int? id;
  String? filePath;
  FileModel({this.id, this.filePath});

  FileModel copyWith({int? id, String? filePath}) {
    return FileModel(id: id ?? this.id, filePath: filePath ?? this.filePath);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'filePath': filePath};
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      id: map['id'] != null ? map['id'] as int : null,
      filePath: map['filePath'] != null ? map['filePath'] as String : null,
    );
  }

  @override
  String toString() => 'FileModel(id: $id, filePath: $filePath)';
}
