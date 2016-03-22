import $ from 'jquery';
import getApi from './getApi';
import getFeed from './getFeed';

export default () => {
  google.load('feeds', '1');

  $('#submit').click(e => {
    e.preventDefault();

    $('#feed, #comment').empty();

    // 取得するブックマーク数とユーザー名を初期化
    window.hbr.bookmarkNum = 0;
    window.hbr.username = $('#username').val();

    // フィードを取得して描画
    var api = getApi();
    var feed = new google.feeds.Feed(api);
    getFeed(feed);
  });
};
