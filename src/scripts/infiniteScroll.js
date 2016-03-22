import steady from 'steady';
import getApi from './getApi';
import getFeed from './getFeed';

export default () => {
  new steady({
    conditions: {
      'max-bottom': 500
    },
    throttle: 200,
    handler: (values, done) => {
      // 取得するブックマークの位置を調整
      window.hbr.bookmarkNum += 25;

      // フィードを取得して描画
      var api = getApi();
      var feed = new google.feeds.Feed(api);
      getFeed(feed);
      done();
    }
  });
};
