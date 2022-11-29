/**
* 
*/

	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	
	var i;
	var j;
	var k;
	
	var cookieProvince = "provinceCookie";
	var cookieCity = "cityCookie";
	var cookieDistrict = "districtCookie";
	
	var xmlObj;
	var defaultProvince = "-\u8bf7\u9009\u62e9-";
	var defaultCity = "-\u8bf7\u9009\u62e9-";
	var defaultDistrict = "-\u8bf7\u9009\u62e9-";	
	
	var text;
	var value;
	
	function loadXML(xmlFile,provinceId,cityId,districtId) {
		xmlDoc.async = false;    
		xmlDoc.load(xmlFile);
		xmlObj = xmlDoc.documentElement;	
		document.getElementById("province").options[0] = new Option(defaultProvince,"");		
		document.getElementById("city").options[0] = new Option(defaultCity,"");
		document.getElementById("district").options[0] = new Option(defaultDistrict,"");	
			
		for(i = 0;i < xmlObj.childNodes.length;i ++) {
			text = xmlObj.childNodes(i).getAttribute("name");
			value = xmlObj.childNodes(i).getAttribute("code");			
			document.getElementById("province").options[i + 1] = new Option(text,value);			
		}

								
		if(provinceId != null && provinceId != "") {
			document.getElementById("province").value = provinceId;
			chgProvince(provinceId);
		} else {
			if(getCookie(cookieProvince) == null) {
				return;
				document.getElementById("province").value = "";
			} else {
				document.getElementById("province").value = getCookie(cookieProvince);	
			}
			chgProvince(getCookie(cookieProvince));
		}
		
		if(cityId != null && cityId != "") {
			document.getElementById("city").value = cityId;
			chgCity(cityId);	
		} else {	
			if(getCookie(cookieCity)== null) {
				return;
				document.getElementById("city").value = "";
			} else {
				document.getElementById("city").value = getCookie(cookieCity);		
			}
			chgCity(getCookie(cookieCity));	
		}
		
		if(districtId != null && districtId != "") {
			document.getElementById("district").value = districtId;	
		} else {
			if(getCookie(cookieDistrict)== null) {
				return;
				document.getElementById("district").value = "";
			} else {
				document.getElementById("district").value = getCookie(cookieDistrict);
			}
		}       
	}
	
	var province;
	var city;
	var district;
	
	function getAreaName(code)
	{
		var provinceId = code.substring(0, 2);
		var cityId = code.substring(0, 4);
		var districtId = code;
		
		xmlObj = xmlDoc.documentElement;
		
		for(i = 0;i < xmlObj.childNodes.length;i ++) {
			p = xmlObj.childNodes(i).getAttribute("code");
			if (p == provinceId)	
			{
				province = xmlObj.childNodes(i).getAttribute("name");
				for (j = 0; j < xmlObj.childNodes(i).childNodes.length; j++)
				{
					c = xmlObj.childNodes(i).childNodes(j).getAttribute("code");
					if (c == cityId) 
					{
						city = xmlObj.childNodes(i).childNodes(j).getAttribute("name");
						for (k = 0;k < xmlObj.childNodes(i).childNodes(j).childNodes.length;k ++)
						{
							d = xmlObj.childNodes(i).childNodes(j).childNodes(k).getAttribute("code");
							if (d == districtId) 
							{
								district = xmlObj.childNodes(i).childNodes(j).childNodes(k).getAttribute("name");
							}
						}
					}
				}
			}		
		}
	}
	
	function getProvince(code)
	{
		getAreaName(code);
		
		return province;
	}
	
	function getCity()
	{
		return city;
	}
	
	function getDistrict()
	{
		return district;
	}

	function chgProvince(code) {
		
		var isSelected = false;
		
		if (document.getElementById("city").options.length != 0) { 
			for (i = 0;i < document.getElementById("city").options.length;i ++) {
				document.getElementById("city").options[i] = null ;
				document.getElementById("city").options.remove(i);
			}
		}
		
		/*setCookie(cookieProvince,code);*/
		
		document.getElementById("city").options.length = 1;
		document.getElementById("city").options[0] = new Option(defaultCity,"");
		document.getElementById("district").options.length = 1;
		document.getElementById("district").options[0] = new Option(defaultDistrict,"");
		
		var codeProvince;
		
		for(i = 0;i < xmlObj.childNodes.length;i ++) {
			if(isSelected) return;
			codeProvince = xmlObj.childNodes(i).getAttribute("code");
			if(code == codeProvince) {
				isSelected = true;
				for(j = 0;j < xmlObj.childNodes(i).childNodes.length;j ++) {
					text = xmlObj.childNodes(i).childNodes(j).getAttribute("name");
					value = xmlObj.childNodes(i).childNodes(j).getAttribute("code");
					document.getElementById("city").options[j + 1] = new Option(text,value);
				}
			}
		}
		
	}
	
	function chgCity(code) {
		
		var isSelected = false;
		
		if (document.getElementById("district").options.length != 0) { 
			for (i = 0;i < document.getElementById("district").options.length;i ++) {
				document.getElementById("district").options[i] = null ;
				document.getElementById("district").options.remove(i);
			}
		}
		
		/*setCookie(cookieCity,code);*/
		
		document.getElementById("district").options.length = 1;			
		document.getElementById("district").options[0] = new Option(defaultDistrict,"");
		
		for(i = 0;i < xmlObj.childNodes.length;i ++) {
			if(isSelected) return;
			var codeCity;			
			for(j = 0;j < xmlObj.childNodes(i).childNodes.length;j ++) {			
				codeCity = xmlObj.childNodes(i).childNodes(j).getAttribute("code");
				if(code == codeCity) {
					isSelected = true;
					for(k = 0;k < xmlObj.childNodes(i).childNodes(j).childNodes.length;k ++) {
						text = xmlObj.childNodes(i).childNodes(j).childNodes(k).getAttribute("name");
						value = xmlObj.childNodes(i).childNodes(j).childNodes(k).getAttribute("code");						
						document.getElementById("district").options[k + 1] = new Option(text,value);
					}
				}
			}
		}
	}
	
	function chgDistrict(code) {
		/*setCookie(cookieDistrict,code);*/
	}
	
// =========================================================================
//                          Cookie functions 
// =========================================================================
/* This function is used to set cookies */
function setCookie(name,value,expires,path,domain,secure) {
  document.cookie = name + "=" + escape (value) +
    ((expires) ? "; expires=" + expires.toGMTString() : "") +
    ((path) ? "; path=" + path : "") +
    ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}

/* This function is used to get cookies */
function getCookie(name) {
	var prefix = name + "=" 
	var start = document.cookie.indexOf(prefix) 

	if (start==-1) {
		return null;
	}
	
	var end = document.cookie.indexOf(";", start+prefix.length) 
	if (end==-1) {
		end=document.cookie.length;
	}

	var value=document.cookie.substring(start+prefix.length, end) 
	return unescape(value);
}

/* This function is used to delete cookies */
function deleteCookie(name,path,domain) {
  if (getCookie(name)) {
    document.cookie = name + "=" +
      ((path) ? "; path=" + path : "") +
      ((domain) ? "; domain=" + domain : "") +
      "; expires=Thu, 01-Jan-70 00:00:01 GMT";
  }
}
