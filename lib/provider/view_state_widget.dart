import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        size: 30,
      ),
    );
  }
}

// 搜索页面空
class SearchViewStateEmptyWidget extends StatelessWidget {
  final VoidCallback onPressed;
  SearchViewStateEmptyWidget({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  bottom: ScreenUtil.getInstance().setHeight(82),
                  top: ScreenUtil.getInstance().setWidth(212)),
              child: SingleChildScrollView(
                child: Image(
                  image: AssetImage('assets/images/search_noData.png'),
                  width: ScreenUtil.getInstance().setWidth(282),
                  height: ScreenUtil.getInstance().setHeight(176),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              '没有找到相关结果，换个关键字试试吧~',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(26),
                  color: Color(0xffb6b6b6)),
            ),
          ],
        ),
      ),
    );
  }
}

// 错误页面
class ViewStateErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ViewStateErrorWidget({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Image(
                    image: AssetImage('assets/images/error_page.png'),
                    width: ScreenUtil.getInstance().setWidth(290),
                    height: ScreenUtil.getInstance().setHeight(266),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // Text('网路错误或无法连接，点击屏幕重试', textAlign: TextAlign.center ,style:TextStyle(fontSize: 12, color: Color(0xffcccccc)))
            ],
          ),
        ),
      ),
    );
  }
}

// 页面空
class NormalViewStateEmptyWidget extends StatelessWidget {
  final VoidCallback onPressed;
  NormalViewStateEmptyWidget({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  bottom: ScreenUtil.getInstance().setHeight(82),
                  top: ScreenUtil.getInstance().setWidth(212)),
              child: SingleChildScrollView(
                child: Image(
                  image: AssetImage('assets/images/no-data.png'),
                  width: ScreenUtil.getInstance().setWidth(290),
                  height: ScreenUtil.getInstance().setHeight(266),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}