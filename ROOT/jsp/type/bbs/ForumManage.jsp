<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %>
<%@ include file="/jsp/Header.jsp" %>
<%
Communitybbs community=Communitybbs.find(teasession._strCommunity);
boolean _bCommunityManage=teasession._rv._strR.equals(community.getSuperhost());
if(!_bCommunityManage&&!teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}

Http h=new Http(request,response);


Forum forum=Forum.find(teasession._strCommunity);
if(request.getMethod().equals("POST"))
{
  java.util.Enumeration enumer=Forum.findByCommunity(teasession._strCommunity);
  while(enumer.hasMoreElements())
  {
    int id=((Integer)enumer.nextElement()).intValue();
    Node node_obj=Node.find(id);
    boolean isH=h.getBool("hidden_"+id);
    if(((node_obj.getOptions1()& 2) != 0)==isH)continue;
    node_obj.setOptions1(isH?2:0);
  }

  StringBuffer auditing=new StringBuffer("/");
  StringBuffer validate=new StringBuffer("/");
  StringBuffer vertify=new StringBuffer("/");
  StringBuffer regview=new StringBuffer("/");

  String auditings[]=request.getParameterValues("auditing");
  String validates[]=request.getParameterValues("validate");
  String vertifys[]=request.getParameterValues("vertify");
  String regviews[]=request.getParameterValues("regview");

  //上传附件 按社区过滤显示
  String upfiletype = request.getParameter("upfiletype");
  int uft = 0;
  if(upfiletype!=null)
  {
    uft=1;
  }
  community.set(teasession._strCommunity,uft);


  if(auditings!=null)
  for(int index=0;index<auditings.length;index++)
  {
    auditing.append(auditings[index]+"/");
  }

  if(validates!=null)
  for(int index=0;index<validates.length;index++)
  {
    validate.append(validates[index]+"/");
  }
 if(vertifys!=null)
  for(int index=0;index<vertifys.length;index++)
  {
    vertify.append(vertifys[index]+"/");
  }

  if(regviews!=null)
  for(int index=0;index<regviews.length;index++)
  {
    regview.append(regviews[index]+"/");
  }
  StringBuffer sleep=new StringBuffer("/");
  /*
  value=request.getParameterValues("sleep");
  for(int index=0;index<value.length;index++)
  {
    sleep.append(value[index]+"/");
  }
  */
  int wait=h.getInt("wait");
  int hot=h.getInt("hot");
  int sending=h.getInt("sending");
  boolean sort=h.getBool("sort");
  float size=h.getFloat("size");
  String ext=h.get("ext").toLowerCase().replaceAll("[；，。;.]",",").replaceAll(",,+",",").replaceAll(" +","");

  forum.set(auditing.toString(),sleep.toString(),wait,hot,sending,validate.toString(),vertify.toString(),regview.toString(),sort,size,ext);

  out.println("<script>parent.mt.show('数据提交成功！');</script>");
  return;
}
r.add("/tea/resource/BBS");
%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<h1>论坛管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>&nbsp;</h2>
<FORM name="form1" action="/jsp/type/bbs/ForumManage.jsp?node=<%=teasession._nNode%>" method="post" target="_ajax" onsubmit="mt.show(null,0)">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <tr id="tableonetr">
      <TD>论坛</TD>
      <TD>已审核会员可发贴</TD>
      <TD>已邮件验证会员可发贴</TD>
      <TD>发贴是否要验证码</TD>
      <TD>只有注册会员可看</TD>
      <TD>发贴是否需要审核</TD>
      <%
      String auditing=MT.f(forum.getAuditing(),"/");
      String validate=MT.f(forum.getValidate(),"/");
      String vertify=MT.f(forum.getVertify(),"/");
      String regview=MT.f(forum.getRegview(),"/");
      java.util.Enumeration enumer=Forum.findByCommunity(teasession._strCommunity);
      while(enumer.hasMoreElements())
      {
        int id=((Integer)enumer.nextElement()).intValue();
        Node node_obj=Node.find(id);
        %>
<tr>
<td><%=node_obj.getAnchor(teasession._nLanguage)%>
<td><input type="checkbox" name="auditing" value="<%=id%>" <%if(auditing.indexOf("/"+id+"/")!=-1)out.print(" checked ");%> /></td>
<td><input type="checkbox" name="validate" value="<%=id%>" <%if(validate.indexOf("/"+id+"/")!=-1)out.print(" checked ");%>></td>
<td><input type="checkbox" name="vertify" value="<%=id%>" <%if(vertify.indexOf("/"+id+"/")!=-1)out.print(" checked ");%>></td>
<td><input type="checkbox" name="regview" value="<%=id%>" <%if(regview.indexOf("/"+id+"/")!=-1)out.print(" checked ");%>></td>
<td><input type="checkbox" name="hidden_<%=id%>" value="true" <%if((node_obj.getOptions1()& 2) != 0)out.print(" checked ");%>></td>
<%
}
%>


</table>


<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr>
    <td>等待： </TD>
    <td align="left"><input name="wait" type="text" value="<%=forum.getWait()%>" size="4" mask="int"/>分</td>
    <td>新注册的会员间隔多长时间才可以发贴
  </tr>
  <tr>
    <td>热贴： </TD>
    <td align="left"><input name="hot" type="text" value="<%=forum.getHot()%>" size="4" mask="int"/></td>
    <td>贴子的回复数量大于多少才算热贴
  </tr>
  <tr>
    <td>专家： </TD>
    <td align="left"><input name="sending" type="text" value="<%=forum.getSending()%>" size="4" mask="int"/></td>
    <td>给专家多少积分
  </tr>
  <tr>
    <td>选项:<td><input type="checkbox" name="upfiletype" value="1" <%if(community.getUpFileType()==1)out.print("checked");%>/>帖子上传附件显示/隐藏设置</td>
  </tr>
  <tr>
    <td>贴子排序:
    <td>
      <input name="sort" type="radio" value="false" id="sort0" checked="checked" /><label for="sort0">升序</label>
      <input name="sort" type="radio" value="true" id="sort1" <%if(forum.isSort())out.print(" checked='true'");%> /><label for="sort1">降序</label>
    </td>
    <td>贴子的排列方式
  </tr>
  <tr>
    <td>附件大小： </TD>
    <td align="left"><input name="size" type="text" value="<%=forum.getSize()%>" size="8" mask="float"/>M</td>
    <td>上传附件大小限制
  </tr>
  <tr>
    <td>附件格式： </TD>
    <td align="left"><input name="ext" type="text" value="<%=forum.getExt()%>" size="50" /></td>
    <td>
  </tr>
</table>

  <INPUT class="BigButton" type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br>
</FORM>
<br/>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
<%//=r.getString(teasession._nLanguage,"ForumManageNote")%>
</BODY>
</html>
