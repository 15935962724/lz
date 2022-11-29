<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%

if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return; 
} 
 r.add("/tea/resource/Event");


long lp1len=0;
long iplen=0;
float integral = 0;

String subject="",content="";
String flyerdata="";

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
  window.showModalDialog("/jsp/type/nightshop/NightShopList.jsp?node=<%=teasession._nNode%>&index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}

function f_load()
{
  f_editor();
  form1.subject.focus();
}
function f_sub()
{
	  if(form1.subject.value==''){
		  alert('请填写活动名称');
		  form1.subject.focus();
		  return false;
	  }
	  if(form1.city.value==''){
		  alert('请选择活动区县');
		  form1.city.focus();
		  return false;
	  }
}
</script> 
</head>
<body onload="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Event")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditEvent"  ENCtype=multipart/form-data onSubmit="return f_sub();">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="adminrole" value="<%=teasession.getParameter("adminrole") %>">
<%
Event event ;
String parameter=teasession.getParameter("nexturl");

boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
{
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
}
if(request.getParameter("NewNode")!=null)
{
  event = Event.find(0, teasession._nLanguage);
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  event = Event.find(teasession._nNode, teasession._nLanguage);
  if(event.getBigPicture()!=null && event.getBigPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(event.getBigPicture()));
    lp1len=file.length();
  }
  if(event.getIntroPicture()!=null && event.getIntroPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(event.getIntroPicture()));
    iplen=file.length();
  }
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  content=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  flyerdata=HtmlElement.htmlToText(event.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动名称")%>：</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subject" value="<%=subject%>">
      </td>
    </tr>
    
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动区县")%>：</td>
      <td>
        <select name="city">
        <option value="">-选择区县-</option>
      <%
      for(int i=0;i<Event.CITYS.length;i++)
      {
        out.print("<option value="+i);
        if(event.getCity()==i)
        {
        	out.print(" selected ");
        }
        
        out.print(" >"+Event.CITYS[i]+"</option>");
      }

      %>
      </select>
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动时间")%>：</td>
      <td>
        <%=new TimeSelection("timeStart", event.getTimeStart())%>
      </td>
    </tr>
    
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "特殊规定")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="prescribe" value="<%=event.getPrescribe()%>">
      </td>
    </tr>
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "组织者联系方式")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="linkman" value="<%=event.getLinkman()%>">
      </td>
    </tr>
   
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "介绍图片")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=introPicture onDblClick="window.open('<%=event.getIntroPicture()%>');" class="edit_input"><%if(iplen != 0){ out.print(iplen + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearIntroPicture VALUE=null  onclick='form1.introPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "大图片")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=bigPicture onDblClick="window.open('<%=getNull(event.getBigPicture()).replaceAll("\\\\","/")%>');" class="edit_input"><%if(lp1len != 0){ out.print(lp1len + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearBigPicture VALUE=null  onclick='form1.bigPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>
    
      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "发布时间")%>：</td> 
      <td>
         <%=new TimeSelection("Issue", event.getDate())%>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "报名积分")%>：</td> 
      <td>
        <input type="text" name="integral" value="<%=event.getIntegral() %>" size=4 maxlength="4" >
      </td>
    </tr> 
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "详细内容")%>：</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="nonuse"  id="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <br/>
          <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=content%></textarea>
          <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>
   
    
  


  </table>
  <br>
  <center>
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
  <input type="button" name="reset" value="返回" onClick="javascript:history.go(-1)">
  
</center></form>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

