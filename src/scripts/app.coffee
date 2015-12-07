url = require 'url'

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

        console.log entry

        compiled = _.template $('#item').text()
        item =
          author: entry.author
          authorImg: 'http://cdn1.www.st-hatena.com/users/st/' + entry.author + '/profile.gif'
          title: entry.title
          link: entry.link
          favicon: 'http://www.google.com/s2/favicons?domain=' + url.parse(entry.link).host
          text: entry.contentSnippet
        $container.append compiled item

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
