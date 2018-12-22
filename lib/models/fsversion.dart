class FSVersion {
  final String version;
  final String filepath;

  FSVersion({this.version, this.filepath});

  factory FSVersion.fromJson(Map<String, dynamic> json) {
    return FSVersion(
      version: json['version'],
      filepath: json['filepath'],
    );
  }
}
