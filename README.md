## 文件结构
```shell
.
├── android 这里存放的是Flutter与android原生交互的一些代码，这个路径的文件和创建单独的Android项目的基本一样的。不过里面的代码配置跟单独创建Android项目有些不一样。
├── assets 图片、动画、字体等资源文件
   └── animations
   ├── fonts
   ├── images
├── build  项目构建相关
├── ios 这里存放的是Flutter与ios原生交互的一些代码
├── pubspec.yaml 这个是配置依赖项的文件，比如配置远程pub仓库的依赖库，或者指定本地资源（图片、字体、音频、视频等）。
├── test 测试文件
└── lib
    ├── config  项目全局配置
        ├── net  网络请求相关
           └── http.dart 对dio进行封装，进行请求拦截
           ├── rap.dart rap拦截逻辑
        ├──config.dart rap 和 环境配置
        ├── main_dev.dart 本地环境编译入口
        ├── main_pre.dart 预发环境编译入口
        ├── main_prod.dart 生产环境编译入口
        ├── main_test.dart  测试环境编译入口
        ├── provider_manager.dart  全局provider 管理
        ├── router_manager.dart 路由管理
    ├── model  实体类
    ├── provider  对provider的封装
        ├── provider_widget.dart Provider封装类 方便数据初始化
        ├── view_refresh_list_model.dart  对下拉列表的通用逻辑封装
        ├── view_state_model.dart 页面请求状态
        ├── view_state_widget.dart 所有页面状态的widget
        ├── view_state.dart 页面状态类型
    ├── service  http的api相关
    ├── ui  
        ├── helper 辅助类ui
        ├── page 页面
            ├── tab 底部导航栏相关的页面
            ├── user 用户相关的页面 如登录 登出页面
            ... 其他页面
        ├── widget 组件
    ├── utils  通用方法
    ├── view_model 以provider为基础的页面逻辑
    ├── main.dart 入口文件
```
## 这里能找到什么？
1. Provider状态管理的最佳实践，虽然Google很早就废弃了Provide，宣布Provider为推荐的状态管理工具，可是在开发中，我们总是会遇到很多问题。
    1. 比如Provider的几个衍生类在具体的业务中应该怎么使用？
    2. 页面最初需要的数据什么时候进行初始化,在哪里初始化。
    3. 如何将页面的几个常用状态loading、error、empty、idle、unAuthorized进行组合使用。
    4. 常用的下拉刷新，上拉加载更多应如何服用才能效果更佳。
    5. Widget在dispose后，model不再notify()。
2. 清晰的代码结构
    1. 让页面归页面，让业务归业务，所有的业务逻辑都在view_model中，Widget只关注页面本身。
3. 不要再满屏幕的setState()。
    1. 同一页面内可以利用Flutter框架给我们提供的各种XxxBuilder,来局部刷新。
    2. 多层嵌套可使用前边提到的Provider。
    3. 当然颗粒度足够细的Widget，还是要使用setState()


