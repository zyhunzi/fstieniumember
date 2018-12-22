import 'dart:convert';
class FSUser {
  final String uid;
  final String userName;
  final String icon;
  final String dptId;
  FSUser(this.uid, {this.userName, this.icon, this.dptId});

  String toJson(){
    Map<String, dynamic> jsonModel = {
      "uid": uid,
      "username": userName,
      "icon": icon,
      "dptid": dptId,
    };
    return jsonEncode(jsonModel);
  }

  factory FSUser.fromJson(Map<String, dynamic> json) {
    String s0 = '';
    String s1 = '';
    String s2 = '';
    String s3 = '';
    if (json['uid'] != null) {
      s0 = json['uid'].toString().trim();
    }
    if (json['nickname'] != null) {
      s1 = json['nickname'].toString().trim();
    } else if (json['username'] != null) {
      s1 = json['username'].toString().trim();
    }
    if (json['icon'] != null) {
      s2 = json['icon'].toString().trim();
    }
    if (json['dptid'] != null) {
      s3 = json['dptid'].toString().trim();
    }
    //print("s0:$s0,s1:$s1,s2:$s2,s3:$s3");
    FSUser fsUser = FSUser(s0, userName: s1, icon: s2, dptId: s3);
    return fsUser;
  }
}
