module.exports = (bookmarkNum) ->
  return 'http://b.hatena.ne.jp/' + window.hbr.username + '/favorite.rss' + '?of=' + bookmarkNum
