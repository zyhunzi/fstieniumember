import 'package:fstieniumember/fsconfig.dart' show Constant;

class FsRoom {
  ///编号
  final String Id;

  ///名称
  final String Name;

  ///描述
  final String Des;

  ///图标
  final String Icon;

  ///门市价
  final String Price0;

  ///会员价
  final String Price1;

  FsRoom({this.Id, this.Name, this.Des, this.Icon, this.Price0, this.Price1});

  factory FsRoom.fromJson(Map<String, dynamic> json) {
    String s0 = '';
    String s1 = '';
    String s2 = '这是描述';
    String s3 ='https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=212265960,58484461&fm=27&gp=0.jpg';
    String s4 = '262';
    String s5 = '199';
    if (json['id'] != null) {
      s0 = json['id'].toString().trim();
    }
    if (json['name'] != null) {
      s1 = json['name'].toString().trim();
    }
    //print("NNNN_extpros:${json["extpros"]}");
    if (json["extpros"] != null) {
      List jsonc = json["extpros"];
      for (Map<String, dynamic> element in jsonc) {
        if (element["name"] != null) {
          if (element["name"] == "门市价") {
            s4 = element["value"].toString().trim();
          } else if (element["name"] == "会员价") {
            s5 = element["value"].toString().trim();
          } else if (element["name"] == "描述") {
            s2 = element["value"].toString().trim();
          } else if (element["name"] == "促销图片") {
            if (element["value"] != null) {
              List<String> imgs = element["value"].split(";");
              if (imgs.length > 0) {
                s3 = "${Constant.ImagePath}${imgs[0]}";
              }
            }
          }
        }
      }
    }
    if(s2.length > 15){
      s2=s2.substring(0,15);
    }
    FsRoom fsRoom = FsRoom(Id: s0, Name: s1, Des: s2, Icon: s3, Price0: s4, Price1: s5);
    return fsRoom;
  }
}
