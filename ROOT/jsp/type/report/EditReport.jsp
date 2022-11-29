<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.*" %><%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

Node node=Node.find(h.node);

Category category = Category.find(h.node);//显示类别中的内容

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
  if(h.member<1)
  {
    response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
    return;
  }
  RV rv=new RV(Profile.find(h.member).getMember());
  if(!node.isCreator(rv)&&!AccessMember.find(node._nNode,rv).isProvider(type))
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource("/tea/resource/Report");


Community c=Community.find(community);

///////////
//c.getMedia()
String m_name = Media.find(c.getMedia()).getName(h.language);


String title=r.getString(h.language, "Report");

String parameter=h.get("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));

String text="",subject=null,keywords=null,description=null,mark=null;
///////////////////////////////


int media=0,manuscripttype=0;
int c_r=0,c_r2=0;
Date starttime=null;
long l2=0,sfnlen=0,shfnlen=0,authorlen=0;
int j=0;
String picture=null,locus=null,subhead=null,author=null,medianame="",kicker="",newquota="",quotasource="",editmember="";
String subjectfilename=null,subheadfilename=null,authorfilename=null,signature=null;
boolean mostly=false,mostly1=true,mostly2=true,meboole=false;
int flag = 0;
String experts=null,providemember=null;
if(_bNew)
{
  out.println("<input type=hidden NAME=NewNode VALUE=ON>");
}else
{
  starttime=node.getStartTime();
  description=node.getDescription(h.language);
  text=node.getText(h.language);
  subject=node.getSubject(h.language);
  keywords=node.getKeywords(h.language);
  mostly=node.isMostly();
  mostly1=node.isMostly1();
  mostly2=node.isMostly2();
  mark=node.getMark();
  Report obj=Report.find(h.node);
  media=obj.getMedia();
  Media mobj = Media.find(media);
  if(mobj.getName(h.language)!=null && mobj.getName(h.language).length()>0)
  {
    medianame=mobj.getName(h.language);
    meboole = true;
  }
  c_r=obj.getClasses();
  c_r2=obj.getClasses2();
  picture=obj.getPicture(h.language);
  locus=obj.getLocus(h.language);
  subhead=obj.getSubhead(h.language);
  author=obj.getAuthor(h.language);
  editmember=obj.getEditmember(h.language);
  kicker = obj.getKicker(h.language);
  if(picture!=null && picture.length()>0)
  {
    l2=new java.io.File(application.getRealPath(picture)).length();
  }
  flag= obj.getFlag();
  newquota=obj.getNewquota(h.language);
  quotasource=obj.getQuotasource(h.language);

  manuscripttype=obj.getManuscripttype();
  subjectfilename = obj.getSubjectfilename(h.language);
  if(subjectfilename!=null && subjectfilename.length()>0)
  {
	  sfnlen=new java.io.File(application.getRealPath(subjectfilename)).length();
  }

  subheadfilename = obj.getSubheadfilename(h.language);

  if(subheadfilename!=null && subheadfilename.length()>0)
  {
	  shfnlen=new java.io.File(application.getRealPath(subheadfilename)).length();
  }
  authorfilename = obj.getAuthorfilename(h.language);
  if(authorfilename!=null && authorfilename.length()>0)
  {
	  authorlen=new java.io.File(application.getRealPath(authorfilename)).length();
  }
   experts=obj.getExperts(h.language);//专家
   providemember=obj.getProvidemember(h.language);//新闻提供者
   signature=obj.getSignature(h.language);

}

//boolean isFtp=new File(application.getRealPath("/res/"+community+"/ftp/")).exists();


%><html>
<head>
<title><%=title%></title>
<%--
<style type="text/css">
#gzd{position:absolute;position: relative;z-index:4;}
#gzd2{position:absolute;position: relative;z-index:2;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 281px;left: 0px;top: 19px;z-index:13;}
#xilidiv2{display:block;position: relative;position:absolute;height: auto;width: 155px;left: 0px;top: 19px;z-index:12;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 281px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
#tablecenter #xiaoliajatable2{background:#ffffff;width: 155px;}
#tablecenter #xiaoliajatable2 td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}

#gzd3{position:absolute;position: relative;z-index:3;}
#xilidiv3{display:block;position: relative;position:absolute;height: auto;width: 155px;left: 0px;top: 19px;z-index:15;}
#tablecenter #xiaoliajatable3{background:#ffffff;width: 155px;}
#tablecenter #xiaoliajatable3 td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
</style>
--%>
<style>
.sug td{padding:4px;font-size:13px}
.sug .cur
{
color: #FFFFFF;
background: #3366CC;
cursor: default;
}

#mediashow{color:red}
.fileh{position:absolute;width:60px;filter:alpha(opacity=0);opacity:0;cursor:pointer}

#_subjectfilename,#_subheadfilename,#_authorfilename{border:0;color:#0000FF;background-color:transparent}
</style>
<script src="/tea/layer.js" type="text/javascript" ></script>
<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/mt.js" type="text/javascript" ></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=community%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
function f_list()
{
  var d=window.showModalDialog('/jsp/listing/SelListing.jsp?community=<%=h.community%>&type=<%=type%>&listing='+form1.listing.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:420px;');
  if(!d)return;
  eval("d="+d);
  form1.listing.value=d.listing;
  form1.listingname.value=d.name;
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
function f_sub()
{
  if(mediaflag)
  {
    mt.show("该“新闻来源”不存在！");
    return false;
  }
  addIsshowlayer();
  return true;
}

//媒体管理
function f_medias()
{
  var rs=window.showModalDialog('/jsp/type/media/Medias.jsp?community=<%=community%>&type=39',self,'edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:557px;');
  if(rs!=null)
  {
    form1.media.value=rs.split("/")[1];
    form1.medianame.value=rs.split("/")[2];
    mediaflag=false;
    $$('mediashow').innerHTML='';
  }
}
//function checkinput_file(obj,igd)
//{
//  var sUploadAllowedExtensions  = ".gif .jpg .jpeg .png" ;//".doc,.docx,.xls,.xlsx" ;
//  var sExt = eval(obj).value.match( /.[^.]*$/ ) ;
//  sExt = sExt ? sExt[0].toLowerCase() : "." ;
//  if(sUploadAllowedExtensions.indexOf(sExt)<0)
//  {
//    alert("对不起, 只有下面的图片格式才能上传:" + sUploadAllowedExtensions + "，请重新选择.");
//    return false;
//  }
//  document.getElementById(igd).innerHTML=obj.value+'&nbsp;<input type="checkbox" name='+igd+'tbn  checked=checked/>自动缩小图片&nbsp;<a href=### onclick=f_delete_file(this)>删除</a>';
//}
//function f_delete_file(igd)
//{
//  igd=igd.parentNode;
//  igd.innerHTML="";
//  igd=igd.previousSibling;
//  igd.innerHTML=igd.innerHTML;
//}
function f_subject()
{
  var subject = form1.subject.value;
  sendx("/jsp/type/media/Media_Ajax.jsp?t="+new Date().getTime()+"&act=f_subject&subject="+encodeURIComponent(subject,"UTF-8"),function(data)
  {
    document.getElementById('subjectshow').innerHTML='<br><font color=red>'+data+'</font>';
  }
  );
}
function addIsshowlayer(){
	var layers=document.getElementsByName("isshowlayer");
	var listxt=form1.listing.value;
	for(var i=0;i<layers.length;i++){
		if(layers[i].checked&&layers[i].value!=""){
			listxt=listxt+layers[i].value+"/";
		}
	}
	form1.listing.value=listxt;
}

</script>
</head>
<body>
<h1><%=title%></h1>
<div id="pathdiv"><%=node.getAncestor(h.language)%></div>
<form name="form1" METHOD=POST action="/servlet/EditReport?repository=report" target="_ajax" enctype="multipart/form-data" onSubmit="if(mt.check(this)&&f_sub()){mt.show(null,0);ups[0].complete();}return false;">
<%
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
%>
<input type='hidden' name="node" value="<%=h.node%>">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name="resize" value="300">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="EditReport_kicker">
    <td nowrap align="right"><%=r.getString(h.language, "引题")%>:</td><!--引题-->
    <td nowrap><input class="edit_input"  name="kicker" value="<%if(kicker!=null)out.print(kicker.replaceAll("</","&lt;/"));%>" size="70" maxlength="255"></td>
  </tr>

  <tr id="EditReport_1">
    <td nowrap align="right">*&nbsp;文章标题<!--<%=r.getString(h.language, "Subject")%>-->:<!--标题--></td>
    <td nowrap><input name="subject" size=70 maxlength=255 class="edit_input" value="<%=MT.f(subject)%>" alt="文章标题" onkeyup="<%=_bNew?"f_subject()":""%>"/>
      <input type="hidden" name="subjectfilename" value="<%=MT.f(subjectfilename)%>"/><input type="button" id="_subjectfilename" value="(图片)"/><span></span>
   <%
   if(sfnlen>0)
   {
     out.print("<a href='"+subjectfilename+"' target='_blank'>查看原图&nbsp;("+sfnlen+r.getString(h.language,"Bytes")+")</a>");
     out.print("<input id='checkbox' type='checkbox' name='subjectfileclearpicture' onclick='form1.subjectfilename.disabled=this.checked'>"+r.getString(h.language, "Clear"));
   }
   %>
      <span id="subjectshow"></span>
    </td>
  </tr>

  <tr id="EditReport_7">
    <td align="right"><%=r.getString(h.language, "Report.subhead")%>:<!--副标题--></td>
    <td>
      <input class="edit_input" name="subhead" value="<%=MT.f(subhead)%>" size="70" maxlength="255"/>
      <input type="hidden" name="subheadfilename" value="<%=MT.f(subheadfilename)%>"/><input type="button" id="_subheadfilename" value="(图片)"/><span></span>
      <%
      if(shfnlen> 0)
      {
        out.print("<a href='"+subheadfilename+"' target='_blank'>查看原图&nbsp;("+shfnlen + r.getString(h.language, "Bytes")+")</a>");
        out.print("<input id='checkbox' type='checkbox' name='subheadfileclearpicture' onclick='form1.subheadfilename.disabled=this.checked'>"+r.getString(h.language, "Clear"));
      }
      %>
    </td>
  </tr>
  <!-- 新闻语录 newquota -->

   <tr id="EditReport_newquota">
    <td align="right"><%=r.getString(h.language, "新闻语录")%>:</td>
    <td><input class="edit_input" name="newquota" value="<%=MT.f(newquota)%>" size="70" maxlength="255"></td>
  </tr>
   <!-- 语录出处 quotasource -->

   <tr id="EditReport_quotasource">
    <td align="right"><%=r.getString(h.language, "语录出处")%>:</td>
    <td><input class="edit_input"  name="quotasource" value="<%=MT.f(quotasource)%>" size="70" maxlength="255"></td>
  </tr>



  <tr id="EditReport_3">
    <td nowrap align="right"><%=r.getString(h.language, "Report.classes")%>:</td>
    <td nowrap>
      <select  name="classes" onChange="f_ajax(value,'classesc')">
        <option  value="0">---------------</option>
        <%
        Enumeration eu = Classes.find(" and type = 39 and community="+DbAdapter.cite(h.community),0,Integer.MAX_VALUE);
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
        <input type="button" class="edit_button" onClick="window.showModalDialog('/jsp/type/classes/Classes.jsp?node=<%=h.node%>&type=39',self,'status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:500px;');" value="<%=r.getString(h.language, "管理")%>">
    </td>
  </tr>

  <tr id="EditReport_ManuscriptType">
    <td nowrap align="right"><%=r.getString(h.language, "稿件类别")%>:</td>
    <td nowrap>
      <select  name="manuscripttype">
        <%

        for(int i=0;i<Report.MANUSCRIPT_TYPE.length;i++)
        {

          out.print("<option value="+i);
          if(manuscripttype==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Report.MANUSCRIPT_TYPE[i]+"</option>");
        }
        %>
        </select>

    </td>
  </tr>

  <tr id="EditReport_2">
    <td nowrap align="right">*&nbsp;<%=r.getString(h.language, "新闻来源")%>:</td>
    <td nowrap>
        <input name="medianame" value="<%=MT.f(medianame)%>" size="50" onkeydown="if(event.keyCode==13){return false;}" onKeyUp="mt.sug(event,this)" autoComplete="off" alt="<%=c.ischeck.contains("/1/")?"新闻来源":""%>">
        <input type=button value="<%=r.getString(h.language, "管理")%>" onClick="f_medias();"><!-- window.open('/jsp/type/media/Medias.jsp?community=<%=community%>&type=39'); -->
        <input type=hidden value="<%=media%>" name="media"><span id="mediashow"></span>
    </td>
  </tr>
  <tr id="EditReport_4">
    <td nowrap align="right"><%=r.getString(h.language, "Picture")%>:</td>
    <td nowrap>
      <input type="file" name="picture" class="edit_input">
      <input type="hidden" name="picturepath" value="<%=MT.f(picture)%>">
      <%
      if(l2 > 0)
      {
        out.print("<a href='"+picture+"' target='_blank'>查看原图&nbsp;("+l2 + r.getString(h.language, "Bytes")+")</a>");
        out.print("<input id='checkbox' type='checkbox' name='clearpicture' onclick='form1.picture.disabled=this.checked'>"+r.getString(h.language, "Clear"));
      }
      //if(isFtp)out.print("<input type='button' value='选择' onclick=t=window.showModalDialog('/jsp/site/FFtps.jsp?community="+community+"&oby=2&act=select',self,'dialogWidth:680px;dialogHeight:400px;help:0;status:0;resizable:1;');if(t)form1.picturepath.value=t; />");
      %>
      <input type="checkbox" id="_resize" value="300" checked="checked" onclick="form.resize.disabled=!checked"/><label for="_resize">自动缩小图片</label>
      <input type="checkbox" name="flag"  value="1" <%if(flag==1)out.print(" checked=checked ");%>/>添加水印
      </td>
  </tr>
  <tr id="EditReport_5">
    <td nowrap align="right"><%if(c.getLocus(h.language)!=null && c.getLocus(h.language).length()>0){out.print(c.getLocus(h.language));}else{out.print("地点");}%>:</td>
    <td nowrap><input name="locus" size="50"  class="edit_input" value="<%if(locus!=null)out.print(locus.replaceAll("\"","&quot;"));%>"/></td>
  </tr>

  <tr id="EditReport_6">
    <td align="right">*&nbsp;<%=r.getString(h.language, "Keywords")%>:</td>
    <td><input class="edit_input"  name="keywords" value="<%if(keywords!=null)out.print(keywords.replaceAll("\"","&quot;"));%>" size="70" maxlength="255">
    <input name="phrase" type="button" value="提取关键词" onClick="form1.phrase.disabled=true;sendx('/servlet/Ajax?act=phrase&phrase='+encodeURIComponent(form1.subject.value),function(v){form1.keywords.value=v;form1.phrase.disabled=false;});"/>
    </td>
  </tr>

   <%--<tr id="Contributors_5">
    <td align="right">*&nbsp;本文署名:</td>
    <td align="left"><input type="text" class="edit_input"  name="signature" value="<%if(signature!=null)out.print(signature.replaceAll("\"","&quot;"));%>"  maxlength="255">
    </td>
  </tr>--%>

  <tr id="EditReport_8">
    <td align="right">*&nbsp;<%=r.getString(h.language, "Report.author")%>:<!--作者--></td>
    <td>
      <input class="edit_input"  name="author" value="<%=MT.f(author)%>" size="20" maxlength="255">
      <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/report/ReportMember.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs!=null)form1.author.value=rs;">&nbsp;
      <input type="hidden" name="authorfilename" value="<%=MT.f(authorfilename)%>"/><input type="button" id="_authorfilename" value="(图片)"/><span></span>
   <%
      if(authorlen> 0)
      {
        out.print("<a href='"+authorfilename+"' target='_blank'>查看原图&nbsp;("+authorlen + r.getString(h.language, "Bytes")+")</a>");
        out.print("<input id='checkbox' type='checkbox' name='authorfileclearpicture' onclick='form1.authorfilename.disabled=this.checked'>"+r.getString(h.language, "Clear"));
      }
      %>
    </td>
  </tr>

  <tr id="EditReport_editmember">
    <td align="right">*&nbsp;<%=r.getString(h.language, "新闻编辑")%>:<!--编辑--></td>
    <td>
    <input class="edit_input" name="editmember" value="<%if(editmember!=null&&editmember.length()>0)out.print(editmember.replaceAll("\"","&quot;"));else if(h.member>0){out.print(Profile.find(h.member).getMember());}%>" size="20" maxlength="50">
       <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/report/Editmember.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs!=null)form1.editmember.value=rs;">&nbsp;
    </td>
  </tr>

<!-- 专家 -->
  <tr id="EditReport_experts">
    <td align="right"><%=r.getString(h.language,"专家")%>:<!--编辑--></td>
    <td><span id="gzd3">
    <input class="edit_input" name="experts" value="<%=MT.f(experts)%>" onkeydown="if(event.keyCode==13){return false;}" onKeyUp="mt.sug(event,this)" autoComplete="off" size="20" maxlength="50">
    <span id="expertsshow">&nbsp;</span></span>
    <input type="button" value="管理" onClick="var rs=window.showModalDialog('/jsp/newer/NewexpertsList.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs!=null)form1.experts.value=rs;">&nbsp;
    </td>
  </tr>
  <!-- 新闻提供者 -->
   <tr id="EditReport_providemember">
    <td align="right"><%=r.getString(h.language, "新闻提供者")%>:</td>
    <td><span id="gzd2"><input class="edit_input" name="providemember" value="<%=MT.f(providemember)%>" onkeydown="if(event.keyCode==13){return false;}" onKeyUp="mt.sug(event,this)" autoComplete="off" size="20" maxlength="50">
    <span id="eprovideshow">&nbsp;</span></span>
    <input type="button" value="管理" onClick="var rs=window.showModalDialog('/jsp/newer/NewprovidersList.jsp?community=<%=community%>&type=39',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs!=null)form1.providemember.value=rs;">&nbsp;
    </td>
  </tr>

  <tr id="EditReport_9">
    <td nowrap align="right"><%=r.getString(h.language, "Report.logograph")%>:</td><!--导语-->
    <td nowrap><textarea name="description" rows="8" cols="70" class="edit_input"><%=MT.f(description)%></textarea></td>
  </tr>
  <tr id="EditReport_10">
    <td nowrap align="right"><%=r.getString(h.language, "Text")%>:</td>
    <td nowrap>
<!--
      <input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked"><%=r.getString(h.language, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
-->
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse"><%=r.getString(h.language, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
<%
//if(isFtp)out.print("<input type='button' value='选择图片' onclick=window.open('/jsp/site/FFtps.jsp?community="+community+"&oby=2','_blank','width=680px,height=400px,resizable=1'); />");
%>
    </td>
  </tr>
  <tr id="EditReport_11">
    <td nowrap colspan="2">
      <textarea name="content" rows="12" cols="90"><%=MT.f(text)%></textarea>
      <script>if(mt.isIE6||location.hostname=='www.mzb.com.cn'||location.hostname=='www.cien.com.cn')document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>' width='740' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
    </td>
  </tr>
 <tr id="EditReport_12">
    <td nowrap align="right"><%=r.getString(h.language, "Report.issuetime")%>:</td>
    <td nowrap><%=new tea.htmlx.TimeSelection("start", starttime,true,true)%></td>
  </tr>

  <%
  StringBuilder lid=new StringBuilder("/");
  //int cml=Listing.count(" AND type=3 AND node IN(SELECT node FROM node WHERE path LIKE '/"+c.getNode()+"/%' AND type<2 AND hidden=0) AND listing IN(SELECT listing FROM PickNode WHERE type IN(255,"+type+"))");
  //if(cml>0)//是否存在手动列举
  {
    out.print("<tr><td nowrap  align=right>"+r.getString(h.language, "Report.show")+":</td><td nowrap><input name='listingname' size='40' readonly='true' value=\"");
    if(!_bNew)
    {
      Enumeration e=Listed.findListing(h.node);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        Listing obj=Listing.find(id);
        if(!obj.isExisted())continue;
        if(obj.getIsshowlayer(h.language)!=1){
            out.println(obj.getName(h.language)+";　");
        }
        lid.append(id).append("/");
      }
    }
    out.print("\" /> <input type='button' value='...' onclick='f_list()' /></td></tr>");
  }
  out.print("<input type='hidden' name='listing' value='"+lid.toString()+"' />");
  %>

  <tr id="EditReport_13">
    <td align="right"><%=r.getString(h.language, "频道选项")%>:</td>
    <td  rowspan="" >
      <span class="mostly"><input type="checkbox" name="mostly" id="mostly" <%if(mostly)out.print("checked");%> /><%=r.getString(h.language, "设为栏目关键")%></span>
      <span class="mostly1"><input type="checkbox" name="mostly1" id="mostly1" <%if(mostly1)out.print("checked");%> /><%=r.getString(h.language, "1204170373281")%></span>
      <span class="mostly2"><input type="checkbox" name="mostly2" id="mostly2" <%if(mostly2)out.print("checked");%> /><%=r.getString(h.language, "1204170388968")%></span>
      <%=Mark.toHtml(h.community,type,mark)%>
    </td>
  </tr>
   <tr id="EditReport_kjxs">
    <td align="right"><%=r.getString(h.language, "快捷显示")%>:</td>
    <td  rowspan="" >
      	<%
      		Enumeration e=Listing.find(" AND ll.isshowlayer = 1 ", 0, 100);
      	    while(e.hasMoreElements()){
      	    	int i=((Integer)e.nextElement()).intValue();
      	    	Listing listobj=Listing.find(i);%>
      	    	<input type="checkbox" name="isshowlayer" value="<%=i %>" <%if(lid.indexOf("/"+i+"/")>=0){out.print(" checked='true' "); lid.replace(lid.indexOf("/"+i+"/"),lid.indexOf("/"+i+"/")+("/"+i+"/").length()-1 , "");}%> ><label for="isshowlayer"><%=listobj.getName(h.language) %></label>
      	  <%}%>
     <script type="text/javascript">
     form1.listing.value="<%=lid.toString() %>";
     </script>
    </td>
  </tr>
  <tr id="Contributors_9">
    <td nowrap align="right">附件:</td>
    <td nowrap align="left"><input type="hidden" name="file" value="<%=node.getFile(h.language)%>"/><div id="t_member" style="width:400px"><%=Attch.f(node.getFile(h.language))%></div><input id="_attach" type="button" value="添加附件"/></td>
  </tr>
</table>

<center>
  <input type="hidden" name="act" value="">
  <!--完成***下一步****高级-->
  <%
  if(category.getClewtype()!=0){
    %>
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"   class="edit_button" value="<%=r.getString(h.language, "Finish")%>" onClick="form1.target='dialog_frame';">
    <%
    }else{
      %>

      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(h.language, "Finish")%>">
      <%
      }
      %>
      <!--        <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='next';" class="edit_button" value="<%=r.getString(h.language, "CBNext")%>"> -->
      <input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(h.language, "Super")%>">&nbsp;
    <input type="button"  value="返回" onClick="javascript:history.go(-1)">
</center>
</FORM>

<script>
var arr=["_subjectfilename","_subheadfilename","_authorfilename","_attach"],ups=[];
for(var i=0;i<arr.length;i++)
{
  var up;
  if(arr[i]=='_attach')
  {
    up=new Upload($$('_attach'),{resize:1000,fileTypes:"*.doc;*.docx;*.xls;*.xlsx;*.txt;*.pdf;*.jpg;*.gif;*.png;*.zip;*.rar;*.ppt"});
    up.fileQueued=function(f)
    {
      var t=document.createElement('SPAN');
      t.id=f.id;
      t.data=this;
      t.innerHTML="<img src='/tea/image/ico/"+f.type.substring(1).toLowerCase()+".gif' class='ico' />"+f.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' />";
      this.but.previousSibling.appendChild(t);
    };
    up.uploadSuccess=function(file,d,responseReceived)
    {
      var t=this.but.previousSibling.previousSibling;
      eval('d='+d.substring(d.indexOf('\n')+1));
      t.value+=d.value+'|';
    };
  }else
  {
    up=new Upload($$(arr[i]),{resize:300,buttonAction:-100});
    eval("up.fileQueued=function(f){var t=this.but.nextSibling.nextSibling;t.innerHTML='&nbsp;'+f.name+'&nbsp;<input type=checkbox onclick=ups["+i+"].setResize(checked) checked />缩小图片&nbsp;<a href=### onclick=parentNode.innerHTML=\"\";ups["+i+"].cancel()>删除</a>';}");
    up.uploadSuccess=function(file,d,responseReceived)
    {
      var t=this.but.previousSibling;
      eval('d='+d.substring(d.indexOf('\n')+1));
      t.value=d.value;
    };
    up.setResize=function(b)
    {
      this.resize=b?300:0;
      this.uploadURL=this.uploadURL.replace(/&(resize|watermark)=[^&]+/g,'')+'&resize='+this.resize;//+'&watermark='+watermark;
      //console.log(this.uploadURL);
      this.set('uploadURL',this.uploadURL);
    };
  }
  up.complete=function()
  {
    for(var i=0;i<ups.length;i++)
    {
      var file=ups[i].getFile();
      if(file)
      {
        ups[i].start();
        $$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB' + "　正在压缩中...";
        $$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
        return;
      }
    }
    $$('dialog_content').innerHTML="数据提交中,请稍等...";
    form1.submit();
  };
  ups[i]=up;
}


var mediaflag;
form1.medianame.onchange=function()
{
  if(this.value=="")
  {
    mediaflag=false;
    $$('mediashow').innerHTML='';
  }else
  mt.send("/servlet/EditMedia?act=exists&type=39&q="+encodeURIComponent(this.value),function(d)
  {
    mediaflag=parseInt(d.substring(d.indexOf('\n')+1))<1;
    var t=$$('mediashow');
    t.style.color=mediaflag?'red':'green';
    t.innerHTML=mediaflag?'该新闻来源不存在':'新闻来源可用';
  });
};

form1.medianame.onchange();
form1.classes.onchange();
form1.subject.focus();
</script>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
