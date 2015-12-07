api = 'http://b.hatena.ne.jp/sh19e/favorite.rss'

google.load 'feeds', '1'

initialize = ->
  feed = new google.feeds.Feed api
  feed.setNumEntries 25
  feed.load (result) ->
    if !result.error
      console.log result
      $container = $ '#feed'
      i = 0
      while i < result.feed.entries.length
        entry = result.feed.entries[i]
        $div = $ '<div></div>'
        $div.append entry.title
        $container.append $div
        i++

google.setOnLoadCallback initialize
