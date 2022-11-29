<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/deptuser");

Communitybbs community= Communitybbs.find(teasession._strCommunity);
boolean _bCommunityManage=teasession._rv._strR.equals(community.getSuperhost());
if(!_bCommunityManage&&!teasession._rv.isWebMaster())
{
  response.sendError(403);
  return;
}

boolean flag=Boolean.parseBoolean(request.getParameter("flag"));
String member=request.getParameter("member");
AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,member);

if("POST".equals(request.getMethod()))
{
  if(!Profile.isExisted(member))
  {
    out.print("<script>alert('"+r.getString(teasession._nLanguage,"InvalidMemberId")+"');</script>");
    return;
  }
  String bbshost=request.getParameter("bbshost");
  if(flag)
  {
    aur_obj.setBbsExpert(bbshost);
    //赠送积分
    int min=Forum.find(teasession._strCommunity).getSending();
    Profile p=Profile.find(member);
    if(p.getIntegral()<min)p.setIntegral(min);
  }else
  aur_obj.setBbsHost(bbshost);
  out.print("<script>alert('信息修改成功!');parent.window.returnValue=true;parent.window.close();</script>");
  return;
}

String pur=flag?aur_obj.getBbsExpert():aur_obj.getBbsHost();

%>
<html>
<head>
<title>用户管理</title>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  if(!submitMemberid(document.form1.member,"用户名不正确,格式:长度最小2位,内容只能是 数字，字母，下划线(_)和减号(-)"))
  {
    return (false);
  }
  var v="/";
  var op=document.form1.toList.options;
  for (var i=0; i< op.length; i++)
  {
    v=v+op[i].value+"/";
  }
  form1.bbshost.value=v;
}
</SCRIPT>
</head>
<BODY onLoad="try{ form1.member.focus(); }catch(e){}" >

<div id="head6"><img height="6" src="about:blank"></div>
<iframe src="" style="display:none" name="dialog"></iframe>

<form name="form1" action="?" method="post" onSubmit="" target="dialog">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="bbshost" value="/"/>
<input type="hidden" name="flag" value="<%=flag%>"/>


<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "ID")%>：</td>
    <td style="line-height:100%;padding-top:0px;"><%
    if(member!=null)
    {
      out.print("<input type=hidden value="+member+" name=member><input type=text value="+member+" disabled>");
    }else
    {
      out.print("<span style=position:absolute class=position>");
      out.print("<select name=selectmenu style=\"position:absolute; top:0px; width:110px; height:0px; left:0px; clip:rect(0 180 110 90)\" onChange=form1.member.value=this.value><option value=\"\" selected>---------------------</option>");
      java.util.Enumeration e=Profile.findByCommunity(teasession._strCommunity);
      while(e.hasMoreElements())
      {
        String value=e.nextElement().toString();
        out.println("<option value='"+value+"'>"+value+"</option>");
      }
      out.print("</select>");
      out.print("<input name=member onMouseOver=\"this.select();this.focus();\" style=\"position:absolute; top:0px; width:95px; height:21px; left:0px;\">");
      out.print("</span>");
    }
    %>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BBS")%>： </td>
    <td><table cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" align="left" borderColorLight="#666666" border="1">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SelectBBS")%></td>
        <td>&nbsp;</td>
        <td><%=r.getString(teasession._nLanguage, "StandbyBBS")%></td>
      </tr>
      <tr>
        <td><select name="toList"  multiple style="border-width:0px; WIDTH: 140px; " size="10" ondblclick="move(form1.toList,form1.fromList,true)" width="100%" >
        <%
        java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(pur,"/");
        while(tokenizer_obj.hasMoreTokens())
        {
          int id=Integer.parseInt((String)tokenizer_obj.nextElement());
          Node ar_obj=Node.find(id);
          out.println("<option value="+id+" >"+ar_obj.getSubject(teasession._nLanguage));
        }
        %>
        </select></td>
        <td><input onClick="fromList.ondblclick();" type="button" value=" ← " id=button1 name=button1>
          <br>
            <input  onClick="toList.ondblclick();" type="button" value=" → " id=button2 name=button2>
        </td>
        <td><select ondblclick="move(form1.fromList,form1.toList,true);" width="100%" style="WIDTH: 140px; " size="10" name="fromList" multiple>
        <%
        Enumeration e=BBSForum.findByCommunity(teasession._strCommunity);
        while(e.hasMoreElements())
        {
          int nid=((Integer)e.nextElement()).intValue();
          if(pur.indexOf("/"+nid+"/")==-1)
          out.println("<option value="+nid+">"+Node.find(nid).getSubject(teasession._nLanguage));
        }
        %>
        </select>
             </td>
          </tr>
        </table></td>
    </tr>
   </table>
<input type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<input type="button" onClick="window.close();" value="关闭" />
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
