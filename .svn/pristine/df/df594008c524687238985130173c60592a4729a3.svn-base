<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Node node=Node.find(teasession._nNode);

Category category = Category.find(teasession._nNode);//显示类别中的内容

boolean _bNew=request.getParameter("NewNode")!=null;

String community=node.getCommunity();

int options1=node.getOptions1();
if(!_bNew)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(node.getFather()).getOptions1();
}
int type=node.getType();
if(type==1)
{
  type=category.getCategory();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource("/tea/resource/Report");

Community c=Community.find(community);

String title=r.getString(teasession._nLanguage, "Report");

String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));

String text="",subject=null,keywords=null,mark=null;
///////////////////////////////


int media=0;
int c_r=0,c_r2=0;
java.util.Date date_r=null;
long l2=0;
int j=0;
String picture=null,locus=null,subhead=null,author=null,logograph=null,medianame="";
boolean mostly=false,mostly1=true,mostly2=true,meboole=false;
if(_bNew)
{
  out.println("<input type=hidden NAME=NewNode VALUE=ON>");
}else
{
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  subject=node.getSubject(teasession._nLanguage);
  keywords=node.getKeywords(teasession._nLanguage);
  mostly=node.isMostly();
  mostly1=node.isMostly1();
  mostly2=node.isMostly2();
  mark=node.getMark();
  Report obj=Report.find(teasession._nNode);
  media=obj.getMedia();
  Media mobj = Media.find(media);
  if(mobj.getName(teasession._nLanguage)!=null && mobj.getName(teasession._nLanguage).length()>0)
  {
    medianame=mobj.getName(teasession._nLanguage);
    meboole = true;
  }
  c_r=obj.getClasses();
  c_r2=obj.getClasses2();
  date_r=obj.getIssueTime();
  picture=obj.getPicture(teasession._nLanguage);
  locus=obj.getLocus(teasession._nLanguage);
  subhead=obj.getSubhead(teasession._nLanguage);
  author=obj.getAuthor(teasession._nLanguage);
  logograph=obj.getLogograph(teasession._nLanguage);
  if(picture!=null)
  {
    l2=new java.io.File(application.getRealPath(picture)).length();
  }
}
%><html>
<head>
<title><%=title%></title>

<style type="text/css">
#gzd{position:absolute;position: relative;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 281px;left: 0px;top: 19px;z-index:1;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 281px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
</style>

<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=community%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script language="javascript" src="/tea/inc/media_<%=teasession._nLanguage%>_39.js?<%=System.currentTimeMillis()%>" type="text/javascript"></script>
<script type="">
var last=0;
function nextpage()
{
  form1.act.value='back';
  if (event.keyCode==13)
  {

    event.returnValue=false;
    var strtt=document.getElementById("medianame").value;
    sendx("/jsp/type/media/Media_Ajax.jsp?act=cunzai&medianame="+encodeURIComponent(strtt,"UTF-8"),member_show);
    return false;
  }
  var xiaoliajatable=$("xiaoliajatable");
  if(!xiaoliajatable)return;
  var trs=xiaoliajatable.getElementsByTagName("TR");

  if (event.keyCode==38&&last>0)
  {
    trs[last].bgColor='';

    form1.medianame.value=document.getElementById("mname"+last).value;
    form1.media.value=document.getElementById("nid"+last).value;
    trs[--last].bgColor='#BCD1E9';
  };//
  if (event.keyCode==40&&last<trs.length-1)
  {
    trs[last].bgColor='';
    form1.medianame.value=document.getElementById("mname"+[last+2]).value;
    form1.media.value=document.getElementById("nid"+[last+2]).value;
    trs[++last].bgColor='#BCD1E9';
  };//
}

function f_load()
{
  f_editor();
  form1.classes.onchange();
  form1.subject.focus();
}
function f_list()
{
  var rs=window.showModalDialog('/jsp/listing/SelListing.jsp?community=<%=teasession._strCommunity%>&type=<%=type%>&listing='+form1.listing.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:420px;');
  if(!rs)return;
  var i=rs.indexOf(':');
  form1.listing.value=rs.substring(0,i);
  form1.listingname.value=rs.substring(i+1);
}
var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=report&value="+v,f_change);
}
function f_change(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "classesc":
    form1.classesc.value="<%=c_r2%>";
    break;
  }
}
function f_gz2()
{

  if (event.keyCode==38||event.keyCode==40)return;
  sendx("/jsp/type/report/Report_ajax.jsp?act=reportact&cxxw="+encodeURIComponent(form1.medianame.value),
  function(data)
  {
  //  document.write(data);
  //alert(data);
    document.getElementById("cxshow").innerHTML=data;
  }
  );

  var strtt=document.getElementById("medianame").value;
  sendx("/jsp/type/media/Media_Ajax.jsp?act=cunzai&medianame="+encodeURIComponent(strtt,"UTF-8"),member_show);

}

function f_trdw(igd,iid)
{
  form1.medianame.value=igd;
  form1.media.value=iid;

  var strtt=document.getElementById("medianame").value;
  sendx("/jsp/type/media/Media_Ajax.jsp?act=cunzai&medianame="+encodeURIComponent(strtt,"UTF-8"),member_show);
  document.getElementById("xilidiv").style.display='none';//隐藏div

}
function f_yinyin()
{
  var strtt=document.getElementById("medianame").value;
  sendx("/jsp/type/media/Media_Ajax.jsp?act=cunzai&medianame="+encodeURIComponent(strtt,"UTF-8"),member_show);
  document.getElementById("xilidiv").style.display='none';//隐藏div

}
function f_showx()
{

  var strtt=document.getElementById("medianame").value;
  sendx("/jsp/type/media/Media_Ajax.jsp?act=cunzai&medianame="+encodeURIComponent(strtt,"UTF-8"),member_show);
  document.getElementById("xilidiv").style.display='';//隐藏div
}

function f_sub()
{
  if(document.getElementById("medianame").value!=null&&document.getElementById("medianame").value!="")
  {
    if(document.getElementById("falg").value=="false")
    {
      alert("该媒体不存在");
      return false;
    }
    else
    {
        return true;
    }
  }
  else
  {
    document.getElementById("media").value="0";
  }
}
function member_show(v)
{

  if(v.indexOf('true')!=-1)
  {
    show.innerHTML="媒体类型可用";
    show.style.color='green';
    document.getElementById("falg").value="true";
    return true;
  }else
  {
    show.innerHTML="该媒体不存在";
    show.style.color='red';
    document.getElementById("falg").value="false";
    return false;
  }
}
</script>
</head>
<body onload="f_load()">
<h1>上传资料</h1>

<form name="form1" METHOD=POST  action="/servlet/EditReport" enctype="multipart/form-data" onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&f_sub()&&override();">
<%
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String my=teasession.getParameter("my");
my=(my==null)?"":my;
%>
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name="repository" value="report">
<input type='hidden' name="my" value="<%=my %>">
<input type='hidden' name="falg" value="<%=meboole%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="EditReport_1">
    <td nowrap align="right">*&nbsp;<%=r.getString(teasession._nLanguage, "Subject")%>:<!--标题--></TD>
    <td nowrap><input name="subject" size=70 maxlength=255 class="edit_input" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"/></td>
  </tr>

  <tr id="EditReport_3" style="display:none">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Report.classes")%>:</TD>
    <td nowrap>
      <select  name="classes" onChange="f_ajax(value,'classesc')">
        <option  value="0">---------------</option>
        <%
        Enumeration eu = Classes.find(" and type = 39 and community="+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
        for(int i=0;eu.hasMoreElements();i++)
        {
          int idc= Integer.parseInt(String.valueOf(eu.nextElement()));
          Classes objty = Classes.find(idc);
          out.print("<option value="+idc);
          if(c_r==idc)
          {
            out.print(" selected ");
          }
          out.print(">"+objty.getName()+"</option>");
        }
        %>
        </select>
        <select name="classesc" >
          <option value="0" >-------</option>
        </select>
        <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/classes/ClassesSel.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs)form1.classes.value=rs;">
        <input type="button" class="edit_button" onClick="window.showModalDialog('/jsp/type/classes/Classes.jsp?node=<%=teasession._nNode%>&type=39',self,'status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:500px;');" value="<%=r.getString(teasession._nLanguage, "管理")%>">
    </td>
  </tr>
  <tr id="EditReport_2" style="display:none">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Report.media")%>:</TD>
    <td nowrap><!--cxxw
      <script type="">media("media","<%=media%>");</script>
      <input type=button value="..." onClick="var rs=window.showModalDialog('/jsp/type/media/medianameel.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs)form1.media.value=rs;">
      <input type=button value="<%=r.getString(teasession._nLanguage, "管理")%>" onClick="window.open('/jsp/type/media/medianame.jsp?community=<%=community%>&type=39');"
      -->
      <!--新添方法--><span id="gzd">
        <span id="gzd"><span id="gztext"> <input type="text" name="medianame" value="<%=medianame%>" size="50" onkeyup="f_gz2();" onkeydown="nextpage()" autoComplete="off"></span></span>
          <span id="cxshow">&nbsp;</span>
          <input type=button value="<%=r.getString(teasession._nLanguage, "管理")%>" onClick="window.open('/jsp/type/media/Medias.jsp?community=<%=community%>&type=39');">
          <input type=hidden value="<%=media%>"  name="media"><span id="show"></span>
    </td>
  </tr>
  <tr id="EditReport_4" >
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
    <td nowrap>
      <input type="file" name="picture" class="edit_input">
      <%
      if(l2 > 0)
      {
        out.print("<a href='"+picture+"' target='_blank'>"+l2 + r.getString(teasession._nLanguage, "Bytes")+"</a>");
        out.print("<input id='checkbox' type='checkbox' name='clearpicture' onclick='form1.picture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
      <input type="checkbox" name="tbn" checked="checked"/>自动缩小图片
      </td>
  </tr>
  <tr id="EditReport_5" style="display:none">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Report.locus")%>:</TD>
    <td nowrap><input name="locus" size="50"  class="edit_input" value="<%if(locus!=null)out.print(locus.replaceAll("\"","&quot;"));%>"/></td>
  </tr>
  <tr id="EditReport_6">
    <TD align="right">*&nbsp;<%=r.getString(teasession._nLanguage, "Keywords")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name="keywords" value="<%if(keywords!=null)out.print(keywords.replaceAll("\"","&quot;"));%>" size="70" maxlength="255">
    </td>
  </tr>
  <tr id="EditReport_7" style="display:none">
    <TD align="right"><%=r.getString(teasession._nLanguage, "Report.subhead")%>:<!--副标题--></TD>
    <td><input type="TEXT" class="edit_input"  name="subhead" value="<%if(subhead!=null)out.print(subhead.replaceAll("\"","&quot;"));%>" size="70" maxlength="255"></td>
  </tr>
  <tr id="EditReport_8">
    <TD align="right">*&nbsp;<%=r.getString(teasession._nLanguage, "Report.author")%>:<!--发布人--></TD>
    <td><input type="TEXT" class="edit_input"  name="author" value="<%if(author!=null)out.print(author.replaceAll("\"","&quot;"));%>" size="20" maxlength="255">
      <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/report/ReportMember.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs!=null)form1.author.value=rs;">
    </td>
  </tr>
  <tr id="EditReport_9">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Report.logograph")%>:</TD>
    <td nowrap> <textarea name="logograph" rows="2" cols="70" class="edit_input"><%if(logograph!=null)out.print(logograph.replaceAll("</","&lt;/"));%></textarea>    </td>
  </tr>
  <tr id="EditReport_10" style="display:none">
    <td nowrap> </TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>
  <tr id="EditReport_11">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
    <td nowrap>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=text%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <tr id="EditReport_12" style="display:none">
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Report.issuetime")%>:</TD>
    <td nowrap><%=new tea.htmlx.TimeSelection("Issue", date_r)%></td>
  </tr>
  <%
  StringBuilder lid=new StringBuilder("/");
  //int cml=Listing.count(" AND type=3 AND node IN(SELECT node FROM node WHERE path LIKE '/"+c.getNode()+"/%' AND type<2 AND hidden=0) AND listing IN(SELECT listing FROM PickNode WHERE type IN(255,"+type+"))");
  //if(cml>0)//是否存在手动列举
  {
    out.print("<tr style=\"display:none\"><td nowrap  align=right>"+r.getString(teasession._nLanguage, "Report.show")+":</td><td nowrap><input name='listingname' size='40' readonly='true' value=\"");
    if(!_bNew)
    {
      Enumeration e=Listed.findListing(teasession._nNode);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        Listing obj=Listing.find(id);
        if(!obj.isExisted())continue;
        out.println(obj.getName(teasession._nLanguage)+";　");
        lid.append(id).append("/");
      }
    }
    out.print("\" /> <input type='button' value='...' onclick='f_list()' /></td></tr>");
  }
  out.print("<input type='hidden' name='listing' value='"+lid.toString()+"' />");
  %>
  <tr id="EditReport_13" style="display:none">
    <td align="right"><%=r.getString(teasession._nLanguage, "Options")%>:</td>
    <td  rowspan="" >
      <input type="checkbox" name="mostly" <%if(mostly)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170275406")%>
      <input type="checkbox" name="mostly1" <%if(mostly1)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170373281")%>
      <input type="checkbox" name="mostly2" <%if(mostly2)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170388968")%>
      <%=Mark.toHtml(teasession._strCommunity,type,mark)%>
    </td>
  </tr>
</table>

<center>
  <input type="hidden" name="act" value="">
  <!--完成***下一步****高级-->
  <%
  if(category.getClewtype()!=0){
    %>
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"   class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>" onClick="form1.target='dialog_frame';">
    <%
    }else{
      %>

      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
      <%
      }
      %>
      <!--        <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='next';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>"> -->
      <input style="display:none" type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
</center>
</FORM>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
