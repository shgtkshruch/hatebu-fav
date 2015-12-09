$ = require 'jquery'

getApi = require './getApi.coffee'
getFeed = require './getFeed.coffee'

module.exports = ->

  google.load 'feeds', '1'

  $ '#submit'
    .click (e) ->
      e.preventDefault()

      $('#feed, #comment').empty()

      window.hbr.bookmarkNum = 0
      window.hbr.username = $('#username').val()
      api = getApi window.hbr.bookmarkNum
      feed = new google.feeds.Feed api
      getFeed feed

