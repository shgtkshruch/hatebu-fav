url = require 'url'
async = require 'async'

moment = require 'moment'

moment.locale 'jp',
  relativeTime:
    past: '%s'
    s: '秒'
    m: '1分'
    mm: '%d分'
    h: '1時間'
    hh: '%d時間'
    d: '昨日'
    dd: '%d日'

bookmarkNum = 0
username = ''

$container = $ '#feed'
template = _.template $('#item').text()

google.load 'feeds', '1'

getApi = (bookmarkNum) ->
  return 'http://b.hatena.ne.jp/' + username + '/favorite.rss' + '?of=' + bookmarkNum

getFeed = (feed) ->
  feed.setNumEntries 25
  feed.load (result) ->
    if !result.error
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
                favicon: 'http://www.google.com/s2/favicons?domain=' + url.parse(entry.link).host
                time: moment(entry.publishedDate).fromNow()
                text: entry.contentSnippet
                bookmarkCount: bookmarkCount
              $container.append template item
              cb null
        ], (err, results) ->
          console.log err if err
          cb1()
      , (err) ->
        console.log err if err

$ '#next'
  .click (e) ->
    bookmarkNum += 25
    api = getApi bookmarkNum
    feed = new google.feeds.Feed api
    getFeed feed

$ '#submit'
  .click (e) ->
    e.preventDefault()

    $container.empty()

    username = $('#username').val()
    api = getApi 0
    feed = new google.feeds.Feed api
    getFeed feed
