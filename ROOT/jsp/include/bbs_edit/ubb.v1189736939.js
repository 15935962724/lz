
window.onerror=function(){return true}
String.prototype.inc=function(s){return this.indexOf(s)>-1?true:false}
var agent=navigator.userAgent
var isOpr=agent.inc("Opera")
var isIE=agent.inc("IE")&&!isOpr
var isMoz=agent.inc("Mozilla")&&!isOpr&&!isIE
if(isMoz)
{
	Event.prototype.__defineGetter__("srcElement",function(){var node=this.target;while(node.nodeType!=1){node=node.parentNode}return node})
}
if( typeof $ == 'undefined' )
{
	function $(obj){return document.getElementById(obj)}
}
function ow(win){return $(win).contentWindow}

function getxy(e)
{
  var a=new Array()
  var t=e.offsetTop;
  var l=e.offsetLeft;
  var w=e.offsetWidth;
  var h=e.offsetHeight;
  while(e=e.offsetParent)
  {
    t+=e.offsetTop;
    l+=e.offsetLeft;
  }
  a[0]=t;
  a[1]=l;
  a[2]=w;
  a[3]=h
  return a;
}

var editHTML=isIE?wEdit.window:$("wEdit").contentWindow
var doc=editHTML.document
doc.designMode="on"
if(isMoz){doc.write("<style>a,td,div,p{font-size:14;font-family:宋体;line-height:28px;margin:0px}\nbody{background:url(images/edit_bg.gif);padding-top:0px;margin:0px;font-size:12;font-family:宋体;line-height:28px}</style><br>")}
doc.close()
editHTML.focus()

function bar_event(e)
{
	e=e||event
	var etp=e.type
	var ee=e.srcElement
	if(ee.tagName!="IMG")
		return
	var cmd=ee.getAttribute("src").replace(/(^\S*)\/(\w*)(.gif)/gi,"$2")
	if(cmd=="gd")
		return
	if(etp=="mouseover"||etp=="mouseup")
	{
		ee.style.cssText="background:#D1E1F4; border:1px solid #7691ac; border-top:1px solid #FFF;border-left:1px solid #FFF";
		if("|img|face|table|font|size|color|".inc("|"+cmd+"|"))
		{
			createmenu(cmd,ee)
		}else
		{
                  $("wEditorMenu").style.display="none"
                }
	}
	if(etp=="mousedown")
	{
		ee.style.cssText="background:#95B7E0;border:1px solid #FFF;border-top:1px solid #63759D;border-left:1px solid #63759D"
		if(!"|img|face|table|font|size|color|".inc("|"+cmd+"|"))
		{
			hte_exc(cmd)
		}
	}
	if(etp=="mouseout")
	{
		ee.style.cssText=""
	}
}

function createmenu(cmd,obj)
{
  var lx=0
  if(cmd=="color"||cmd=="table")
  {
    lx=120
  }
  var m=$("wEditorMenu")
  var a=getxy(obj)
  m.style.top=(a[0]+21)+"px"
  m.style.left=(a[1]+2-lx)+"px"
  m.style.display=""
  ow("wEditorMenu").menu_ini(cmd)
}

function hte_exc(cmd,key,run)
{
	var w=editHTML,a,v
	w.focus()
	w.range=isIE ? w.document.selection.createRange() : w.getSelection()
	switch(cmd){
		case "family":
			w.document.execCommand('FontName',false,key)
			break
		case "size":
//			if(isIE){
//				var seltxt=w.range.htmlText
		//		var seltxt=w.range.text
				var s=new Array(7,9,12,14,18,24,30)
//				var html="<span style='font-size:"+s[key-1]+"px!important'>"+seltxt+"</span>"
//				w.document.selection.createRange().pasteHTML(html)
//			}else{
				w.document.execCommand('fontsize',false,key)
//			}
			break
		case "color":
//			if(isIE){
//				var seltxt=w.range.text
//				var html="<span style='color:"+key+"!important'>"+seltxt+"</span>"
//				w.document.selection.createRange().pasteHTML(html)
//			}else{
				w.document.execCommand('forecolor',false,key)
//			}
			break
		case "a":
//			if(isIE)
//				w.document.execCommand('createlink')
//			else{
				v=prompt("请输入链接路径","http://")
				if(v==""||v=="http://"||v==null)
					return
				w.document.execCommand('createlink',false,v)
//			}
			break
		case "img":
			v=prompt("请输入您要插入的图片链接地址","http://")
			if(v==""||v=="http://"||v==null)
				return
			w.document.execCommand('insertimage',false,v)
			break
		case "flash":
			v=prompt("请输入flash路径","http://")
			if(v==""||v=="http://"||v==null)
				return
			if(!/swf/i.test(v)){
				alert("不是flash文件")
				return
			}
			if(isIE){
				var html='<embed src="'+v+'" quality=high type="application/x-shockwave-flash" wmode=transparent width="470" height="460"></embed>'
				w.document.selection.createRange().pasteHTML(html)
			}else{
				var flash=document.createElement("embed")
				flash.setAttribute("scr",v)
				flash.type="application/x-shockwave-flash"
				flash.style.cssText="width:400px;height:200px"
				w.document.body.appendChild(flash)
				alert("flash已经插入成功，非IE浏览器，没有预览功能")
			}
			break
		case "wmv":
			v=prompt("请输入您要插入的视频链接地址","http://")
			if(v==""||v=="http://"||v==null)
				return
			if(/.swf/i.test(v)){
				alert("不能插入flash文件")
				return
			}
			if(/.asx/i.test(v)){
				alert("不能插入ASX文件")
				return
			}
			var html='<embed src="'+v+'" autostart="true" loop="true" width="400" height="300" wmode=transparent></embed>'
			if(isIE){
				w.document.selection.createRange().pasteHTML(html)
			}else{
				var wmv=document.createElement("div")
				wmv.style.cssText="width:300px;height:200px"
				wmv.innerHTML=html
				w.document.body.appendChild(wmv)
				alert("视频已经插入成功，非IE浏览器，没有预览功能")
			}
			break
		case "v":
			v=prompt("请输入您要插入的新浪播客视频地址\n更多视频请进入http://you.video.sina.com.cn","http://")
			if(v==""||v=="http://"||v==null)
				return
			if(!v.inc("sina.com.cn")){
				alert("您插入的不是新浪播客视频")
				return
			}
			var html='<embed src="'+v+'" autostart="true" loop="true" width="474" height="461" wmode=transparent></embed>'
			if(isIE){
				w.document.selection.createRange().pasteHTML(html)
			}else{
				var wmv=document.createElement("div")
				wmv.style.cssText="width:474px;height:461px"
				wmv.innerHTML=html
				w.document.body.appendChild(wmv)
				alert("视频已经插入成功，非IE浏览器，没有预览功能")
			}
			break
		case "images":
			w.document.execCommand('insertimage',false,key)
			break
		case "face":
			if(key==null)
				return
			w.document.execCommand('insertimage',false,"/tea/image/face/"+key+".gif")
			break
		case "table":
			var a=key.split(",")
			if(isIE){
				v="<table width='"+a[2]+(a[3]==0?"":"%")+"' border='"+a[4]+"' cellspacing='"+a[6]+"' cellpadding='"+a[5]+"'>"
				for(var i=0;i<a[0];i++){
					v+="<tr>"
						for(var j=0;j<a[1];j++){
							v+="<td>&nbsp;</td>"
						}
					v+="</tr>"
				}
				v+="</table>"
				w.document.selection.createRange().pasteHTML(v)
			}else{
				var table=document.createElement("table")
				table.cellspacing=a[6]
				table.cellpadding=a[5]
				table.border=a[4]
				table.width=a[2]+(a[3]==0?"":"%")
				var tbody=document.createElement("tbody");
				table.appendChild(tbody)
				for(var i=0;i<a[0];i++){
					var tr=document.createElement("tr")
					tbody.appendChild(tr)
					for(var j=0;j<a[1];j++){
						var td=document.createElement("td")
						td.innerHTML="&nbsp;"
						tr.appendChild(td)
					}
				}
				w.document.body.appendChild(table)
			}
			$("wEditorMenu").style.display="none"
			break
		default:
			w.document.execCommand(cmd,false,null)
			break
	}
}

document.body.onclick=f_mh;

function f_mh()
{
  $("wEditorMenu").style.display="none";
}
