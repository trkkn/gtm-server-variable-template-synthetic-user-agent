# Synthetic User Agent

The user-agent of the user’s browser is a description of the software setup the user visits a website with. It is presented as part of the headers of the HTTP requests that hit the servers of the proposed solution (all other headers of the HTTP request will be deleted at this stage). For example, a typical user-agent looks like this:

`Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36`

This specific user-agent contains the information that a user uses “Windows 10” as their operating system and “Google Chrome” as their browser. The versions of the operating systems and browser can be very detailed and vary in a space of up to ten digits (e. g. 97.0.4692.71). This leads to a high cardinality where only a handful of users might have the version 97.0.4692.71, which could result in an attribute that serves to identify personas. The only interest of the proposed solution, however, lies in identifying the user’s browser and their operating system. Hence, the full granularity that the user-agent provides natively is not required and can therefore be modified from an analysing perspective. However, analytics tools such as Google Analytics do not accept to eset the browser/operating system directly. Therefore, a full synthetic user-agent must be sent to have browser/operating system reported accurately.

Typically for users of common software setups such as “Google Chrome” + “Windows”, there will always be dozens of users with the same user-agent. However, for less common software setups such as “Firefox” + “Linux”, a user-agent that will not be unique cannot be guaranteed. The proposed solution will therefore protect the user against identifying themselves through their potentially unique user-agent, by exchanging their actual user-agent against a generic and synthetic user-agent that still delivers the same generic properties such as browser name and operating system.

This will be achieved by the solution detecting the browser and the operating system from the user-agent in the SGTM. As soon as these properties are known, they will be replaced by a universal user-agent that provides the same properties. For example, the following overview (Table 1) shows how different user-agents that have the same browser/operating system properties will be replaced with a generic version of the user-agent with the same properties.

| Browser/Operating System | Original User-Agent | Synthetic User-Agent
| ------------- |:-------------:| -----:|
Safari / iOS | Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1 | Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1
Safari / iOS| Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1 | Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1
Safari / iOS | iPhone XR/iOS-14.8.1/Version: 5.9.1/Build: 3 | Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1


`
If the user's actual user-agent is unknown to this lookup table, we will return the following:
mobile devices --> safari-ios-mobile
tablet devices --> safari-ios-tablet
desktop devices --> chrome-windows-desktop
`

To create the list of synthetic user-agents, the solution has analysed the historic prevalence of original user-agents and only used those combinations (browser + operating system), that represented at least 250 different user entries per month. All combinations that are represented by less than 250 user entries per month are discarded and replaced by an empty user-agent. This list will be reviewed on a yearly basis to ensure to have a representative and accurate methodology.
