steady = require 'steady'

getApi = require './getApi.coffee'
getFeed = require './getFeed.coffee'

module.exports = ->
  new steady
    conditions:
      'max-bottom': 500
    throttle: 200
    handler: (values, done) ->
        window.hbr.bookmarkNum += 25
        api = getApi window.hbr.bookmarkNum
        feed = new google.feeds.Feed api
        getFeed feed
        done()
