import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chaofan/api/api.dart';
import 'package:flutter_chaofan/config/color.dart';

import 'package:flutter_chaofan/config/index.dart';
import 'package:flutter_chaofan/utils/http_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SaveAddPage extends StatefulWidget {
  _SaveAddPageState createState() => _SaveAddPageState();
}

class _SaveAddPageState extends State<SaveAddPage> {
  String version;
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: KColor.defaultGrayColor,
              size: 20,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(bottom: 12, top: 12, right: 20),
            // width: ScreenUtil().setWidth(140),
            // height: ScreenUtil().setWidth(20),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                if (_inputController.text.trim().isNotEmpty) {
                  var res = await HttpUtil().get(Api.addSaveFolder,
                      parameters: {'name': _inputController.text});
                  // print(res);
                  if (res['success']) {
                    Fluttertoast.showToast(
                      msg: '新增收藏夹成功',
                      gravity: ToastGravity.CENTER,
                    );
                    Future.delayed(Duration(milliseconds: 1500)).then((e) {
                      Navigator.pop(context, res['data']['id'].toString());
                    });
                  }
                }
              },
              child: Text(
                '创建',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Color.fromRGBO(53, 140, 255, 1),
                ),
              ),
            ),
          )
        ],
        brightness: Brightness.light,
        title: Text(
          '创建收藏夹',
          style:
              TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(34)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              // focusNode: _commentFocus,

              autofocus: true,
              controller: _inputController,
              maxLines: 2,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                fillColor: Color(0x30cccccc),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x00FF0000)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: '请输入收藏夹名称（20字以内）',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              textInputAction: TextInputAction.send,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                // fontWeight: FontWeight.bold,
              ),
              onChanged: (val) {
                print('旧值');
              },

              onSubmitted: (term) async {
                print(term);
              },
            ),
          ),
        ],
      ),
    );
  }
}
