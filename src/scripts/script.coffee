bookmarkNum = 0
username = ''

$container = $ '#feed'

google.load 'feeds', '1'

getApi = (bookmarkNum) ->
  return 'http://b.hatena.ne.jp/' + username + '/favorite.rss' + '?of=' + bookmarkNum

getFeed = (feed) ->
  feed.setNumEntries 25
  feed.load (result) ->
    if !result.error
      i = 0
      while i < result.feed.entries.length
        entry = result.feed.entries[i]
        $div = $ '<div class="item"></div>'
        $div.append entry.title
        $container.append $div
        i++

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
