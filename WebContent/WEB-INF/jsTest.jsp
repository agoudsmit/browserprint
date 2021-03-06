<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%-- These comments are to prevent excess whitespace in the output.
--%><%@page session="false"%><%--
--%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%--
--%><!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Browserprint</title>
	<meta name="robots" content="noindex" >
	<script type="text/javascript" src="scripts/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="scripts/swfobject.js"></script>
	<script type="text/javascript" src="scripts/PluginDetect.js"></script>
	<script type="text/javascript" src="scripts/f.js"></script>
	<script type="text/javascript" src="scripts/fjs2.js"></script>
	<script type="text/javascript" src="adtests/easylist/ads/js/testscript.js"></script>
	<script type="text/javascript" src="scripts/sha1.js"></script>
	<script type="text/javascript" src="scripts/audiofp.js"></script>
</head>
<body>
	<p>
		Please wait...
	</p>
	<form id="detailsForm" action="<c:url value="test"/>" method="POST">
		<div id="formdiv">
			<input type="hidden" name="show_fingerprint" value="true">
			<input type="hidden" name="captchaAnswer" value="<c:out value='${ param.captchaAnswer }'/>">
		</div>
	</form>
	<script type="text/javascript">
		// Run the audio fingerprints.
		// Unlike other fingerprinting functions these output to hidden elements instead of returning a value.
		// There may be weird interference effects if the prints are run sequentially with no delay, hence the sleeping.
		setTimeout(function() {
			run_pxi_fp();
		}, 0);
		setTimeout(function() {
			run_nt_vc_fp();
		}, 1000);
		setTimeout(function() {
			run_cc_fp();
		}, 2000);
		setTimeout(function() {
			run_hybrid_fp();
		}, 3000);
	</script>
	<script type="text/javascript">
	var tbbVersion = "";
	function pref(key, val) {
		if(key == "torbrowser.version"){
			tbbVersion = val;
		}
	}
	</script>
	<script type="text/javascript" src="resource:///defaults/preferences/000-tor-browser.js"></script>
	<!-- Flash for detecting fonts and other things. -->
	<div id="OSDataDiv">
			<a href="http://www.adobe.com/go/getflashplayer">
				<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
			</a>
	</div>
	<script type="text/javascript">
		var flashvars = {};
		var params = {};
		var attributes = {};
		attributes.id = "OSData";
		swfobject.embedSWF("flash/OSData.swf", "OSDataDiv", "0", "0", "9.0.0", false, flashvars, params, attributes);
	</script>
	<!-- Part of the ad blocking test. -->
	<script type="text/javascript">
        google_ad_height = 90;
    </script> 
	<div id="ad" style="display: none">
		<script type="text/javascript" src="https://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
	</div>
	<img id="banner468x60" src="adtests/easylist/ads/banner468x60.png" style="display:none"/>
	<div style="display:none">
		<div id="likeButton" class="fb-like" data-href="https://browserprint.info"></div>
	</div>
	<div id="fb-root"></div>
	<div id="redditButtonDiv" style="display: none">
		<script type="text/javascript">
			//Set the details of the reddit button.
			reddit_url='browserprint.info';
			reddit_newwindow='1';
		</script>
		<script type="text/javascript" src="//www.redditstatic.com/button/button1.js?newwindow=1"></script>
	</div>
	<div style="display:none">
		<a href="https://twitter.com/share" id="twitterLink" class="twitter-share-button" data-url="https://browserprint.info" data-text="Check out your browser fingerprint at">Tweet</a>
	</div>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
	<script type="text/javascript">(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<script type="text/javascript">
		$(window).load(function(){
			//We sleep for a second to avoid a bug where Flash doesn't work because it hasn't had enough time to load or something.
			setTimeout(getFP, 1000);
		});
		function getFP(){
			var flash = $("#OSData")[0];
			
			//Platform
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'Platform',
	    		name: 'Platform',
	    		value: getPlatform()
			}).appendTo('#formdiv')
			
			//PlatformFlash
			{
				var val;
				try{
					if(typeof flash === 'undefined'){
						val = 'No Flash';
					}
					else{
						val = getPlatformFlash(flash);
					}
				}catch(e){
					val = 'Flash disabled';
				}
				$('<input>').attr({
			    	type: 'hidden',
			    	id: 'PlatformFlash',
			    	name: 'PlatformFlash',
			    	value: val
				}).appendTo('#formdiv');
			}
			
			//PluginDetails
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'PluginDetails',
	    		name: 'PluginDetails',
	    		value: getPluginDetails()
			}).appendTo('#formdiv');
			
			//TimeZone
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'TimeZone',
	    		name: 'TimeZone',
	    		value: getTimeZone()
			}).appendTo('#formdiv');
	
			//ScreenDetails
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'ScreenDetails',
	    		name: 'ScreenDetails',
	    		value: getScreenDetails()
			}).appendTo('#formdiv');
			
			//ScreenDetailsFlash
			{
				var val;
				try{
					if(typeof flash === 'undefined'){
						val = 'No Flash';
					}
					else{
						val = getScreenDetailsFlash(flash);
					}
				}catch(e){
					val = 'Flash disabled';
				}
				$('<input>').attr({
			   		type: 'hidden',
			   		id: 'ScreenDetailsFlash',
			   		name: 'ScreenDetailsFlash',
			   		value: val
				}).appendTo('#formdiv');
			}
			
			//LanguageFlash
			{
				var val;
				try{
					if(typeof flash === 'undefined'){
						val = 'No Flash';
					}
					else{
						val = getLanguageFlash(flash);
					}
				}catch(e){
					val = 'Flash disabled';
				}
				$('<input>').attr({
			   		type: 'hidden',
			   		id: 'LanguageFlash',
			    	name: 'LanguageFlash',
			   		value: val
				}).appendTo('#formdiv');
			}
			
			//Fonts Flash
			{
				var val;
				try{
					if(typeof flash === 'undefined'){
						val = 'No Flash';
					}
					else{
						val = getFontsFlash(flash);
					}
				}catch(e){
					val = 'Flash disabled';
				}
				$('<input>').attr({
			   		type: 'hidden',
			   		id: 'Fonts',
			   		name: 'Fonts',
			   		value: val
				}).appendTo('#formdiv');
			}
			
			//Fonts JavaScript/CSS
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'FontsJS_CSS',
	    		name: 'FontsJS_CSS',
	    		value: getFontsJavaScriptCSS()
			}).appendTo('#formdiv');
			
			//CharSizes
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'CharSizes',
	    		name: 'CharSizes',
	    		value: getCharacterSizes()
			}).appendTo('#formdiv');

			//SuperCookieLocalStorage
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'SuperCookieLocalStorage',
	    		name: 'SuperCookieLocalStorage',
	    		value: getSuperCookieLocalStorage()
			}).appendTo('#formdiv');
			
			//SuperCookieSessionStorage
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'SuperCookieSessionStorage',
	    		name: 'SuperCookieSessionStorage',
	    		value: getSuperCookieSessionStorage()
			}).appendTo('#formdiv');
			
			//SuperCookieUserData
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'SuperCookieUserData',
	    		name: 'SuperCookieUserData',
	    		value: getSuperCookieUserData()
			}).appendTo('#formdiv');
			
			//IndexedDBEnabled
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'IndexedDBEnabled',
	    		name: 'IndexedDBEnabled',
	    		value: getIndexedDBEnabled()
			}).appendTo('#formdiv');
			
			//DateTime
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'DateTime',
	    		name: 'DateTime',
	    		value: getDateTime()
			}).appendTo('#formdiv');
			
			//MathTan
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'MathTan',
	    		name: 'MathTan',
	    		value: getMathTan()
			}).appendTo('#formdiv');
			
			//TbbVersion
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'TbbVersion',
	    		name: 'TbbVersion',
	    		value: tbbVersion
			}).appendTo('#formdiv');
			
			//AdsBlockedGoogle
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'AdsBlockedGoogle',
	    		name: 'AdsBlockedGoogle',
	    		value: getAdsBlockedGoogle()
			}).appendTo('#formdiv');
			
			//AdsBlockedBanner
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'AdsBlockedBanner',
	    		name: 'AdsBlockedBanner',
	    		value: getAdsBlockedBanner()
			}).appendTo('#formdiv');
			
			//AdsBlockedScript
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'AdsBlockedScript',
	    		name: 'AdsBlockedScript',
	    		value: getAdsBlockedScript()
			}).appendTo('#formdiv');
			
			//LikeShareFacebook
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'LikeShareFacebook',
	    		name: 'LikeShareFacebook',
	    		value: getFacebookSocialButton()
			}).appendTo('#formdiv');
			
			//LikeShareTwitter
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'LikeShareTwitter',
	    		name: 'LikeShareTwitter',
	    		value: getTwitterButton()
			}).appendTo('#formdiv');
			
			//LikeShareReddit
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'LikeShareReddit',
	    		name: 'LikeShareReddit',
	    		value: getRedditButton()
			}).appendTo('#formdiv');
						
			//Canvas
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'Canvas',
	    		name: 'Canvas',
	    		value: getCanvas()
			}).appendTo('#formdiv');
			
			//WebGLVendor
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'WebGLVendor',
	    		name: 'WebGLVendor',
	    		value: getWebGLVendor()
			}).appendTo('#formdiv');
			
			//WebGLVendor
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'WebGLRenderer',
	    		name: 'WebGLRenderer',
	    		value: getWebGLRenderer()
			}).appendTo('#formdiv');
			
			var touch = getTouchSupport();
			//Touch Max Touch Points
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'TouchPoints',
	    		name: 'TouchPoints',
	    		value: touch[0]
			}).appendTo('#formdiv');
			
			//Touch Event
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'TouchEvent',
	    		name: 'TouchEvent',
	    		value: touch[1]
			}).appendTo('#formdiv');
			
			//Touch Start
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'TouchStart',
	    		name: 'TouchStart',
	    		value: touch[2]
			}).appendTo('#formdiv');
			
			//Submit the page after a few seconds.
			//Delay is to allow the audio fingerprinting tests to all complete.
			setTimeout(submitDetailsForm, 6000);
		}
		
		function submitDetailsForm(){
			//Time, for clock skew test.
			//We put this here to avoid the timer altering the time by however many seconds.
			$('<input>').attr({
	    		type: 'hidden',
	    		id: 'Time',
	    		name: 'Time',
	    		value: getTime()
			}).appendTo('#formdiv');
			
			$('#detailsForm').submit();
		}
	</script>
</body>
</html>