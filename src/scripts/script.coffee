bookmarkNum = 0

google.load 'feeds', '1'

getApi = (bookmarkNum) ->
  return 'http://b.hatena.ne.jp/sh19e/favorite.rss' + '?of=' + bookmarkNum

initialize = ->
  api = getApi bookmarkNum

  feed = new google.feeds.Feed api

  getFeed feed

getFeed = (feed) ->
  feed.setNumEntries 25
  feed.load (result) ->
    if !result.error
      $container = $ '#feed'
      i = 0
      while i < result.feed.entries.length
        entry = result.feed.entries[i]
        $div = $ '<div></div>'
        $div.append entry.title
        $container.append $div
        i++

google.setOnLoadCallback initialize

$ '#next'
  .click (e) ->
    bookmarkNum += 25
    api = getApi bookmarkNum

    feed = new google.feeds.Feed api

    getFeed feed
