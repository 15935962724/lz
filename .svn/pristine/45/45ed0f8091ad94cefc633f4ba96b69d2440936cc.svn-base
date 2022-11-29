<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Sound");

%>
















<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script language="JavaScript" type="text/javascript" src="/tea/CssJs/JSDateFunction.js">

</script>
<script language="javascript" src="/tea/CssJs/calendar.js"></script>
<script language="JavaScript">
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function chkForm(objForm) {
	if (! isDateString(objForm.time_begin.value)) {
		alert('日期格式不正确，请重新填写！');
		objForm.time_begin.focus();
		return false;
	}
	if (! isDateString(objForm.time_end.value)) {
		alert('日期格式不正确，请重新填写！');
		objForm.time_end.focus();
		return false;
	}
	return true;
}
function isDateString(str) {
	var reg=/^\d{4}-[0-1]?\d{1}-[0-3]?\d{1}$/;
	return reg.test(str);
}
</script>
<script language="javascript">
<!--
function checkdata()
{
if (document.form1.viewhtml.checked == true)
	{
	  alert("对不起，请取消“查看HTML源代码”后再添加！")
	  document.form1.viewhtml.focus()
	  return false
	 }
if (document.form1.Content.value.length==0)
	{
	  alert("对不起，请输入文章内容！")
	  //document.form1.content.focus()
	  return false
	 }
}

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
<script language="JavaScript">
<!-- Hide from older browsers...

//Function to format text in the text box
function FormatText(command, option){

  	frames.message.document.execCommand(command, true, option);
  	frames.message.focus();
}

//Function to add image
function AddImage(){
	imagePath = prompt('请输入图片地址', 'http://');

	if ((imagePath != null) && (imagePath != "")){
		frames.message.document.execCommand('InsertImage', false, imagePath);
  		frames.message.focus();
	}
	frames.message.focus();
}

//Function to clear form
function ResetForm(){

	if (window.confirm('确认要清空对话框内容?')){
	 	frames.message.document.body.innerHTML = '';
	 	return true;
	 }
	 return false;
}

//Function to open pop up window
function openWin(theURL,winName,features) {
  	window.open(theURL,winName,features);
}

function setMode(newMode)
{
  bTextMode = newMode;
  var cont;
  if (bTextMode) {
    cleanHtml();
    cleanHtml();

    cont=message.document.body.innerHTML;
    message.document.body.innerText=cont;
  } else {
    cont=message.document.body.innerText;
    message.document.body.innerHTML=cont;
  }
  message.focus();
}

function cleanHtml()
{
  var fonts = message.document.body.all.tags("FONT");
  var curr;
  for (var i = fonts.length - 1; i >= 0; i--) {
    curr = fonts[i];
    if (curr.style.backgroundColor == "#ffffff") curr.outerHTML	= curr.innerHTML;
  }

}

// -->
</script>
<script language="JavaScript">

function help()
{
    var helpmess;
    helpmess="---------------填写帮助---------------\r\n\r\n"+
         "1.请不要发表有危险性的脚本。\r\n\r\n"+
         "2.如果要书写源代码，请选中\r\n\r\n"+
         "　查看HTML源代码书写.\r\n\r\n"+
         "3.需要你自己运行,才能看效果.\r\n\r\n"+
         "4.如果书写js，尽量不要在这儿书写.\r\n\r\n";
    alert(helpmess);
}
</script>
<script src="/tea/CssJs/edit.js" type="text/javascript"></script>
<script>
function IsDigit()
{
  return ((event.keyCode >= 48) && (event.keyCode <= 57));
}
</script>

<script language="JavaScript">
subcat = new Array();
subcatz = new Array();

subcat[0] = new Array("大陆影片","1","852");

subcat[1] = new Array("大陆剧集","2","853");

subcat[2] = new Array("欧美流行","3","855");

subcat[3] = new Array("相声","5","859");

subcat[4] = new Array("历史地理","6","9580");

subcat[5] = new Array("大陆动画","4","9246");

subcat[6] = new Array("历史地理","0","9579");

subcat[7] = new Array("历史地理","7","9611");

subcat[8] = new Array("港台剧集","2","854");

subcat[9] = new Array("港台流行","3","856");

subcat[10] = new Array("小品","5","860");

subcat[11] = new Array("港台影片","1","1202");

subcat[12] = new Array("人文探索","6","9581");

subcat[13] = new Array("军事战争","7","9612");

subcat[14] = new Array("日韩动画","4","9248");

subcat[15] = new Array("西方动漫","4","10660");

subcat[16] = new Array("戏剧","5","861");

subcat[17] = new Array("欧美影片","1","1203");

subcat[18] = new Array("日本剧集","2","1211");

subcat[19] = new Array("人文探索","7","9613");

subcat[20] = new Array("大陆流行","3","1223");

subcat[21] = new Array("性教育","6","9582");

subcat[22] = new Array("艺术百类","7","9614");

subcat[23] = new Array("日韩影片","1","1204");

subcat[24] = new Array("韩国剧集","2","1212");

subcat[25] = new Array("古典音乐","3","1224");

subcat[26] = new Array("歌舞剧","5","1239");

subcat[27] = new Array("军事战争","6","9583");

subcat[28] = new Array("其他地区剧集","2","9243");

subcat[29] = new Array("其他地区影片","1","9244");

subcat[30] = new Array("综艺/晚会","5","1240");

subcat[31] = new Array("传记名人","7","9615");

subcat[32] = new Array("话剧","5","9604");

subcat[33] = new Array("轻音乐","3","1226");

subcat[34] = new Array("杂技/魔术","5","9605");

subcat[35] = new Array("生活休闲","6","9586");

subcat[36] = new Array("演唱会","3","2444");

subcat[37] = new Array("卡拉OK/MTV","3","1228");

subcat[38] = new Array("其他曲艺","5","9606");

subcat[39] = new Array("民族音乐","3","9245");

subcat[40] = new Array("中华武术","6","9608");

subcat[41] = new Array("儿童音乐","3","9602");

subcat[42] = new Array("饮食烹饪","6","9609");

subcat[43] = new Array("音乐美术","6","9610");

subcat[44] = new Array("宗教音乐","3","10664");

subcat[45] = new Array("动植物语","6","10661");

subcat[46] = new Array("儿童幼教","6","10663");


function changelocation(locationid)
{
    document.myform.nclassid.length = 0;
    document.myform.zclassid.length = 0;

    var locationid=locationid;
    var i;
    var j;
    var k;
    j=1;
    for (i=0;i < 47; i++)
    {
            if (subcat[i][1] == locationid)
            { //这句不是很理解
            if (j==1)
            {
            j=2;
            k=subcat[i][2];
            };
             document.myform.nclassid.options[document.myform.nclassid.length] = new Option(subcat[i][0], subcat[i][2]);
            }
    }
    changelocationz(k);
}



function changelocationz(locationid)
{
    document.myform.zclassid.length = 0;

    var locationid=locationid;
    var i;
    for (i=0;i < 0; i++)
    {
            if (subcatz[i][1] == locationid)
            { //这句不是很理解
             document.myform.zclassid.options[document.myform.zclassid.length] = new Option(subcatz[i][0], subcatz[i][2]);
            }
    }
    document.myform.zclassid.options[document.myform.zclassid.length] = new Option("请选择专题","0");

}
</script>
<body >
<h1><%=r.getString(teasession._nLanguage, "EditSound")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
   <br>
   
                         <form name="myform" method="post" action="/servlet/EditSound">
                     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                        <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
          tea.entity.node.Sound sound = tea.entity.node.Sound.find(0, teasession._nLanguage);
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="";
String text="";
   String issueDate=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date());
            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {subject=node.getSubject(teasession._nLanguage);
		 text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
         issueDate=new java.text.SimpleDateFormat("yyyy-MM-dd").format(node.getTime());
		 sound = tea.entity.node.Sound.find(teasession._nNode, teasession._nLanguage);
        }
            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <input type="hidden" name="node" value="<%=teasession._nNode%>">
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Type")%>： </td>
                          <td colspan="2"> <%=r.getString(teasession._nLanguage, "Bigtype")%>： <select name="anclassid" size="1" id="anclassid" onChange="changelocation(document.myform.anclassid.options[document.myform.anclassid.selectedIndex].value)">

                          <option value="1" selected
>
                          电 影</option>

                          <option value="2"  <%=getCheck(sound.getBigtype().equals("2"))%>>
                          电视剧</option>

                          <option value="3"  <%=getCheck(sound.getBigtype().equals("3"))%>>
                          音 乐</option>

                          <option value="4"  <%=getCheck(sound.getBigtype().equals("4"))%>>
                          卡 通</option>

                          <option value="5" <%=getCheck(sound.getBigtype().equals("5"))%> >
                          曲 艺</option>

                          <option value="6"  <%=getCheck(sound.getBigtype().equals("6"))%>>
                          百 科</option>
                          <option value="7" <%=getCheck(sound.getBigtype().equals("7"))%> >
                          经典纪录</option>
                          </select> <br>
                            <%=r.getString(teasession._nLanguage, "Smalltype")%>：
                          <select name="nclassid" onChange="changelocationz(document.myform.nclassid.options[document.myform.nclassid.selectedIndex].value)">

                          <option value="852">大陆影片</option>

                          <option value="1202">港台影片</option>

                          <option value="1203">欧美影片</option>

                          <option value="1204">日韩影片</option>

                          <option value="9244">其他地区影片</option>
                          </select> <br>
                          <%=r.getString(teasession._nLanguage, "Special")%>： <select name="zclassid">
                          <option selected value="0">请添加专题</option>
                          </select> <font color="#FF0000">&nbsp;</font></td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Name")%>：</td>
                          <td colspan="2">
                          <input name="goodsname" value="<%=subject%>" type="text" id="goodsname" size="35"><br>
                          <%=r.getString(teasession._nLanguage, "Pingpai")%>:<input name="pingpai" type="text" id="pingpai" size="35" value="<%=sound.getPingpai()%>">
                          </td>
                        </tr>
                        <tr>
                          <td><%=r.getString(teasession._nLanguage, "Code")%>：</td>
                          <td colspan="2">
                          <input name="isbn" value="<%=sound.getCode()%>" type="text" size="35"> </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Medium")%>：</td>
                          <td colspan="2">
                          <input name="jiezhi" type="text" value="<%=sound.getMedium()%>" id="jiezhi" size="35">
                           <select name="select2" onChange="(document.myform.jiezhi.value=document.myform.jiezhi.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="CD">
                          CD</option>

                          <option value="VCD">
                          VCD</option>

                          <option value="DVD">
                          DVD</option>

                          <option value="MP3">
                          MP3</option>
                          </select> </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Dishcount")%>：</td>
                          <td colspan="2">
                          <input name="dieshu" type="text" value="<%=sound.getDishcount()%>" id="dieshu" size="35" ONKEYPRESS="event.returnValue=IsDigit();"></td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Types")%>：</td>
                          <td colspan="2">
                          <input name="ticai" value="<%=sound.getTypes()%>" type="text" id="ticai" size="35">  <select name="select" onchange="(document.myform.ticai.value=document.myform.ticai.value+' '+this.options[this.selectedIndex].value)">
                          <option selected value="">----------</option>

                          <option value="电影">
                          电影</option>

                          <option value="电视剧">
                          电视剧</option>

                          <option value="音乐">
                          音乐</option>

                          <option value="卡通">
                          卡通</option>

                          <option value="曲艺">
                          曲艺</option>

                          <option value="百科">
                          百科</option>

                          <option value="纪录片">
                          纪录片</option>

                          <option value="其他">
                          其他</option>
                          </select> 　</td>
                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Polt")%> ：</td>
                          <td colspan="2">
                          <input name="qingjie" value="<%=sound.getPolt()%>" type="text" id="qingjie" size="35">
                           <select name="select" onchange="(document.myform.qingjie.value=document.myform.qingjie.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="生活">
                          生活
                          </option>

                          <option value="伦理">
                          伦理
                          </option>

                          <option value="动作">
                          动作
                          </option>

                          <option value="武侠">
                          武侠
                          </option>

                          <option value="爱情">
                          爱情
                          </option>

                          <option value="偶像">
                          偶像
                          </option>

                          <option value="恐怖">
                          恐怖
                          </option>

                          <option value="悬疑">
                          悬疑
                          </option>

                          <option value="喜剧">
                          喜剧
                          </option>

                          <option value="历史">
                          历史
                          </option>

                          <option value="虚幻">
                          虚幻
                          </option>

                          <option value="神话">
                          神话
                          </option>

                          <option value="惊险">
                          惊险
                          </option>

                          <option value="灾难">
                          灾难
                          </option>

                          <option value="刑侦">
                          刑侦
                          </option>

                          <option value="警匪">
                          警匪
                          </option>

                          <option value="科幻">
                          科幻
                          </option>

                          <option value="纪录">
                          纪录
                          </option>

                          <option value="军事">
                          军事
                          </option>

                          <option value="革命">
                          革命
                          </option>

                          <option value="人物">
                          人物
                          </option>

                          <option value="传记">
                          传记
                          </option>

                          <option value="名著">
                          名著
                          </option>

                          <option value="经典">
                          经典
                          </option>

                          <option value="古装">
                          古装
                          </option>

                          <option value="儿童">
                          儿童
                          </option>

                          <option value="情色">
                          情色
                          </option>

                          <option value="军旅">
                          军旅
                          </option>

                          <option value="社会">
                          社会
                          </option>
                          </select> </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Trait")%>：</td>
                          <td colspan="2">
                          <input name="tese" type="text" value="<%=sound.getTrait()%>" id="tese" size="35">  <select name="select" onchange="(document.myform.tese.value=document.myform.tese.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="经典收藏">
                          经典收藏</option>

                          <option value="英文原音">
                          英文原音</option>

                          <option value="金庸作品">
                          金庸作品</option>

                          <option value="历史大剧">
                          历史大剧</option>

                          <option value="琼瑶系列">
                          琼瑶系列</option>
                          </select> </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Synopsis")%>：</td>
                          <td colspan="2">
                          <textarea name="note" cols="46" rows="8"><%=HtmlElement.htmlToText(sound.getSynopsis())%></textarea>
                          </td>
                        </tr>
                        <tr>
                          <td valign="top">&nbsp;</td>
                          <td valign="top"> <%=r.getString(teasession._nLanguage, "Player")%>：
                          <input name="yanyuan" value="<%=sound.getPlayer()%>" type="text" id="yanyuan" size="35">
                           <select name="select" onchange="(document.myform.yanyuan.value=document.myform.yanyuan.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="周润发">
                          周润发
                          </option>

                          <option value="周星驰">
                          周星驰
                          </option>

                          <option value="张国荣">
                          张国荣
                          </option>

                          <option value="梁家辉">
                          梁家辉
                          </option>

                          <option value="刘德华">
                          刘德华
                          </option>

                          <option value="斯琴高娃">
                          斯琴高娃
                          </option>

                          <option value="宁静">
                          宁静
                          </option>

                          <option value="李连杰">
                          李连杰
                          </option>

                          <option value="陈道明">
                          陈道明
                          </option>

                          <option value="章子怡">
                          章子怡
                          </option>
                          </select> </td>
                        </tr>
                        <tr>
                          <td valign="top">&nbsp;</td>
                          <td valign="top"> <%=r.getString(teasession._nLanguage, "Direct")%>：
                          <input name="daoyan" value="<%=sound.getDirect()%>" type="text" id="daoyan" size="35">
                           <select name="select" onchange="(document.myform.daoyan.value=document.myform.daoyan.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="王晶">
                          王晶</option>

                          <option value="徐克">
                          徐克</option>

                          <option value="张艺谋">
                          张艺谋</option>

                          <option value="斯蒂文·斯皮尔伯格">
                          斯蒂文·斯皮尔伯格</option>

                          <option value="黑泽明">
                          黑泽明</option>

                          <option value="王家卫">
                          王家卫</option>
                          </select> 　</td>
                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Produce")%> ：</td>
                          <td colspan="2">
                          <input name="chupin" type="text" id="chupin" size="35" value="<%=sound.getProduce()%>">
                          </td>
                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Area")%>：</td>
                          <td colspan="2">
                          <input name="diqu" value="<%=sound.getArea()%>" type="text" id="diqu" size="35">  <select name="select" onchange="(document.myform.diqu.value=document.myform.diqu.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="欧美">
                          欧美</option>

                          <option value="日本">
                          日本</option>

                          <option value="韩国">
                          韩国</option>

                          <option value="中国大陆">
                          中国大陆</option>

                          <option value="中国香港">
                          中国香港</option>

                          <option value="中国台湾">
                          中国台湾</option>

                          <option value="港台">
                          港台</option>
                          </select> </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Caption")%>：</td>
                          <td colspan="2">
                          <input name="yuzhong" value="<%=sound.getCaption()%>" type="text" id="yuzhong" size="35">
                           <select name="select" onchange="(document.myform.yuzhong.value=document.myform.yuzhong.value+' '+this.options[this.selectedIndex].value)">
                          <option selected>----------</option>

                          <option value="国语发音">
                          国语发音
                          </option>

                          <option value="国粤语发音">
                          国粤语发音
                          </option>

                          <option value="英语发音">
                          英语发音
                          </option>

                          <option value="韩语">
                          韩语
                          </option>

                          <option value="日语">
                          日语
                          </option>

                          <option value="中文字幕">
                          中文字幕
                          </option>

                          <option value="简繁体字幕">
                          简繁体字幕
                          </option>

                          <option value="中英文字幕">
                          中英文字幕
                          </option>
                          </select> </td>
                        </tr>
                        <tr>

                          <td> ISRC：</td>
                          <td colspan="2">
                          <input name="isrc" type="text" value="<%=sound.getIsrc()%>" id="isbn" size="35">
                          </td>
                        </tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "IssueTime")%>： </td>
                          <td colspan="2">

                              <input name="counterdate" value="<%=issueDate%>" readonly type="text" id="counterdate" size="35" value="">

							   <input type=button value="..."  onClick="ShowCalendar('myform.counterdate')" ></td>


                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Text")%> ：</td>
                          <td colspan="2"><textarea cols="80" rows="20" name="text"><%=text%></textarea>
                          <input type="hidden" name="content" value>　</td></tr>
                        <tr>

                          <td> <%=r.getString(teasession._nLanguage, "Price")%>：</td>
                          <td colspan="2"><%=r.getString(teasession._nLanguage, "Price")%>1：
                          <input name="shichangjia" value="<%=sound.getPrice()%>" type="text" id="shichangjia" size="8" onKeyPress="return regInput(this,	/^\d*\.?\d{0,2}$/,		String.fromCharCode(event.keyCode))" onpaste="return regInput(this,	/^\d*\.?\d{0,2}$/,		window.clipboardData.getData('Text'))" ondrop="return regInput(this,	/^\d*\.?\d{0,2}$/,		event.dataTransfer.getData('Text'))">
                          RMB<br>
                          <%=r.getString(teasession._nLanguage, "Price")%>2：
                          <input name="huiyuanjia" value="<%=sound.getPrice2()%>"  type="text" id="huiyuanjia" size="8" onKeyPress="return regInput(this,	/^\d*\.?\d{0,2}$/,		String.fromCharCode(event.keyCode))" onpaste="return regInput(this,	/^\d*\.?\d{0,2}$/,		window.clipboardData.getData('Text'))" ondrop="return regInput(this,	/^\d*\.?\d{0,2}$/,		event.dataTransfer.getData('Text'))">
                          RMB<br>
                          <%=r.getString(teasession._nLanguage, "Price")%>3：&nbsp;
                          <input name="vipjia" value="<%=sound.getPrice3()%>"  type="text" id="huiyuanjia1" size="8" onKeyPress="return regInput(this,	/^\d*\.?\d{0,2}$/,		String.fromCharCode(event.keyCode))" onpaste="return regInput(this,	/^\d*\.?\d{0,2}$/,		window.clipboardData.getData('Text'))" ondrop="return regInput(this,	/^\d*\.?\d{0,2}$/,		event.dataTransfer.getData('Text'))">
                          RMB</td>
                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Integral")%>：</td>
                          <td colspan="2">&nbsp;<input name="jifen" value="<%=sound.getIntegral()%>" type="text" id="jifen" size="5" ONKEYPRESS="event.returnValue=IsDigit();">&nbsp;
                          <!--库存：<input name="kucun" type="text" id="kucun" size="5" value="0" ONKEYPRESS="event.returnValue=IsDigit();">-->
                          </td>
                        </tr>
                        <tr>

                          <td><%=r.getString(teasession._nLanguage, "Other")%>：</td>
                          <td colspan="2">&nbsp;
                            <input name="other" <%=getCheck(sound.getOther().indexOf("新品")!=-1)%>  id="CHECKBOX" type="CHECKBOX" value="新品">新品
                          <input name="other" <%=getCheck(sound.getOther().indexOf("推荐")!=-1)%>   id="CHECKBOX" type="CHECKBOX" value="推荐">推荐
                          <input name="other" <%=getCheck(sound.getOther().indexOf("特价")!=-1)%>    id="CHECKBOX" type="CHECKBOX" value="特价">特价
                          <input name="other"  <%=getCheck(sound.getOther().indexOf("预售")!=-1)%>  id="CHECKBOX" type="CHECKBOX" value="预售">预售
                          <input name="other"  <%=getCheck(sound.getOther().indexOf("上架")!=-1)%>  id="CHECKBOX" type="CHECKBOX" value="上架" >上架
                          <input name="other"  <%=getCheck(sound.getOther().indexOf("热门")!=-1)%>   id="CHECKBOX" type="CHECKBOX" value="热门">热门
                          <input name="other"   <%=getCheck(sound.getOther().indexOf("滚动")!=-1)%>  id="CHECKBOX" type="CHECKBOX" value="滚动">滚动</td>
                        </tr>
                        <tr>

                          <td width="32%" height="32" colspan="20">
                          <div align="center">

    <INPUT TYPE=SUBMIT NAME="GoBack"  onClick="return check();" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
  <INPUT TYPE=SUBMIT name="GoFinish"  onClick="return check();" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
                          <!--  <input type="button" name="Submit" value="添 加" onClick="return check();">-->
                          </div>
                          </td>
                          <td width="52%">
                          <p>　</p>
                          </td>
                        </tr>
</table>
</form>

<br>
<script language="JavaScript">
function UpLoad(File){
	uploadform.File.value=File;
	uploadform.action="AddFilesCommit.jsp";
	uploadform.target="_blank"
	document.uploadform.submit();

}
function Edit(){
	document.myform.submit();
}
function Reset(){
	uploadform.reset()
}
</script>
<script LANGUAGE="JavaScript">
<!--
function check()
{
//  alert(document.myform.goodsname.value);
	//document.myform.content.value = frames.message.document.body.innerHTML

   if(checkspace(document.myform.goodsname.value)) {
	document.myform.goodsname.focus();
    alert("请输入商品名称！");
	return false;
  }
     if(checkspace(document.myform.shichangjia.value)) {
	document.myform.shichangjia.focus();
    alert("请输入商品价格！");
	return false;
  }
     if(checkspace(document.myform.huiyuanjia.value)) {
	document.myform.huiyuanjia.focus();
    alert("请输入商品价格！");
	return false;
  }
  Edit();

}
function checkspace(checkstr) {
  var str = '';
  for(i = 0; i < checkstr.length; i++) {
    str = str + ' ';
  }
  return (str == checkstr);
}
//-->
</script>
<script>
	function regInput(obj, reg, inputStr)
	{
		var docSel	= document.selection.createRange()
		if (docSel.parentElement().tagName != "INPUT")	return false
		oSel = docSel.duplicate()
		oSel.text = ""
		var srcRange	= obj.createTextRange()
		oSel.setEndPoint("StartToStart", srcRange)
		var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length)
		return reg.test(str)
	}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
