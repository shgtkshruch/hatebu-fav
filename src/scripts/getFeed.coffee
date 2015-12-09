$ = require 'jquery'
_ = require 'underscore'
async = require 'async'
moment = require './momentJa.coffee'

$container = $ '#feed'
itemTemplate = _.template $('#item-template').text()

module.exports = (feed) ->
  feed.setNumEntries 25
  feed.load (result) ->
    if result.error
      $container.append '<p class="item__noitem">フィードが取得できませんでした</p>'
      return

    async.each result.feed.entries, (entry, cb1) ->
      async.waterfall [
        (cb) ->
          $.ajax
            url: 'http://api.b.st-hatena.com/entry.count?url=' + entry.link
            dataType: 'jsonp'
            success: (bookmarkCount, status, xhr) ->
              cb null, bookmarkCount
        , (bookmarkCount, cb) ->
            item =
              author: entry.author
              authorImg: 'http://cdn1.www.st-hatena.com/users/st/' + entry.author + '/profile.gif'
              title: entry.title
              link: entry.link
              favicon: 'http://www.google.com/s2/favicons?domain=' + entry.link
              time: moment(new Date(entry.publishedDate)).fromNow()
              bookmarkCount: bookmarkCount
            $container.append itemTemplate item
            cb null
      ], (err, results) ->
        console.log err if err
        cb1()
    , (err) ->
      console.log err if err

