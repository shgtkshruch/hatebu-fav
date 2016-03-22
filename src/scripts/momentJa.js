import moment from 'moment';

moment.locale('jp', {
  relativeTime: {
    past: '%s',
    s: '秒',
    m: '1分',
    mm: '%d分',
    h: '1時間',
    hh: '%d時間',
    d: '昨日',
    dd: '%d日',
    M: '1ヶ月',
    MM: '%dヶ月',
    y: '1年',
    yy: '%d年'
  }
});

export default moment;
