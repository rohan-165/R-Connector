// ignore_for_file: public_member_api_docs, sort_constructors_first
// "data": {
//         "version": {
//             "name": "ROI Version",
//             "version": "v1.0",
//             "release_notes": "release notes"
//         }
//     }

class AppVersionModel {
  String? name;
  String? version;
  String? releaseNotes;
  AppVersionModel({this.name, this.version, this.releaseNotes});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    version = json['version'] as String?;
    releaseNotes = json['release_notes'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['version'] = version;
    data['release_notes'] = releaseNotes;
    return data;
  }
}
