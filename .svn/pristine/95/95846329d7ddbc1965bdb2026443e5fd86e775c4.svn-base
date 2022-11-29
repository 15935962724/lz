/* 阅读模式的js */

var currentpos, timer;
var g_step	= 50;
var i_text	= document.getElementById('readModeTxt');
var i_menu	= document.getElementById('menu');

function initialize()
{
	timer	= setInterval(scrollwindow, g_step);
}
function setStep(p_val)
{
	g_step	= p_val;

	if (timer)
	{
		clearInterval(timer);
		timer	= setInterval(scrollwindow, g_step);
	}
}
function setBgColor(p_val)
{
	if (p_val.substr(0,1) == "#")
	{
		document.getElementById('readModeTxt').style.color	= "#000";
	}
	else
	{
		document.getElementById('readModeTxt').style.color	= "#fff";
	}

	document.getElementById('readModeTxt').style.backgroundColor = p_val;
}
function setFontStyle(p_val)
{
	document.getElementById('readModeTxt').style.fontFamily	= p_val;
}
function setFontSize(p_val)
{
	document.getElementById('readModeTxt').style.fontSize	= p_val;
}
function setFontColor(p_val)
{
	document.getElementById('readModeTxt').style.color		= p_val;
}
function sc()
{
	clearInterval(timer);
}
function scrollwindow()
{
	i_text.scrollTop	= i_text.scrollTop + 1;

	if (i_text.scrollHeight == i_text.scrollTop + i_text.clientHeight )
	{
		sc();
	}
}

function setSelect(p_id,p_val)
{
	var p_obj	= document.getElementsByName(p_id);
	for (var i=0; i<p_obj.length; i++)
	{
		if (p_obj[i].type == "select-one")
		{
			for (var j = 0; j < p_obj[i].options.length; j++)
			{
				if (p_val == p_obj[i].options[j].value)
				{
					p_obj[i].options[j].selected	= true;
				}
			}
		}

		if (p_obj[i].type == "checkbox" || p_obj[i].type == "radio")
		{
			if (p_val == p_obj[i].value)
			{
				p_obj[i].checked	= true;
			}
		}
	}
}
function SetCookie(name,value,expires,path,domain,secure)
{
	var expDays			= expires*24*60*60*1000;
	var expDate			= new Date();
	expDate.setTime(expDate.getTime()+expDays);
	var expString		= ((expires==null) ? "" : (";expires="+expDate.toGMTString()))
	var pathString		= ((path==null) ? "" : (";path="+path))
	var domainString	= ((domain==null) ? "" : (";domain="+domain))
	var secureString	= ((secure==true) ? ";secure" : "" )
	document.cookie		= name + "=" + escape(value) + expString + pathString + domainString + secureString;
}
function GetCookie(name)
{
	var result			= null;
	var myCookie		= document.cookie + ";";
	var searchName		= name + "=";
	var startOfCookie	= myCookie.indexOf(searchName);
	var endOfCookie;
	if (startOfCookie != -1)
	{
		startOfCookie	+= searchName.length;
		endOfCookie		= myCookie.indexOf(";",startOfCookie);
		result = unescape(myCookie.substring(startOfCookie, endOfCookie));
	}
	return result;
}
function readSelectIndex(p_obj)
{
	return document.getElementById(p_obj).options[document.getElementById(p_obj).selectedIndex].value;
}
function saveMode()
{
	SetCookie("sinaBlogReadNo1", readSelectIndex("no1"));
	SetCookie("sinaBlogReadNo2", readSelectIndex("no2"));
	SetCookie("sinaBlogReadNo3", readSelectIndex("no3"));
	SetCookie("sinaBlogReadNo4", readSelectIndex("no4"));
	SetCookie("sinaBlogReadNo5", readSelectIndex("no5"));
	alert("设置保存成功");
}

function readCookieMode()
{
	if ( GetCookie("sinaBlogReadNo1") != "" && GetCookie("sinaBlogReadNo1") != null)
	{
		setBgColor(GetCookie("sinaBlogReadNo1"));
		setSelect("no1", GetCookie("sinaBlogReadNo1"));
		setFontStyle(GetCookie("sinaBlogReadNo2"));
		setSelect("no2", GetCookie("sinaBlogReadNo2"));
		setFontSize(GetCookie("sinaBlogReadNo3"));
		setSelect("no3", GetCookie("sinaBlogReadNo3"));
		setFontColor(GetCookie("sinaBlogReadNo4"));
		setSelect("no4", GetCookie("sinaBlogReadNo4"));
		setStep(GetCookie("sinaBlogReadNo5"));
		setSelect("no5", GetCookie("sinaBlogReadNo5"));
	}
	else
	{
		setBgColor("#eef9fc");
		setFontStyle("宋体");
		setFontSize("14px");
		setFontColor("#000");
		setStep("100");
	}
}

function getXY(p_id)
{
	var sumTop=0,sumLeft=0;
	while(p_id!=document.body)
	{
		sumTop	+= parseInt(p_id.offsetTop);
		sumLeft	+= parseInt(p_id.offsetLeft);
		p_id	= p_id.offsetParent;
	}
	return {left:sumLeft,top:sumTop}
}

function cancel_bubble(moz)
{
	moz.cancelBubble	= true;
}

window.onresize			= function ()
{
	i_text.style.height		= parseInt(document.body.clientHeight) - parseInt(document.getElementById('menu').clientHeight);
}

i_text.style.height		= parseInt(document.body.clientHeight) - parseInt(document.getElementById('menu').clientHeight);

document.onmousedown	= sc;
document.ondblclick		= initialize;

readCookieMode();

