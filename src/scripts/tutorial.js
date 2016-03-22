import $ from 'jquery';
import shepherd from 'tether-shepherd';

export default () => {
  $('#tutorialBtn').click(e => {
    // ユーザー名を指定してフォームをサブミット
    $('#username').val('sh19e');
    $('#submit').click();

    // 最初のアイテムのブックマークコメントを表示
    setTimeout(function () {
      $('.item:first-child .js-bookmarkCount').click();
    }, 1000);

    var tour = new shepherd.Tour({
      defaults: {
        classes: 'shepherd-theme-arrows'
      }
    });

    tour.addStep('username', {
      text: ['はてなブックマークの', 'アカウント名を', '入力してください。'],
      attachTo: '#username top',
      buttons: [
        {
          text: 'Next',
          action: tour.next
        }
      ]
    }).addStep('submit', {
      text: '決定ボタンを押してください。',
      attachTo: '#submit top',
      buttons: [
        {
          text: 'Back',
          classes: 'shepherd-button-secondary',
          action: tour.back
        }, {
          text: 'Next',
          action: tour.next
        }
      ]
    }).addStep('readArticle', {
      text: ['記事を読むには', 'ここをクリックしてください。'],
      attachTo: '.item__link bottom',
      buttons: [
        {
          text: 'Back',
          classes: 'shepherd-button-secondary',
          action: tour.back
        }, {
          text: 'Next',
          action: tour.next
        }
      ]
    }).addStep('readComment', {
      text: ['ブックマークコメントを読むには、', 'ここをクリックしてください。'],
      attachTo: '.js-bookmarkCount left',
      buttons: [
        {
          text: 'Back',
          classes: 'shepherd-button-secondary',
          action: tour.back
        }, {
          text: 'Done',
          action: tour.next
        }
      ]
    }).start();
  })
};
