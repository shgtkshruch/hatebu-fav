$ = require 'jquery'
async = require 'async'
moment = require './momentJa.coffee'
_ = require 'underscore'

module.exports = ->
  $comment = $ '#comment'
  commentTemplate = _.template $('#comment-template').text()

  $ '#feed'
    .on 'click', '.js-bookmarkCount', (e) ->
      url = $(@).data 'url'
      offset = $(@).offset().top - 10
      $.ajax
        url: 'http://b.hatena.ne.jp/entry/jsonlite/?url=' + url
        dataType: 'jsonp'
        success: (bookmarkEntries, status, xhr) ->
          $comment.empty()

          if bookmarkEntries is null
            $comment.css
              top: offset
            $comment.append '<p class="comment__nocomment">コメントがありませんでした。</p>'
            return

          async.each bookmarkEntries.bookmarks, (bookmark, cb) ->
            # コメントが無いものは非表示
            if bookmark.comment.length is 0
              cb()
              return

            item =
              author: bookmark.user
              text: bookmark.comment
              date: moment(new Date(bookmark.timestamp)).fromNow()
              icon: 'http://cdn1.www.st-hatena.com/users/st/' + bookmark.user + '/profile.gif'

            $comment.append commentTemplate item
            cb()
          , (err) ->
            $comment.css
              top: offset
            if $comment.children().length is 0
              $comment.append '<p class="comment__nocomment">コメントがありませんでした。</p>'

