import $ from 'jquery';
import async from 'async';
import _ from 'underscore';
import moment from './momentJa';

export default () => {
  var $comment = $('#comment');
  var commentTemplate = _.template($('#comment-template').text());

  // ブックマーク数をクリックしたらコメントを表示
  // thisがundefindになるので、アローファンクションを使わない
  $('#feed').on('click', '.js-bookmarkCount',  function (e) {
    var url = $(this).data('url');
    var offset = $(this).offset().top - 10;

    $.ajax({
      url: 'http://b.hatena.ne.jp/entry/jsonlite/?url=' + url,
      dataType: 'jsonp',
      success: (bookmarkEntries, status, xhr) => {
        $comment.empty();

        //　コメントが無かったらメッセージを出して終了
        if (bookmarkEntries === null) {
          $comment.css({
            top: offset
          }).append('<p class="comment__nocomment">コメントがありませんでした。</p>');
          return;
        }

        // ブックマークを表示
        async.each(bookmarkEntries.bookmarks, (bookmark, cb) => {
          // コメントが無いものは非表示
          if (bookmark.comment.length === 0) {
            cb();
            return;
          }

          var item = {
            author: bookmark.user,
            text: bookmark.comment,
            date: moment(new Date(bookmark.timestamp)).fromNow(),
            icon: 'http://cdn1.www.st-hatena.com/users/st/' + bookmark.user + '/profile.gif'
          };
          $comment.append(commentTemplate(item));
          cb();
        }, err => {
          $comment.css({
            top: offset
          });

          // 無言コメントしかなかったらメッセージを表示
          if ($comment.children().length === 0) {
            $comment.append('<p class="comment__nocomment">コメントがありませんでした。</p>');
          }
        });
      }
    });
  });
};
