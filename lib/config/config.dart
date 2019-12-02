// rapMode 0-不拦截  1 - 拦截全部   2 - 黑名单的项不拦截  3-仅拦截白名单中的项
enum Env {
  PROD,
  DEV,
  TEST,
  PRE
}

Map rapConfig = {
  'rapUrl': 'http://rap.daily.feibo.cc/mockjsdata/45/',
  'rapMode': 0,
  'rapWhiteList': ['message/unread', 'comment/forward', 'message/notification/readed', 'message/interaction/readed', 'topic','topic/videoList','video/explore/recommend','video/explore/hot','topic/explore/recommend' ,'replyComments', 'comment','classification/followState' ,'classification/video' ,'classification/tags', 'recommend/dissertation', 'dissertation/sampler','dissertation/list', 'explore/recommend/hot','explore/recommend/content', 'classification/list','dissertation/recommend', 'search/hot/keyword', 'search/video', 'search/user', 'search/dissertation', 'search/topic', 'search/classification', 'user/dissertation', 'user/topic', 'user/classification', 'classification/attention', 'topic/attention', 'dissertation/attention', 'explore/recommend/topic'],
  'rapBlackList': [],
  'rapFilterHeaders': [],
  'rapFilterMethods': []
};

class Config {
  static Env env;

  static Map get apiHost {
    switch(env) {
      case Env.DEV:
        return {
          'baseUrl': 'http://10.0.1.55:8080/',
          'rapConfig': rapConfig
        };
      // case Env.DEV:
      //   return {
      //     'baseUrl': 'http://192.168.31.234:9000/',
      //     'shareUrl': 'http://test.share.explosive.feibo.cc/',
      //     'rapConfig': rapConfig
      //   };
      case Env.TEST:
        return {
          'baseUrl': 'http://test.api.explosive.feibo.cc/',
          'shareUrl': 'http://test.share.explosive.feibo.cc/',
          'rapConfig': rapConfig
        };
      case Env.PRE:
        return {
          'baseUrl': 'http://pre.api.explosive.feibo.com/',
          'shareUrl': 'http://pre.share.explosive.feibo.com/',
          'rapConfig': rapConfig
        };
      case Env.PROD:
        return {
          'baseUrl': 'http://api.explosive.feibo.com/',
          'shareUrl': 'http://pre.share.explosive.feibo.com/',
          'rapConfig': rapConfig
        };
      default:
        return {
          'baseUrl': 'http://10.0.1.55:8080/',
          'shareUrl': 'http://test.share.explosive.feibo.cc/',
          'rapConfig': rapConfig
        };
    }
  }
  
  static Map get qiniu {
    return {
      'UPLOAD_QINIU_URL': 'http://upload.qiniup.com',
      'BUCKET_QINIU_POST': 'http://res.explosive.feibo.com/'
    };
  }
}