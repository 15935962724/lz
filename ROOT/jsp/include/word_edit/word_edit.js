
var sRTE;
var FacePath = "/jsp/include/word_edit/";
function word(sNodeBox, oArea)
{
	var oHead = new Object;
	var oBody = new Object;
	//var oArea = document.createElement("textarea");
        var sHTML=oArea.value;

	var posArr = [
	{w: 3, x: -2},
	{w: 20, x: -5, t: "撤销", func: "Undo", id: "a1"},
	{w: 20, x: -25, t: "重做", func: "Redo", id: "a2"},
	{w: 2, x: 0, id: "a3"},
	{w: 20, x: -45, t: "剪切", func: "Cut", id: "b1"},
	{w: 20, x: -65, t: "复制", func: "Copy", id: "b2"},
	{w: 20, x: -85, t: "粘贴", func: "Paste", id: "b3"},
	{w: 2, x: 0, id: "b4"},
	{w: 20, x: -225, t: "粗体", func: "Bold", id: "c1"},
	{w: 20, x: -245, t: "斜体", func: "Italic", id: "c2"},
	{w: 20, x: -265, t: "下划线", func: "Underline", id: "c3"},
	{w: 2, x: 0, id: "c4"},
	{w: 20, x: -285, t: "左对齐", func: "justifyleft", id: "d1"},
	{w: 20, x: -305, t: "居中", func: "justifycenter", id: "d2"},
	{w: 20, x: -325, t: "右对齐", func: "justifyright", id: "d3"},
	{w: 20, x: -345, t: "两端对齐", func: "justifyfull", id: "d4"},
	{w: 2, x: 0, id: "d5"},
	{w: 20, x: -145, t: "添加图片", func: "img", id: "e1"},
	{w: 20, x: -105, t: "插入链接", func: "link", id: "e2"},
	{w: 20, x: -125, t: "插入表格", func: "table", id: "e3"},
	{w: 20, x: -465, t: "插入UBB表情", func: "face", id: "e4"},
	{w: 20, x: -485, t: "插入文字框", func: "textarea", id: "e5"},
	{w: 20, x: -759, t: "跟踪链接", func: "cclink", id: "e6"},
	{w: 2, x: 0, id: "e4"},
	{w: 20, x: -165, t: "横线", func: "inserthorizontalrule", id: "f1"},
	{w: 20, x: -185, t: "文本颜色", func: "forecolor", id: "f2"},
	{w: 20, x: -205, t: "背景色", func: "hilitecolor", id: "f3"},
	{w: 2, x: 0, id: "f4"},
	{w: 40, x: -505, t: "段落样式", func: "formatblock", id: "g1"},
	{w: 40, x: -545, t: "字体", func: "fontname", id: "g2"},
	{w: 60, x: -585, t: "字体大小", func: "fontsize", id: "g3"},
	{w: 2, x: 0, id: "g4"},
	{w: 20, x: -365, t: "编号列表", func: "insertorderedlist", id: "h1"},
	{w: 20, x: -385, t: "项目符号列表", func: "insertunorderedlist", id: "h2"},
	{w: 20, x: -405, t: "减少缩进", func: "outdent", id: "h3"},
	{w: 20, x: -425, t: "增加缩进", func: "indent", id: "h4"},
	{w: 2, x: 0, id: "h5"},
    	{w: 20, x: -839, t: "插入word文件内容", func: "filecontent", id: "j1"},
      	{w: 2, x: 0, id: "j2"},
	{w: 20, x: -445, t: "功能", func: "editmenu"}
	];
	oHead["table"] = document.createElement("table");
	oHead["table"].cellSpacing = "0px";
	oHead["table"].cellPadding = "0px";
	oHead["table"].border = "0px";
	oHead["table"].id = sNodeBox + "Table";
	oHead["table"].className = "editerToolsBox";

	oHead["tbody"] = document.createElement("tbody");
	oHead["tr"] = document.createElement("tr");
	oHead["td"] = document.createElement("td");
	oHead["td"].className = "editerToolsBG";
	for(var i = 0; i < posArr.length; i ++)
        {
		oHead["items"] = document.createElement("img");
		posArr[i]["id"] ? oHead["items"].id = posArr[i]["id"] : function(){};
		oHead["items"].src = "/tea/image/editor/blank.gif";
		oHead["items"].style.margin = "1px";
		oHead["items"].className = "editerToolsIMG";
		oHead["items"].style.width = posArr[i]["w"];
		oHead["items"].style.backgroundPosition = posArr[i]["x"] + "px 0px";
		if(posArr[i]["func"] != null)
                {
			oHead["items"].title = posArr[i]["t"];
			oHead["items"]["func"] = posArr[i]["func"];
			oHead["items"].onmouseover = function ()
                        {
				var bp = this.style.backgroundPosition;
				this.style.backgroundPosition = bp.split(" ")[0] + " -20px";
			}
			oHead["items"].onmouseout = function ()
                        {
				var bp = this.style.backgroundPosition;
				this.style.backgroundPosition = bp.split(" ")[0] + " 0px";
			}
			/*
			oHead["items"].onmousedown = function () {
				var bp = this.style.backgroundPosition;
				this.style.backgroundPosition = bp.split(" ")[0] + " -25px";
			}
			oHead["items"].onmouseup = function () {
				var bp = this.style.backgroundPosition;
				this.style.backgroundPosition = bp.split(" ")[0] + " -20px";
			}
			*/
			oHead["items"].onclick = function ()
                        {
				wordChiCommand(this["func"]);
			}
		}
		oHead["td"].appendChild(oHead["items"]);
	}
	oHead["tr"].appendChild(oHead["td"]);
	oHead["td"] = document.createElement("td");
	oHead["td"].id = "editerArrow";
	oHead["td"].className = "editerArrowUp";
	oHead["td"].innerHTML = "<img width='18' border='0' src='/tea/image/editor/blank.gif' />";
	oHead["tr"].appendChild(oHead["td"]);
	oHead["tbody"].appendChild(oHead["tr"]);
	oHead["table"].appendChild(oHead["tbody"]);
	document.getElementById(sNodeBox).appendChild(oHead["table"]);

	oBody["table"] = document.createElement("table");
	oBody["table"].cellSpacing = "0px";
	oBody["table"].cellPadding = "0px";
	oBody["table"].border = "0px";
	oBody["table"].className = "editerTextBox";
	oBody["table"].id = "editerTextBox";

	oBody["tbody"] = document.createElement("tbody");
	oBody["tr"] = document.createElement("tr");
	oBody["td"] = document.createElement("td");
	oBody["td"].className = "editerTextTopBG";
        oBody["td"].colSpan=3;
	oBody["tr"].appendChild(oBody["td"]);
	oBody["tbody"].appendChild(oBody["tr"]);

	oBody["tr"] = document.createElement("tr");
	oBody["td"] = document.createElement("td");
	oBody["td"].className = "editerTextBGLeft";//"editerTextBG";
  	oBody["tr"].appendChild(oBody["td"]);

	oBody["td"] = document.createElement("td");
	oBody["td"].id = sNodeBox + "Iframes";
	oBody["tr"].appendChild(oBody["td"]);

        oBody["td"] = document.createElement("td");
	oBody["td"].className = "editerTextBGRight";//"editerTextBG";
  	oBody["tr"].appendChild(oBody["td"]);
	oBody["tbody"].appendChild(oBody["tr"]);

	oBody["tr"] = document.createElement("tr");
	oBody["td"] = document.createElement("td");
	oBody["td"].className = "editerTextBottomBG";
	oBody["input"] = document.createElement("input");
	oBody["input"].type = "checkbox";
	oBody["input"].id = "EditerCMD";
	function oInputFunc()
        {
		var oRTE = getFrameNode(sRTE);
		oRTE.focus();
		var sEditBox = document.getElementById(sNodeBox + "Table");
		var sEditMode = sEditBox.style.display == "none" ? true : false;
		if(sEditMode)
                {
			sEditBox.style.display = "";
			if(!window.Event)
                        {
				var sOutText = escape(oRTE.document.body.innerText);
				sOutText = sOutText.replace("%3CP%3E%0D%0A%3CHR%3E", "%3CHR%3E");
				sOutText = sOutText.replace("%3CHR%3E%0D%0A%3C/P%3E", "%3CHR%3E");
				oRTE.document.body.innerHTML = unescape(sOutText);
			}else
                        {
				var oMozText = oRTE.document.body.ownerDocument.createRange();
				oMozText.selectNodeContents(oRTE.document.body);
				oRTE.document.body.innerHTML = oMozText.toString();
			}
		}else
                {
			sEditBox.style.display = "none";
			if(! window.Event)
                        {
				oRTE.document.body.innerText = oRTE.document.body.innerHTML;
			}else
                        {
				var oMozText = oRTE.document.createTextNode(oRTE.document.body.innerHTML);
				oRTE.document.body.innerHTML = "";
				oRTE.document.body.appendChild(oMozText);
			}
		}
	}
	oBody["input"].onclick = oInputFunc;
	oBody["label"] = document.createElement("label");
	oBody["label"].style.fontSize = '12px';
	oBody["label"].htmlFor = "EditerCMD"
	oBody["label"].innerHTML = "显示源代码";
	oBody["td"].appendChild(oBody["input"]);
	oBody["td"].appendChild(oBody["label"]);
	oBody["tr"].appendChild(oBody["td"]);

  oBody["td"] = document.createElement("td");
        oBody["td"].className = "editerTextBottomBG";
        oBody["tr"].appendChild(oBody["td"]);

        oBody["td"] = document.createElement("td");
        oBody["td"].className = "editerTextBottomBG";
        oBody["a"] = document.createElement("a");
        oBody["a"].href="javascript:setSzie('"+sNodeBox+"',-20);";
        oBody["img"] = document.createElement("img");
        oBody["img"].src = "/tea/image/editor/minus.gif";
        oBody["a"].appendChild(oBody["img"]);
        oBody["td"].appendChild(oBody["a"]);

        oBody["a"] = document.createElement("a");
        oBody["a"].href="javascript:setSzie('"+sNodeBox+"',20);";
        oBody["img"] = document.createElement("img");
        oBody["img"].src = "/tea/image/editor/plus.gif";
        oBody["a"].appendChild(oBody["img"]);
        oBody["td"].appendChild(oBody["a"]);

        oBody["tr"].appendChild(oBody["td"]);
	oBody["tbody"].appendChild(oBody["tr"]);

	oBody["table"].appendChild(oBody["tbody"]);
	document.getElementById(sNodeBox).appendChild(oBody["table"]);

	sRTE = sNodeBox + "_area";
	document.getElementById(sNodeBox + "Iframes").innerHTML = "<iframe frameborder='0' scrolling='yes' id=" + sRTE + " class='editerTextArea'></iframe>";

	//oArea.name = sNodeBox;
	oArea.id = sNodeBox + "_textarea";
	oArea.style.display = "none";
	//oArea.value = sHTML;
	//document.getElementById(sNodeBox).appendChild(oArea);


          this.save	= function()
          {
            if(document.getElementById(sNodeBox).style.display=="")
            {
                  if(oBody["input"].checked == true)
                  {
                          oInputFunc();
                          oBody["input"].checked = false;
                  }
                  var oRTE = getFrameNode(sRTE);
                  oRTE.focus();
                  var sEditBox = document.getElementById(sNodeBox + "Table");
                  var sEditMode = sEditBox.style.display == "none" ? true : false;

                  if(sEditMode)
                  {
                          if(!indow.Event)
                          {
                                  oArea.value = oRTE.document.body.innerText;
                          }else
                          {
                                  var oMozText = oRTE.document.body.ownerDocument.createRange();
                                  oMozText.selectNodeContents(oRTE.document.body);
                                  oArea.value = oMozText.toString();
                          }
                  }else
                  {
                          oArea.value = oRTE.document.body.innerHTML;
                  }

                  var lo=document.location.href;
                  lo="=\""+lo.substring(0,lo.indexOf("/",8)+1);
                  while(oArea.value.indexOf(lo)!=-1)
                  {
                    oArea.value=oArea.value.replace(lo,"=\"/");
                  }
            }
          }

	function writeDesignMode(sNodeBox, sHTML)
        {
		enableDesignMode(sNodeBox, "on");
		var sFix = window.Event ? "" : "<div></div>";
		var frameHTML = "\
		<html>\n\
		<head>\n\
		<style>\n\
		body {\n\
			background: #ffffff;\n\
			margin:0px;\n\
			padding:0px;\n\
			font-size:12px;\n\
			overflow:auto;\n\
			scrollbar-face-color:#fff;\n\
			scrollbar-highlight-color:#c1c1bb;\n\
			scrollbar-shadow-color:#c1c1bb;\n\
			scrollbar-3dlight-color:#ebebe4;\n\
			scrollbar-arrow-color:#cacab7;\n\
			scrollbar-track-color:#f4f4f0;\n\
			scrollbar-darkshadow-color:#ebebe4;\n\
			word-wrap: break-word;\n\
			font-family: 'Courier New', Courier, '宋体';\n\
		}\n\
		</style>\n\
		</head>\n\
		<body>\n\
		" + sHTML + "\n\
		" + sFix + "\n\
		</body>\n\
		</html>";
		var oRTE = getFrameNode(sNodeBox).document;
		oRTE.open();
		oRTE.write(frameHTML);
		oRTE.close();
	}

	writeDesignMode(sRTE, sHTML);

	saveWordStatus();
}

function getFrameNode(sNode)
{
	return document.frames ? document.frames[sNode] : document.getElementById(sNode).contentWindow;
}

function enableDesignMode(sNodeBox, sMode)
{
	document.frames ? document.frames[sNodeBox].document.designMode = sMode : document.getElementById(sNodeBox).contentDocument.designMode = sMode;
}

function wordChiCommand(_sCmd)
{
	var oRTE = document.frames ? document.frames[sRTE] : document.getElementById(sRTE).contentWindow;
	function oPenWin(_sTitle, _sWidth, _sHeight, _sUrl, _bDialog)
        {
		if(window.Event)
                {
			window.open(_sUrl,"win","menubar=no,location=no,resizable=no,scrollbars=no,status=no,innerWidth="+(_sWidth+0)+",innerHeight="+(_sHeight + 0));
		}else
                {
			if(_bDialog == true)
                        {
				showModelessDialog(_sUrl, window, "dialogHeight:"+(_sHeight+20)+"px;dialogWidth:"+_sWidth+"px;status:no;help:no;tustatus:no;");
			}else
                        {
				showModalDialog(_sUrl, window, "dialogHeight:"+(_sHeight+20)+"px;dialogWidth:"+_sWidth+"px;status:no;help:no;tustatus:no;");
			}
		}
	}
	switch(_sCmd)
        {
		case "":
			break;
		case "face":
			oPenWin("插入表情图标", 280, 156, FacePath+"Face.html");
			break;
		case "link":
			oPenWin("请输入网页地址", 300, 140, FacePath+"InsertLink.html");
			break;
		case "table":
			oPenWin("请选择表格属性", 300, 240, FacePath+"InsertTable.html");
			break;
		case "img":
			oPenWin("请输入图片地址", 300, 140, FacePath+"InsertImg.html");
			break;
		case "forecolor":
			oPenWin("请选择文本颜色", 140, 162, FacePath+"ForeColor.html", true);
			break;
		case "hilitecolor":
			oPenWin("请选择背景颜色", 140, 162, FacePath+"BackColor.html", true);
			break;
		case "formatblock":
			oPenWin("请选择段落风格", 160, 242, FacePath+"FormatBlock.html", true);
			break;
		case "fontsize":
			oPenWin("请选择字体大小", 160, 186, FacePath+"FontSize.html", true);
			break;
		case "fontname":
			oPenWin("请选择字体样式", 160, 280, FacePath+"FontName.html", true);
			break;
		case "editmenu":
			oPenWin("开启功能列表", 156, 250, FacePath+"menu.html");
			break;
		case "textarea":
			insetQUER();
			break;
		case "cclink":
			insetCCLink();
			break;
                case "filecontent":
                        oPenWin("插入word文件内容", 300, 140, FacePath+"InsertFContent.html");
                        break;
		default:
			oRTE.focus();
			oRTE.document.execCommand(_sCmd, false, null);
			oRTE.focus();
			break;
	}
}
function insetQUER()
{
	var _sVal;
	var rng = {};
	var oRTE = getFrameNode(sRTE);
	if (document.all)
        {
		var selection = oRTE.document.selection;
		if (selection != null)
                {
			rng = selection.createRange();
		}
	} else
        {
		var selection = oRTE.getSelection();

		rng = selection.getRangeAt(selection.rangeCount - 1).cloneRange();
		rng.text = rng.toString();
	}
	_sVal = rng.text == "" ? "请在文本框输入文字" : rng.text;
	var html = "<table style='border:1px solid #999;width:80%;font-size:12px;' align='center'><tr><td>"+ _sVal +"</td></tr></table>";
	if(window.Event)
        {
		oRTE.document.execCommand('insertHTML', false, html);
	}else
        {
		oRTE.focus();
		var oRng = oRTE.document.selection.createRange();
		oRng.pasteHTML(html);
		oRng.collapse(false);
		oRng.select();
	}
}
function insetCCLink()
{
	var _sVal;
	var rng = {};
	var oRTE = getFrameNode(sRTE);
	if (document.all)
        {
		var selection = oRTE.document.selection;
		if (selection != null)
                {
			rng = selection.createRange();
		}
	} else
        {
		var selection = oRTE.getSelection();

		rng = selection.getRangeAt(selection.rangeCount - 1).cloneRange();
		rng.text = rng.toString();
	}
	_sVal = rng.text == "" ? "请输入需要跟踪的文字" : rng.text;
	var html = "<a href=\"http://www.google.cn/search?q="+ (_sVal)+"\" target='_blank'>"+ _sVal +"</a>";
	if(window.Event)
        {
		oRTE.document.execCommand('insertHTML', false, html);
	}else
        {
		oRTE.focus();
		var oRng = oRTE.document.selection.createRange();
		oRng.pasteHTML(html);
		oRng.collapse(false);
		oRng.select();
	}
}
function getStatus()
{
	var sFunc = getCookie("sinaBlogWordFunc") ? getCookie("sinaBlogWordFunc").split("_") : [];
	for(var i = 0; i < sFunc.length; i++)
        {
		hideList(sFunc[i]);
	}
}
function getCookie(name)
{
	var result = null;
	var myCookie = document.cookie + ";";
	var searchName = name + "=";
	var startOfCookie = myCookie.indexOf(searchName);
	var endOfCookie;
	if (startOfCookie != -1)
	{
		startOfCookie += searchName.length;
		endOfCookie = myCookie.indexOf(";", startOfCookie);
		result = unescape(myCookie.substring(startOfCookie, endOfCookie));
	}
	return result;
}
function setCookie(name, value, expires, path, domain, secure)
{
	var expDays = expires * 24 * 60 * 60 * 1000;
	var expDate = new Date();
	expDate.setTime(expDate.getTime() + expDays);
	var expString = ((expires == null) ? "" : (";expires=" + expDate.toGMTString()))
	var pathString = ((path == null) ? "" : (";path=" + path))
	var domainString = ((domain == null) ? "" : (";domain=" + domain))
	var secureString = ((secure == true) ? ";secure" : "" )
	document.cookie = name + "=" + escape(value) + expString + pathString + domainString + secureString;
}
function hide(_sId)
{
  document.getElementById(_sId).style.display = document.getElementById(_sId).style.display == "none" ? "" : "none" ;
}

function swap(s,a,b,c)
{
  document.getElementById(s)[a]=document.getElementById(s)[a]==b?c:b;
}

function saveWordStatus(_sFunc)
{
	var i = 1;
	var sFuncId = [];

	if(!_sFunc)
        {
		_sFunc = getCookie("sinaBlogWordFunc") != null ? getCookie("sinaBlogWordFunc").split("_") : [];
	}
	for(var j = 0;j < _sFunc.length; j++)
        {
		i = 1;
		sFuncId = _sFunc[j].split("@");
		while(document.getElementById(sFuncId[0] + i))
                {
			document.getElementById(sFuncId[0] + i).style.display = sFuncId[1] == "true" ? "none" : "";
			i++;
		}
		sFuncId = [];
	}

	setCookie("sinaBlogWordFunc", _sFunc.join("_"), 7);
}

function setSzie(sNodeBox,value)
{
  var table=document.getElementById(sNodeBox+"Table");
  if(isNaN(parseInt(table.style.width)))
  {
    table.style.width=639;
  }
  var table_w=parseInt(table.style.width)+value;
  if(table_w>=639)
  {
    table.style.width=table_w;
  }

  var _area=document.getElementById(sNodeBox+"_area");
  if(isNaN(parseInt(_area.style.height)))
  {
    _area.style.height=343;
    _area.style.width=500;
  }
  var area_h=parseInt(_area.style.height)+value;
  var area_w=parseInt(_area.style.width)+value;
  if(area_w>=500)
  {
    //_area.style.height=area_h;
    _area.style.width=area_w;
  }



}
