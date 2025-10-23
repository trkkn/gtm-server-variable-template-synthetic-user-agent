___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Synthetic User Agent",
  "description": "",
  "containerContexts": [
    "SERVER"
  ]
}
___NOTES___



Created on 27/01/2022, 16:09:59



___SANDBOXED_JS_FOR_SERVER___

const log = require("logToConsole");
const makeNumber = require("makeNumber");
const getType = require('getType');

const syntheticUserAgentLookup = {
  "chrome-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1",
  "edge-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/114.0.1823.67 Version/16.0 Mobile/15E148 Safari/604.1",
  "safari-macintosh-tablet": "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/271.3.546369769 Mobile/15E148 Safari/604.1",
  "chrome-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36",
  "safari-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1",
  "safari-in-app-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Instagram 221.0.0.9.115 (iPhone12,1; iOS 15_2_1; de_AT; de-AT; scale=2.00; 828x1792; 349031919)",
  "safari-in-app-ios-tablet": "Mozilla/5.0 (iPad; CPU OS 12_5_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16H62 [FBAN/FBIOS;FBDV/iPad4,4;FBMD/iPad;FBSN/iOS;FBSV/12.5.5;FBSS/2;FBID/tablet;FBLC/de_DE;FBOP/5]",
  "android-webview-android-mobile": "Mozilla/5.0 (Linux; Android 12; SM-G991B Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/98.0.4758.87 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/353.0.0.34.116;]",
  "chrome-android-mobile": "Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36",
  "safari-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Safari/605.1.15",
  "chrome-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36",
  "edge-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62",
  "firefox-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101 Firefox/95.0",
  "samsung internet-android-mobile": "Mozilla/5.0 (Linux; Android 11; SAMSUNG SM-A515F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Mobile Safari/537.36",
  "chrome-chrome os-desktop": "Mozilla/5.0 (X11; CrOS x86_64 14268.67.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.111 Safari/537.36",
  "firefox-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0",
  "chrome-android-tablet": "Mozilla/5.0 (Linux; Android 8.1.0; SM-T580) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.104 Safari/537.36",
  "opera-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 OPR/82.0.4227.50",
  "safari-ios-tablet": "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/271.3.546369769 Mobile/15E148 Safari/604.1",
  "chrome-ios-tablet": "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1",
  "chrome-linux-desktop": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36",
  "firefox-linux-desktop": "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0",
  "firefox-android-mobile": "Mozilla/5.0 (Android 11; Mobile; rv:95.0) Gecko/95.0 Firefox/95.0",
  "opera-android-mobile": "Mozilla/5.0 (Linux; Android 10; YAL-L21) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 Mobile Safari/537.36 OPR/66.2.3445.62346",
  "samsung internet-linux-tablet": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36",
  "samsung internet-android-tablet": "Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-T580) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36",
  "yabrowser-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 YaBrowser/21.11.4.727 Yowser/2.5 Safari/537.36",
  "amazon silk-android-tablet": "Mozilla/5.0 (Linux; Android 9; KFMAWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/94.4.4 like Chrome/94.0.4606.128 Safari/537.36",
  "opera-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 OPR/82.0.4227.43",
  "samsung internet-tizen-mobile": "Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-T580) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36",
  "edge-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62",
  "uc browser-android-mobile": "Mozilla/5.0 (Linux; U; Android 8.1.0; zh-CN; EML-AL00 Build/HUAWEIEML-AL00) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.108 baidu.sogo.uc.UCBrowser/11.9.4.974 UWS/2.13.1.48 Mobile Safari/537.36 AliApp(DingTalk/4.5.11) com.alibaba.android.rimet/10487439 Channel/227200 language/zh-CN",
  "yabrowser-android-mobile": "Mozilla/5.0 (Linux; arm_64; Android 10; COL-L29) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 YaBrowser/21.11.7.71.00 SA/3 Mobile Safari/537.36",
  "opera-android-tablet": "Mozilla/5.0 (Linux; Android 11; SM-T720) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 Safari/537.36 OPR/66.2.3445.62346",
  "opera-linux-desktop": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 OPR/100.0.0.0",
  "seznam-android-mobile": "Mozilla/5.0 (Linux; Android 11; M2101K9G Build/RKQ1.201112.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 SznProhlizec/7.17.1a",
  "yabrowser-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 YaBrowser/21.11.7.183.10 SA/3 Mobile/15E148 Safari/604.1",
  "edge-linux-desktop": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62",
  "uc browser-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X; zh-CN) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/19C63 UCBrowser/13.7.6.1692 Mobile  AliApp(TUnionSDK/0.1.20.4)",
  "yabrowser-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 YaBrowser/21.11.0.2054 Yowser/2.5 Safari/537.36",
  "seznam-windows-desktop": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 SznProhlizec/6.19.0",
  "seznam-ios-mobile": "Mozilla/5.0 (iPhone; CPU OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15e148  SznProhlizec/8.4.0i",
  "amazon silk-android-mobile": "Mozilla/5.0 (Linux; Android 9; KFTRPWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/96.1.237 like Chrome/96.0.4664.128 Safari/537.36",
  "chrome-blackberry-mobile": "Mozilla/5.0 (Linux; Android 8.1.0; BBB100-6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.104 Mobile Safari/537.36",
  "iron-windows-desktop": "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Iron/13.0.800.0 Chrome/13.0.800.0 Safari/535.1",
  "yabrowser-android-tablet": "Mozilla/5.0 (Linux; arm_64; Android 8.0.0; AGS2-L09) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.166 YaBrowser/21.8.4.112.01 Safari/537.36",
  "seznam-android-tablet": "Mozilla/5.0 (Linux; Android 10; Lenovo TB-X606X Build/QP1A.190711.020) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.87 Safari/537.36 Tablet SznProhlizec/7.17.1a",
  "firefox-freebsd-desktop": "Mozilla/5.0 (X11; FreeBSD amd64; rv:95.0) Gecko/20100101 Firefox/95.0",
  "seznam-macintosh-desktop": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15  SznProhlizec/8.4.0i",
  "uc browser-windows-desktop": "Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36 UCBrowser/13.7.6.1157",
  "puffin-linux-desktop": "Mozilla/5.0 (X11; U; U; Linux x86_64; it-it) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 Safari/537.36 Puffin/9.2.1.50969AV",
  "duckduckgo-android-mobile": "Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/114.0.5735.196 Mobile DuckDuckGo/5 Safari/537.36",
  "duckduckgo-ios-mobile": "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 DuckDuckGo/7 Safari/605.1.15",
  "chrome-linux-smart_tv": "Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602 VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)",
  "chrome-android-smart_tv": "Mozilla/5.0 (Linux; Android 5.1.1; Hi3798CV200) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.105 Safari/537.36",
  "amazon silk-android-smart_tv": "Mozilla/5.0 (Linux; Android 9; KFTRWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/112.7.1 like Chrome/112.0.5615.213 Safari/537.36",
  "safari-tizen-smart_tv": "Mozilla/5.0 (PlayStation; PlayStation 4/10.50) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4",
  "chrome-tizen-smart_tv": "Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602 VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)",
  "opera-tizen-smart_tv": "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 OPR/46.0.2207.0 OMI/4.20.3.54.Catcher2.210 Model/Hisense-MSD6886 VIDAA/4.0(Hisense;SmartTV;43A519EEVS;mstar6886/V0000.01.00J.N0423;UHD)",
  "edge-windows-smart_tv": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; Xbox; Xbox One; MSAppHost/3.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.22621",
  "safari-playstation-smart_tv": "Mozilla/5.0 (PlayStation; PlayStation 4/10.50) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4",
  "opera-android-smart_tv": "Mozilla/5.0 (Linux; Andr0id 10; BRAVIA VH1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36 OPR/46.0.2207.0 OMI/4.21.0.273.DIA6.221 HbbTV/1.5.1 ( DRM; Sony; KD-55XH9005; PKG6.1874.0211EUA; ; com.sony.HE.G4.4K; ) sony.hbbtv.tv.G4.2020HE.4K",
  "opera-linux-smart_tv": "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 OPR/46.0.2207.0 OMI/4.20.3.54.Catcher2.210 Model/Hisense-MSD6886 VIDAA/4.0(Hisense;SmartTV;43A519EEVS;mstar6886/V0000.01.00J.N0423;UHD)",
  "desktop-fallback": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36",
  "tablet-fallback": "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/271.3.546369769 Mobile/15E148 Safari/604.1",
  "mobile-fallback": "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1",
  "smart_tv-fallback": "Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602 VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)"
};

// ================UNRECOGNIZED TIZEN START================
// "safari-tizen-smart_tv": "Mozilla/5.0 (SMART-TV; LINUX; Tizen 5.5) AppleWebKit/537.36 (KHTML, like Gecko) 69.0.3497.106/5.5 TV Safari/537.36"
// chrome-tizen-smart_tv
// opera-tizen-smart_tv
// ================UNRECOGNIZED TIZEN END================

/**
 * Gets the predefined name by checking a pattern in the client user agent.
 * 
 * @param {string} userAgent - client user agent.
 * @param {object} regexObject - {name, regex pattern}.
 * @returns {string} - returns a name property of the regexObject based on the regex match.
 */
function getMatchingNameFromRegexObject(userAgent, regexObject) {
  for (const i of regexObject) {
    if (!!userAgent.match(i.regex)) {
      return i.name;
    }
  }
  return "unknown";
}

/**
 * Defines the map of the expected browser names and regex pattern.
 * 
 * @param {string} userAgent - client user agent.
 * @returns {string} - browser name.
 */
function getBrowser(userAgent) {
  const regexArr = [
    { name: "duckduckgo", regex: "duckduckgo" },
    { name: "coc coc", regex: "coc_coc_browser" },
    { name: "puffin", regex: "puffin" },
    { name: "edge", regex: "edge|edga|edgios|edg/" },
    { name: "opera", regex: "opera|opr/" },
    { name: "samsung internet", regex: "samsung" }, // Samsung Internet browse name is used in the Google Analytics
    { name: "yabrowser", regex: "yabrowser" },
    { name: "firefox", regex: "firefox" },
    { name: "amazon silk", regex: "silk" },
    { name: "uc browser", regex: "ucmini|ucturbo|ucbrowser" },
    { name: "seznam", regex: "sznprohlizec" },
    { name: "iron", regex: "iron" },
    {
      name: "android-webview",
      regex:
        "(?=.*(android))(?=.*(fban|instagram|facebook|fbios|fb_iab|fb4a|fbav|linkedin|line|snapchat|musical))",
    },
    { name: "chrome", regex: "chrome|crios" },
    {
      name: "safari-in-app",
      regex:
        "(?=.*(ipad|iphone))(?=.*(fban|instagram|facebook|fbios|fb_iab|fb4a|fbav|linkedin|line|snapchat|musical))",
    },
    { name: "safari", regex: "safari|fban|ipad|iphone" },
    { name: "internet explorer", regex: "iemobile|msie" },
  ];
  const lowerCaseUserAgent = userAgent.toLowerCase();
  const browser = getMatchingNameFromRegexObject(lowerCaseUserAgent, regexArr);
  return browser;
}

/**
 * Defines the map of the expected operation system names and regex pattern.
 * 
 * @param {string} userAgent - client user agent.
 * @returns {string} - operation system name.
 */
function getOperatingSystem(userAgent) {
  const regexArr = [
    { name: "windows", regex: "windows" },
    { name: "ios", regex: "ios|ipod|ipad|iphone|cfnetwork" },
    { name: "macintosh", regex: "cfnetwork.*(x86_64)" },
    { name: "macintosh", regex: "mac|darwin" },
    { name: "blackberry", regex: "blackberry|bbb" },
    { name: "android", regex: "android|andr0id|fb4a.*fbsv" },
    { name: "chrome os", regex: "cros [a-z0-9_]+ .* chrome" },
    { name: "tizen", regex: "tizen" },
    { name: "linux", regex: "linux" },
    { name: "playstation", regex: "playstation" },
    { name: "firefox os", regex: "(mobile|tablet);.+firefox" },
    { name: "freebsd", regex: "freebsd" },
  ];
  const lowerCaseUserAgent = userAgent.toLowerCase();
  const operatingSystem = getMatchingNameFromRegexObject(lowerCaseUserAgent, regexArr);
  return operatingSystem;
}

/**
 * Converts a user-provided screen resolution string into the data objet.
 * 
 * @param {string} screenSize - the screen resolution (viewport size) i.e. 1280x1080.
 * @returns {object} - {width, height}
 */
function getScreenSizeData(screenSize) {
  const width = screenSize.split("x")[0];
  const height = screenSize.split("x")[1];
  return {
    width: makeNumber(width) || "undefined", 
    height: makeNumber(height) || "undefined"
  };
}
log("__getScreenSizeData__", "attr: screenSize", getScreenSizeData);

/**
 * Classsfies a device category based on the (or combination) 
 * content of the user agent or a screen width. The sequence and segregation of cases is important.
 * 
 * @param {string} screenSize - width and height of the device viewport in px.
 * @param {string} userAgent - client user agent.
 * @returns {string} - returns the device category from the list: desktop, mobile, tablet, smart_tv
 */
function getDeviceCategory(screenSize, userAgent) {
  const lowerCaseUserAgent = userAgent.toLowerCase();
  const screenSizeData = getScreenSizeData(screenSize);
  const screenWidth = screenSizeData.width;
  const screenHeight = screenSizeData.height;
  const isSmartphone = !!lowerCaseUserAgent.match("iphone|smartphone|phone");
  const isTablet = !!lowerCaseUserAgent.match("ipad|tablet");
  const isSmartTV = !!lowerCaseUserAgent.match("tv|xbox|playstation");
  const isAndroid = !!lowerCaseUserAgent.match("android");
  const isLinux = !!lowerCaseUserAgent.match("linux");

  if (isSmartphone) {
    return "mobile";
  }
  if (isTablet) {
    return "tablet";
  }
  if (screenWidth <= 600) {
    return "mobile";
  }
  if (isSmartTV) {
    return "smart_tv";
  }
  if (screenWidth > 600 && screenWidth < screenHeight) {
    return "tablet";
  }
  if (screenWidth <= 960 && (isAndroid || isLinux)) {
    return "tablet";
  }

  return "desktop";
}
log("__getDeviceCategory__", "args: screenSize, userAgent", getDeviceCategory); // Can be commented out when tested and is production ready.

/**
 * Finds the fallback user agent in the collection, based on the device category hint.
 * 
 * @param {string} deviceCategory - device category.
 * @returns {string} - fallback user agent.
 */
function getFallbackUserAgent(deviceCategory) {
  const fallbackUserAgent = syntheticUserAgentLookup[deviceCategory + "-fallback"];
  return fallbackUserAgent;
}
log("__getFallbackUserAgent__", "args: deviceCategory", getFallbackUserAgent);

// ======================TEMPLATE ENTRY POINT START======================
const userAgentInput = data.userAgentHeader;
const screenSizeInput = data.screenSize;
const userAgent = getType(userAgentInput) === 'string' ? userAgentInput : "";
const screenSize = getType(screenSizeInput) === 'string' ? screenSizeInput : "";
log("__screenSize__", "handling an input", screenSize);

const browser = getBrowser(userAgent);
const operatingSystem = getOperatingSystem(userAgent);
const deviceCategory = getDeviceCategory(screenSize, userAgent);
const merged = [browser, operatingSystem, deviceCategory].join("-");
log("__test_synthetic_key__", "merged: ", merged);
const syntheticUserAgent =
  syntheticUserAgentLookup[merged] || getFallbackUserAgent(deviceCategory);
return syntheticUserAgent;
// ======================TEMPLATE ENTRY POINT END======================
___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]
___TEMPLATE_PARAMETERS___

[
      {
    "type": "LABEL",
    "name": "userConfigSection",
    "displayName": "╭ <strong>Variable Configuration</strong> ────────"
  },
  {
    "type": "TEXT",
    "name": "userAgentHeader",
    "displayName": "User Agent (Header)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "screenSize",
    "displayName": "Screen Size",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "1280x1080",
    "help": "Must contains both, width and height."
  },
    {
    "type": "LABEL",
    "name": "infoSection",
    "displayName": "╭ <strong>Helpful Info</strong> ────────"
  },
    {
    "type": "LABEL",
    "name": "documentationLabel",
    "displayName": "<a href=\"https://github.com/trkkn/gtm-server-variable-template-ip-range-categorizer\" target=\"_blank\">🧭 Template Documentation</a>"
  },
    {
    "type": "LABEL",
    "name": "label2",
    "displayName": "🔁 Template Version: 2.0.0"
  }
]
___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___TESTS___

scenarios:
- name: Random User Agent Input + small device
  code: |-
    for (const ua of randomUserAgent) {
      let result = runCode({userAgentHeader: ua, screenSize: "576x498"});
      assertThat(syntheticUserAgentList).contains(result);
    }
- name: Random User Agent Input + medium device
  code: |-
    for (const ua of randomUserAgent) {
      let result = runCode({userAgentHeader: ua, screenSize: "760x654"});
      assertThat(syntheticUserAgentList).contains(result);
    }
- name: Random User Agent Input + large device
  code: |-
    for (const ua of randomUserAgent) {
      let result = runCode({userAgentHeader: ua, screenSize: "1280x1076"});
      assertThat(syntheticUserAgentList).contains(result);
    }
- name: Invalid User Agent Input
  code: |-
    const invalidInputs = [undefined, 'undefined', null, "null", "", "something else", false, true, "false", "true", "None", "null", 1, 0, "1", "0"];

    for (const ua of invalidInputs) {
      let result = runCode({userAgentHeader: ua, screenSize: "1280x1076"});
      assertThat(syntheticUserAgentList).contains(result);
    }
- name: Invalid Screen Size
  code: |-
    const userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/20G75 [FBAN/FBIOS;FBDV/iPhone14,3;FBMD/iPhone;FBSN/iOS;FBSV/16.6;FBSS/3;FBID/phone;FBLC/fr_FR;FBOP/5]";

    const invalidInputs = [undefined, 'undefined', null, "null", "", "something else", false, true, "false", "true", "None", "null", 1, 0, "1", "0"];

    for (const sz of invalidInputs) {
      let result = runCode({userAgentHeader: userAgent, screenSize: sz});
      assertThat(syntheticUserAgentList).contains(result);
    }
- name: Test custom functions
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst object = require('Object');\n\
    const attemptedLogTests = [];\n\n// Add all expected test names.\nconst expectedTestCases\
    \ = [\n  \"__getDeviceCategory__\",\n  \"__getFallbackUserAgent__\",\n  \"__getScreenSizeData__\"\
    \n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n  log(arguments);\n\
    \  attemptedLogTests.push(val1);\n  switch (val1) {\n    case \"__getDeviceCategory__\"\
    :\n      assertThat(val3(\"680x980\", \"_\")).isEqualTo(\"tablet\");\n      assertThat(val3(\"\
    600x740\", \"_\")).isEqualTo(\"mobile\");\n      assertThat(val3(\"1000x1000\"\
    , iPhoneUserAgent)).isEqualTo(\"mobile\");\n      assertThat(val3(\"1000x1000\"\
    , iPadUserAgent)).isEqualTo(\"tablet\");\n      assertThat(val3(\"600x740\", smartTVUserAgent)).isEqualTo(\"\
    mobile\");\n      assertThat(val3(\"980x820\", smartTVUserAgent)).isEqualTo(\"\
    smart_tv\");\n      assertThat(val3(\"960x720\", tabletUserAgent)).isEqualTo(\"\
    tablet\");\n      assertThat(val3(\"1024x986\", \"_\")).isEqualTo(\"desktop\"\
    );\n      break;\n    case \"__getFallbackUserAgent__\":\n      assertThat(val3(\"\
    desktop\")).isDefined();\n      assertThat(val3(\"desktop\")).isString();\n  \
    \    \n      assertThat(val3(\"smart_tv\")).isDefined();\n      assertThat(val3(\"\
    smart_tv\")).isString();\n      \n      assertThat(val3(\"mobile\")).isDefined();\n\
    \      assertThat(val3(\"mobile\")).isString();\n      \n      assertThat(val3(\"\
    tablet\")).isDefined();\n      assertThat(val3(\"tablet\")).isString();\n    \
    \  break;\n    case \"__getScreenSizeData__\":\n      assertThat(val3(\"\")).isObject();\n\
    \      assertThat(val3(\"null\")).isObject();\n      assertThat(val3(\"undefined\"\
    )).isObject();\n      \n      assertThat(object.keys(val3(\"\"))).containsExactly(\"\
    height\", \"width\");\n      assertThat(object.keys(val3(\"null\"))).containsExactly(\"\
    height\", \"width\");\n      assertThat(object.keys(val3(\"undefined\"))).containsExactly(\"\
    height\", \"width\");\n      \n      assertThat(object.values(val3(\"\"))).containsExactly(\"\
    undefined\", \"undefined\");\n      assertThat(object.values(val3(\"null\"))).containsExactly(\"\
    undefined\", \"undefined\");\n      assertThat(object.values(val3(\"undefined\"\
    ))).containsExactly(\"undefined\", \"undefined\");\n      \n      assertThat(object.values(val3(\"\
    1024x768\"))).containsExactly(1024, 768);\n      assertThat(object.values(val3(\"\
    1024\"))).containsExactly(1024, \"undefined\");\n      break;\n    //  Add more\
    \ test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader: \"\", screenSize:\
    \ \"\"});\n\n// Ensures that the testing-log was set up from within the code for\
    \ all listed cases.\nconst allTestCasesCompleted = expectedTestCases.every(testCase\
    \ => {\n  return attemptedLogTests.indexOf(testCase) > -1;\n});\n\nif (!allTestCasesCompleted)\
    \ fail(\"Not all expected tests were executed. Align the unit test to ensure an\
    \ expected test names are included.\");\n\nassertApi(\"logToConsole\").wasCalled();"
- name: screenSize input - empty string
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst attemptedLogTests\
    \ = [];\n\n// Add all expected test names.\nconst expectedTestCases = [\n  \"\
    __screenSize__\"\n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n\
    \  log(arguments);\n  attemptedLogTests.push(val1);\n  switch (val1) {\n    case\
    \ \"__screenSize__\":\n      assertThat(val3).isEqualTo(\"\");\n      break;\n\
    \    //  Add more test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader:\
    \ \"\", screenSize: \"\"});\n\n// Ensures that the testing-log was set up from\
    \ within the code for all listed cases.\nconst allTestCasesCompleted = expectedTestCases.every(testCase\
    \ => {\n  return attemptedLogTests.indexOf(testCase) > -1;\n});\n\nif (!allTestCasesCompleted)\
    \ fail(\"Not all expected tests were executed. Align the unit test to ensure an\
    \ expected test names are included.\");\n\nassertApi(\"logToConsole\").wasCalled();"
- name: screenSize input - 1024x768
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst attemptedLogTests\
    \ = [];\n\n// Add all expected test names.\nconst expectedTestCases = [\n  \"\
    __screenSize__\"\n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n\
    \  log(arguments);\n  attemptedLogTests.push(val1);\n  switch (val1) {\n    case\
    \ \"__screenSize__\":\n      assertThat(val3).isEqualTo(\"1024x768\");\n     \
    \ break;\n    //  Add more test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader:\
    \ \"\", screenSize: \"1024x768\"});\n\n// Ensures that the testing-log was set\
    \ up from within the code for all listed cases.\nconst allTestCasesCompleted =\
    \ expectedTestCases.every(testCase => {\n  return attemptedLogTests.indexOf(testCase)\
    \ > -1;\n});\n\nif (!allTestCasesCompleted) fail(\"Not all expected tests were\
    \ executed. Align the unit test to ensure an expected test names are included.\"\
    );\n\nassertApi(\"logToConsole\").wasCalled();"
- name: screenSize input - undefined
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst attemptedLogTests\
    \ = [];\n\n// Add all expected test names.\nconst expectedTestCases = [\n  \"\
    __screenSize__\"\n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n\
    \  log(arguments);\n  attemptedLogTests.push(val1);\n  switch (val1) {\n    case\
    \ \"__screenSize__\":\n      assertThat(val3).isEqualTo(\"\");\n      break;\n\
    \    //  Add more test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader:\
    \ \"\", screenSize: undefined});\n\n// Ensures that the testing-log was set up\
    \ from within the code for all listed cases.\nconst allTestCasesCompleted = expectedTestCases.every(testCase\
    \ => {\n  return attemptedLogTests.indexOf(testCase) > -1;\n});\n\nif (!allTestCasesCompleted)\
    \ fail(\"Not all expected tests were executed. Align the unit test to ensure an\
    \ expected test names are included.\");\n\nassertApi(\"logToConsole\").wasCalled();"
- name: screenSize input - null
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst attemptedLogTests\
    \ = [];\n\n// Add all expected test names.\nconst expectedTestCases = [\n  \"\
    __screenSize__\"\n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n\
    \  log(arguments);\n  attemptedLogTests.push(val1);\n  switch (val1) {\n    case\
    \ \"__screenSize__\":\n      assertThat(val3).isEqualTo(\"\");\n      break;\n\
    \    //  Add more test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader:\
    \ \"\", screenSize: null});\n\n// Ensures that the testing-log was set up from\
    \ within the code for all listed cases.\nconst allTestCasesCompleted = expectedTestCases.every(testCase\
    \ => {\n  return attemptedLogTests.indexOf(testCase) > -1;\n});\n\nif (!allTestCasesCompleted)\
    \ fail(\"Not all expected tests were executed. Align the unit test to ensure an\
    \ expected test names are included.\");\n\nassertApi(\"logToConsole\").wasCalled();"
- name: screenSize input - string - 1024
  code: "// How to? \n// Enter the log in the code in the place you want to be covered\
    \ by a test. Note, it can be commented out when tested and is production ready.\n\
    // The first log argument must be a declared unique test name.\n// The seond log\
    \ argument is required and can be either a description of a test or an empty string\"\
    .\n// The third log argument is the actual value that we are teting against.\n\
    // Add the test name to the expectedTestCases array.\n// Add the test case and\
    \ assertation.\n\nconst log = require(\"logToConsole\");\nconst attemptedLogTests\
    \ = [];\n\n// Add all expected test names.\nconst expectedTestCases = [\n  \"\
    __screenSize__\"\n];\n\nmock(\"logToConsole\", function(val1, val2, val3) {\n\
    \  log(arguments);\n  attemptedLogTests.push(val1);\n  switch (val1) {\n    case\
    \ \"__screenSize__\":\n      assertThat(val3).isEqualTo(\"1024\");\n      break;\n\
    \    //  Add more test cases here.\n  }\n  return;\n});\n\nrunCode({userAgentHeader:\
    \ \"\", screenSize: \"1024\"});\n\n// Ensures that the testing-log was set up\
    \ from within the code for all listed cases.\nconst allTestCasesCompleted = expectedTestCases.every(testCase\
    \ => {\n  return attemptedLogTests.indexOf(testCase) > -1;\n});\n\nif (!allTestCasesCompleted)\
    \ fail(\"Not all expected tests were executed. Align the unit test to ensure an\
    \ expected test names are included.\");\n\nassertApi(\"logToConsole\").wasCalled();"
setup: "const syntheticUserAgentList = [\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_5\
  \ like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148\
  \ Safari/604.1\",\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) EdgiOS/114.0.1823.67 Version/16.0 Mobile/15E148 Safari/604.1\"\
  ,\n  \"Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML,\
  \ like Gecko) GSA/271.3.546369769 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0\
  \ (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71\
  \ Safari/537.36\",\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0\
  \ (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like\
  \ Gecko) Mobile/15E148 Instagram 221.0.0.9.115 (iPhone12,1; iOS 15_2_1; de_AT; de-AT;\
  \ scale=2.00; 828x1792; 349031919)\",\n  \"Mozilla/5.0 (iPad; CPU OS 12_5_5 like\
  \ Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16H62 [FBAN/FBIOS;FBDV/iPad4,4;FBMD/iPad;FBSN/iOS;FBSV/12.5.5;FBSS/2;FBID/tablet;FBLC/de_DE;FBOP/5]\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 12; SM-G991B Build/SP1A.210812.016; wv) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/98.0.4758.87 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/353.0.0.34.116;]\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36\",\n  \"Mozilla/5.0\
  \ (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2\
  \ Safari/605.1.15\",\n  \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36\",\n  \"Mozilla/5.0 (Windows\
  \ NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110\
  \ Safari/537.36 Edg/96.0.1054.62\",\n  \"Mozilla/5.0 (Windows NT 10.0; Win64; x64;\
  \ rv:95.0) Gecko/20100101 Firefox/95.0\",\n  \"Mozilla/5.0 (Linux; Android 11; SAMSUNG\
  \ SM-A515F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166\
  \ Mobile Safari/537.36\",\n  \"Mozilla/5.0 (X11; CrOS x86_64 14268.67.0) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/96.0.4664.111 Safari/537.36\",\n  \"Mozilla/5.0 (Macintosh;\
  \ Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0\",\n  \"Mozilla/5.0\
  \ (Linux; Android 8.1.0; SM-T580) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.104\
  \ Safari/537.36\",\n  \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 OPR/82.0.4227.50\",\n \
  \ \"Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like\
  \ Gecko) GSA/271.3.546369769 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0 (iPad;\
  \ CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124\
  \ Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36\",\n  \"Mozilla/5.0 (X11;\
  \ Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0\",\n  \"Mozilla/5.0 (Android\
  \ 11; Mobile; rv:95.0) Gecko/95.0 Firefox/95.0\",\n  \"Mozilla/5.0 (Linux; Android\
  \ 10; YAL-L21) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85 Mobile\
  \ Safari/537.36 OPR/66.2.3445.62346\",\n  \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36\
  \ (KHTML, like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36\",\n\
  \  \"Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-T580) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36\",\n  \"Mozilla/5.0\
  \ (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.85\
  \ YaBrowser/21.11.4.727 Yowser/2.5 Safari/537.36\",\n  \"Mozilla/5.0 (Linux; Android\
  \ 9; KFMAWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/94.4.4 like Chrome/94.0.4606.128\
  \ Safari/537.36\",\n  \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 OPR/82.0.4227.43\",\n \
  \ \"Mozilla/5.0 (Linux; Android 8.1.0; SAMSUNG SM-T580) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) SamsungBrowser/16.0 Chrome/92.0.4515.166 Safari/537.36\",\n  \"Mozilla/5.0\
  \ (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110\
  \ Safari/537.36 Edg/96.0.1054.62\",\n  \"Mozilla/5.0 (Linux; U; Android 8.1.0; zh-CN;\
  \ EML-AL00 Build/HUAWEIEML-AL00) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0\
  \ Chrome/57.0.2987.108 baidu.sogo.uc.UCBrowser/11.9.4.974 UWS/2.13.1.48 Mobile Safari/537.36\
  \ AliApp(DingTalk/4.5.11) com.alibaba.android.rimet/10487439 Channel/227200 language/zh-CN\"\
  ,\n  \"Mozilla/5.0 (Linux; arm_64; Android 10; COL-L29) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) Chrome/94.0.4606.85 YaBrowser/21.11.7.71.00 SA/3 Mobile Safari/537.36\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 11; SM-T720) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Chrome/94.0.4606.85 Safari/537.36 OPR/66.2.3445.62346\",\n  \"Mozilla/5.0\
  \ (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36\
  \ OPR/100.0.0.0\",\n  \"Mozilla/5.0 (Linux; Android 11; M2101K9G Build/RKQ1.201112.002)\
  \ AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile\
  \ Safari/537.36 SznProhlizec/7.17.1a\",\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS\
  \ 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 YaBrowser/21.11.7.183.10\
  \ SA/3 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62\",\n \
  \ \"Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X; zh-CN) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Mobile/19C63 UCBrowser/13.7.6.1692 Mobile  AliApp(TUnionSDK/0.1.20.4)\"\
  ,\n  \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) Chrome/94.0.4606.85 YaBrowser/21.11.0.2054 Yowser/2.5 Safari/537.36\"\
  ,\n  \"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)\
  \ Chrome/96.0.4664.55 Safari/537.36 SznProhlizec/6.19.0\",\n  \"Mozilla/5.0 (iPhone;\
  \ CPU OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15e148\
  \  SznProhlizec/8.4.0i\",\n  \"Mozilla/5.0 (Linux; Android 9; KFTRPWI) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Silk/96.1.237 like Chrome/96.0.4664.128 Safari/537.36\",\n\
  \  \"Mozilla/5.0 (Linux; Android 8.1.0; BBB100-6) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Chrome/96.0.4664.104 Mobile Safari/537.36\",\n  \"Mozilla/5.0 (Windows\
  \ NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Iron/13.0.800.0 Chrome/13.0.800.0\
  \ Safari/535.1\",\n  \"Mozilla/5.0 (Linux; arm_64; Android 8.0.0; AGS2-L09) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/92.0.4515.166 YaBrowser/21.8.4.112.01 Safari/537.36\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 10; Lenovo TB-X606X Build/QP1A.190711.020) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.87 Safari/537.36 Tablet SznProhlizec/7.17.1a\"\
  ,\n  \"Mozilla/5.0 (X11; FreeBSD amd64; rv:95.0) Gecko/20100101 Firefox/95.0\",\n\
  \  \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML,\
  \ like Gecko) Version/13.1 Safari/605.1.15  SznProhlizec/8.4.0i\",\n  \"Mozilla/5.0\
  \ (Windows; U; Windows NT 5.2; en-US) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108\
  \ Safari/537.36 UCBrowser/13.7.6.1157\",\n  \"Mozilla/5.0 (X11; U; U; Linux x86_64;\
  \ it-it) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 Safari/537.36\
  \ Puffin/9.2.1.50969AV\",\n  \"Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/114.0.5735.196 Mobile DuckDuckGo/5 Safari/537.36\"\
  ,\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_5_1 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Version/16.5 Mobile/15E148 DuckDuckGo/7 Safari/605.1.15\"\
  ,\n  \"Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182\
  \ Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602 VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 5.1.1; Hi3798CV200) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) Chrome/89.0.4389.105 Safari/537.36\",\n  \"Mozilla/5.0 (Linux; Android\
  \ 9; KFTRWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/112.7.1 like Chrome/112.0.5615.213\
  \ Safari/537.36\",\n  \"Mozilla/5.0 (PlayStation; PlayStation 4/10.50) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Version/15.4\",\n  \"Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/88.0.4324.182 Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602\
  \ VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)\"\
  ,\n  \"Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120\
  \ Safari/537.36 OPR/46.0.2207.0 OMI/4.20.3.54.Catcher2.210 Model/Hisense-MSD6886\
  \ VIDAA/4.0(Hisense;SmartTV;43A519EEVS;mstar6886/V0000.01.00J.N0423;UHD)\",\n  \"\
  Mozilla/5.0 (Windows NT 10.0; Win64; x64; Xbox; Xbox One; MSAppHost/3.0) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.22621\",\n  \"\
  Mozilla/5.0 (PlayStation; PlayStation 4/10.50) AppleWebKit/605.1.15 (KHTML, like\
  \ Gecko) Version/15.4\",\n  \"Mozilla/5.0 (Linux; Andr0id 10; BRAVIA VH1) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36 OPR/46.0.2207.0 OMI/4.21.0.273.DIA6.221\
  \ HbbTV/1.5.1 ( DRM; Sony; KD-55XH9005; PKG6.1874.0211EUA; ; com.sony.HE.G4.4K;\
  \ ) sony.hbbtv.tv.G4.2020HE.4K\",\n  \"Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 OPR/46.0.2207.0 OMI/4.20.3.54.Catcher2.210\
  \ Model/Hisense-MSD6886 VIDAA/4.0(Hisense;SmartTV;43A519EEVS;mstar6886/V0000.01.00J.N0423;UHD)\"\
  ,\n  \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Chrome/97.0.4692.71 Safari/537.36\",\n  \"Mozilla/5.0 (iPad; CPU OS 16_5\
  \ like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/271.3.546369769 Mobile/15E148\
  \ Safari/604.1\",\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0\
  \ (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182\
  \ Odin/88.4324.2.10 Safari/537.36 Model/Hisense-MT9602 VIDAA/6.0(Hisense;SmartTV;32A35EUV;MTK9602/V0000.06.12G.N0408;HD;HU32E5600F;)\"\
  \n];\n\nconst randomUserAgent = [\n \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)\
  \ AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36\",\n  \"\
  ServusTV On/0 CFNetwork/1335.0.3 Darwin/21.6.0\",\n  \"Mozilla/5.0 (Linux armv7l)\
  \ AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.140 Safari/537.36 OPR/46.0.2207.0\
  \ OMI/4.21.4.112.Catcher4.66 Model/Hisense-MT9602 VIDAA/5.0(NEI;SmartTV;VS0432FB1;MTK9602/V0000.01.00T.M0816;HD)\"\
  ,\n  \"Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120\
  \ Safari/537.36 OPR/46.0.2207.0 OMI/4.20.5.80.Catcher3.128 Model/Hisense-MT9602\
  \ VIDAA/4.0(NEX-OEM;SmartTV;VI0143FB1_0101;MTK9602/V0000.01.00U.M0621;HD)\", \n\
  \  \"Mozilla/5.0 (SMART-TV; LINUX; Tizen 7.0) AppleWebKit/537.36 (KHTML, like Gecko)\
  \ 94.0.4606.31/7.0 TV Safari/537.36\",\n  \"Mozilla/5.0 (Windows NT 10.0; Win64;\
  \ x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.83\
  \  Safari/537.36\",\n  \"Mozilla/5.0 (Linux; Android 12; SM-T500 Build/SP1A.210812.016)\
  \ AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.166 Safari/537.36\
  \ GNews Android/2022148526\",\n  \"Mozilla/5.0 (Android 8.1.0; Mobile; rv:109.0)\
  \ Gecko/116.0 Firefox/116.0\",\n  \"okhttp/4.9.1\",\n  \"Mozilla/5.0 (iPhone; CPU\
  \ iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/276.1.554948670\
  \ Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like\
  \ Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/20G75 Instagram 295.0.0.16.63\
  \ (iPhone14,6; iOS 16_6; pl_PL; pl; scale=2.00; 640x1136; 501817603) NW/3\",\n \
  \ \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Mobile/20G75 [FBAN/FBIOS;FBDV/iPhone14,5;FBMD/iPhone;FBSN/iOS;FBSV/16.6;FBSS/3;FBID/phone;FBLC/da_DK;FBOP/5]\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 10; STK-LX1 Build/HUAWEISTK-LX1; wv) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.177 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/427.0.0.31.63;]\"\
  ,\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) GSA/275.0.550423587 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0\
  \ (Linux; Android 13; SM-A336B Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML,\
  \ like Gecko) Version/4.0 Chrome/114.0.5735.61 Mobile Safari/537.36 Instagram 286.0.0.20.69\
  \ Android (33/13; 450dpi; 1080x2185; samsung; SM-A336B; a33x; s5e8825; pl_PL; 481918966)\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 12; FP4 Build/SKQ1.220201.001; wv) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.166 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/427.0.0.31.63;]\"\
  ,\n  \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Mobile/20G75 [FBAN/FBIOS;FBDV/iPhone14,3;FBMD/iPhone;FBSN/iOS;FBSV/16.6;FBSS/3;FBID/phone;FBLC/fr_FR;FBOP/5]\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 10; HMA-L29) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Chrome/101.0.0.0 Mobile Safari/537.36\",\n  \"Mozilla/5.0 (Linux; Android\
  \ 13; SM-M325FV Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko)\
  \ Version/4.0 Chrome/115.0.5790.166 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/427.0.0.31.63;]\"\
  ,\n  \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML,\
  \ like Gecko)\",\n  \"Mozilla/5.0 (iPad; CPU OS 15_4 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) CriOS/103.0.5060.63 Mobile/15E148 Safari/604.1\",\n  \"Mozilla/5.0\
  \ (Linux; Android 7.1.1; SM-T555 Build/NMF26X; wv) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Version/4.0 Chrome/115.0.5790.166 Safari/537.36 [FB_IAB/FB4A;FBAV/426.0.0.26.50;]\"\
  ,\n  \"Mozilla/5.0 (Linux; Android 10; Y103_EEA Build/QP1A.190711.020) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Chrome/115.0.5790.166 Safari/537.36\",\n  \"Mozilla/5.0 (Linux;\
  \ Android 10; X104-EEA Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like\
  \ Gecko) Version/4.0 Chrome/115.0.5790.166 Safari/537.36\"\n];\n\nconst iPhoneUserAgent\
  \ = \"Mozilla/5.0 (iPhone; CPU iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) GSA/276.1.554948670 Mobile/15E148 Safari/604.1\";\n\nconst\
  \ iPadUserAgent = \"Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15\
  \ (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1\";\n\nconst smartTVUserAgent\
  \ = \"Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.140\
  \ Safari/537.36 OPR/46.0.2207.0 OMI/4.21.4.112.Catcher4.66 Model/Hisense-MT9602\
  \ VIDAA/5.0(NEI;SmartTV;VS0432FB1;MTK9602/V0000.01.00T.M0816;HD)\";\n\nconst tabletUserAgent\
  \ = \"Mozilla/5.0 (Linux; Android 7.1.1; SM-T555 Build/NMF26X; wv) AppleWebKit/537.36\
  \ (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.166 Safari/537.36 [FB_IAB/FB4A;FBAV/426.0.0.26.50;]\"\
  ;"