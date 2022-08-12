/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
const apis = require.context('.', false, /.*\.js$/);

let apiObj = {};

apis.keys().forEach(fileName => {
	if (fileName !== './index.js') {
		const name = fileName.substring(2, fileName.lastIndexOf('.'))
		apiObj[name] = apis(fileName).default;
	}
});

export default apiObj;
