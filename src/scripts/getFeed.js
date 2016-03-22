import $ from 'jquery';
import _ from 'underscore';
import async from 'async';
import moment from './momentJa';

var $container = $('#feed');
var itemTemplate = _.template($('#item-template').text());

export default (feed) => {
  feed.setNumEntries(25);
  feed.load(result => {
    // エラーならエラーメッセージを出して終了
    if (result.error) {
      $container.append('<p class="item_noitem">フィードが取得できませんでした</p>');
      return;
    }

    // 各アイテムのブックマーク数を取得してアイテムを描画
    async.each(result.feed.entries, (entry, cb1) => {
      async.waterfall([
        cb => {
          $.ajax({
            url: 'http://api.b.st-hatena.com/entry.count?url=' + entry.link,
            dataType: 'jsonp',
            success: (bookmarkCount, status, xhr) => {
              cb(null, bookmarkCount);
            },
          })
        }, (bookmarkCount, cb) => {
          var item = {
            author: entry.author,
            authorImg: 'http://cdn1.www.st-hatena.com/users/st/' + entry.author + '/profile.gif',
            title: entry.title,
            link: entry.link,
            favicon: 'http://www.google.com/s2/favicons?domain=' + entry.link,
            time: moment(new Date(entry.publishedDate)).fromNow(),
            bookmarkCount: bookmarkCount
          };
          $container.append(itemTemplate(item));
          cb(null);
        }
      ], (err, results) => {
        if (err) {
          console.log(err);
        }
      });
    }, err => {
      if (err) {
        console.log(err);
      }
    });
  });
};
