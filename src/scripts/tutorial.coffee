$ = require 'jquery'
shepherd = require 'tether-shepherd'

module.exports = ->
  $username = $ '#username'
  $submit = $ '#submit'
  $ '#tutorialBtn'
    .click (e) ->
      $username.val 'sh19e'
      $submit.click()
      setTimeout ->
        $ '.item:first-child .js-bookmarkCount'
          .click()
      , 1000

      tour = new shepherd.Tour
        defaults:
          classes: 'shepherd-theme-arrows'

      tour
        .addStep 'username',
          text: ['はてなブックマークの', 'アカウント名を', '入力してください']
          attachTo: '#username top'
          buttons: [
            {
              text: 'Next'
              action: tour.next
            }
          ]
        .addStep 'submit',
          text: '決定ボタンを押してください'
          attachTo: '#submit top'
          buttons: [
            {
              text: 'Back'
              classes: 'shepherd-button-secondary'
              action: tour.back
            }, {
              text: 'Next'
              action: tour.next
            }
          ]
        .addStep 'readArticle',
          text: ['記事を読むには', 'ここをクリックしてください']
          attachTo: '.item__link bottom'
          buttons: [
            {
              text: 'Back'
              classes: 'shepherd-button-secondary'
              action: tour.back
            }, {
              text: 'Next'
              action: tour.next
            }
          ]
        .addStep 'readComment',
          text: ['ブックマークコメントを読むには、', 'ここをクリックしてください']
          attachTo: '.js-bookmarkCount left'
          buttons: [
            {
              text: 'Back'
              classes: 'shepherd-button-secondary'
              action: tour.back
            }, {
              text: 'Done'
              action: tour.next
            }
          ]
        .start()
