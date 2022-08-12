/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月25日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import Vue from 'vue';
import moment from 'moment';
import Decimal from 'decimal.js';

const FormatNum = function (f, digit = 2) {
	let m = Math.pow(10, digit);
	let des = f * m + 0.5;
	return parseInt(des, 10) / m;
};

const toFixed = function (num, s) {
	return Decimal(num).toFixed(s);
};

Vue.filter("dxMoney", (n) => {
	if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n) || n == 0) {
		return "";
	}

	let unit = "仟佰拾亿仟佰拾万仟佰拾元角分", str = "";
	n += "00";
	let p = n.indexOf('.');
	if (p >= 0) {
		n = n.substring(0, p) + n.substr(p + 1, 2);
	}
	unit = unit.substr(unit.length - n.length);
	for (let i = 0; i < n.length; i++) {
		str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
	}

	return str.replace(/零(仟|佰|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
});

Vue.filter("fqFormat", (n) => {
	if (!n) {
		return ''
	}
	return moment(n).format("YYYY年第MM期");
});

Vue.filter("moneyFormat", (n) => {
	if (!n) {
		return '0'
	}
	let num = Math.abs(n);
	if (num < 10000) {
		return n;
	} else if (num >= 10000 && num < 100000000) {
		return FormatNum(n / 10000) + "万";
	} else {
		return FormatNum(n / 100000000, 4) + "亿";
	}
});

Vue.filter("numFormat", (number) => {
	if (!number) {
		return ''
	}
	/*
　　 * 参数说明：
　　 * number：要格式化的数字
　　 * decimals：保留几位小数
　　 * dec_point：小数点符号
　　 * thousands_sep：千分位符号
　　 * */
	number = (number + '').replace(/[^0-9+-Ee.]/g, '');
	let n = !isFinite(+number) ? 0 : +number, prec = 2, sep = ',', dec = '.', s = '';

	s = (prec ? toFixed(n, prec) : '' + Math.round(n)).split('.');

	let re = /(-?\d+)(\d{3})/;
	while (re.test(s[0])) {
		s[0] = s[0].replace(re, "$1" + sep + "$2");
	}
	if ((s[1] || '').length < prec) {
		s[1] = s[1] || '';
		s[1] += new Array(prec - s[1].length + 1).join('0');
	}
	return s.join(dec);
});