<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");


Resource r=new Resource();

String name=null,content=null,manager=null,member=null;
java.util.Date ftime=null;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.name.focus();
}
function f_add(s1,s2)
{
	if(s1.selectedIndex!=-1)
	{
	    var s1_op=s1.options[s1.selectedIndex];
	    var s2_o=s2.options;
	    for(var i=0;i<s2_o.length;i++)
	    {
	    	if(s2_o[i].value==s1_op.value)
	    	return;
	    }
		s2_o[s2_o.length]=new Option(s1_op.text,s1_op.value);
	}
}
function f_del(s1)
{
	if(s1.selectedIndex!=-1)
	{
	    s1.options[s1.selectedIndex]=null;
	}
}
function f_submit()
{
	   var s1_o=form1.manager1.options;
	   for(var i=0;i<s1_o.length;i++)
	   {
	    	form1.manager.value=form1.manager.value+s1_o[i].value+"/";
	   }
	   var s2_o=form1.member1.options;
	   for(var i=0;i<s2_o.length;i++)
	   {
	    	form1.member.value=form1.member.value+s2_o[i].value+"/";
	   }

	  var param="/jsp/admin/flow/QueryResults.jsp?";
	  var el=form1.elements;
	  for(var i=0;i<el.length;i++)
      {
        if(el[i].name.length>0&&el[i].value.length>0)
		  param=param+"&"+el[i].name+"="+encodeURIComponent(el[i].value);
      }
      window.opener.location=param;
      window.close();
      return false;
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>请输入你曾参加过的项目名称</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" method="post" onSubmit="return f_submit();">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="act" value="queryflowitem"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
        <td nowrap>项目名称</td>
         <td nowrap>　<input name="name" type="text" value="<%if(name!=null)out.print(name);%>" size="40"></td>
       </tr>
         <tr>
        <td nowrap>项目状态</td>
         <td nowrap>　<select name="states" >
         <option value="">-------------
         <%
         for(int i=0;i<Flowitem.STATES_TYPE.length;i++)
	     {
	        out.print("<option value="+i+">　"+r.getString(teasession._nLanguage,Flowitem.STATES_TYPE[i]));
	     }
         %>
         </select></td>
       </tr>
       <tr>
         <td nowrap>项目经理</td>
         <td nowrap><input type=hidden name=manager value="/" >
         <table border="0" cellpadding="0" cellspacing="0"><tr><td>
         <select name="manager1" size="5" style="width:180px" onDblClick="f_del(form1.manager1);">
         <%
         if(manager!=null)
         {
	         String str[]=manager.split("/");
	         for(int i=1;i<str.length;i++)
	         {
	        	 Profile p=Profile.find(str[i]);
	        	 out.print("<option value=\""+str[i]+"\" >　"+str[i]+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
	         }
         }
         %>
          </select>
          <td>
          <input type=button value="←" onclick="f_add(form1.manager2,form1.manager1);"><br>
          <input type=button value="→" onclick="f_del(form1.manager1);">
          <td>
         <select name="manager2" size="5" style="width:180px" onDblClick="f_add(form1.manager2,form1.manager1);">
         <%
         StringBuffer sb=new StringBuffer();
         java.util.Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
         for(int intCount=1;e.hasMoreElements();intCount++)
         {
           AdminUnit au_obj=(AdminUnit)e.nextElement();
           int unltid=au_obj.getId();
           java.util.Enumeration e2=AdminUsrRole.findByUnit(unltid,teasession._strCommunity);
           if(e2.hasMoreElements())
           {
        	   sb.append("<OPTGROUP label=").append(au_obj.getName()).append("></OPTGROUP>");
	           while(e2.hasMoreElements())
	           {
	             String _member=(String)e2.nextElement();
	             Profile p=Profile.find(_member);
	             if(p!=null)
	             {
	            	 sb.append("<option value=\""+_member).append("\" >　").append(_member).append(" ( ").append(p.getFirstName(teasession._nLanguage)).append(p.getLastName(teasession._nLanguage)).append(" )</option>");
	             }
	           }
           }
         }
         out.print(sb.toString());
		 %>
          </select>
 			</tr></table>
         <%--<input type=button value=添加 onclick="window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?type=1&field=member&index=form1.manager','','edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;');" >--%>
         </td>
       </tr>
       <tr>
         <td nowrap>项目参与者</td>
         <td nowrap><input type=hidden name=member value="/"  >
         <table border="0" cellpadding="0" cellspacing="0"><tr><td>
         <select name="member1" size="7" style="width:180px" onDblClick="f_del(form1.member1);">
         <%
         if(manager!=null)
         {
	         String str[]=member.split("/");
	         for(int i=1;i<str.length;i++)
	         {
	        	 Profile p=Profile.find(str[i]);
	        	 out.print("<option value=\""+str[i]+"\" >　"+str[i]+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
	         }
         }
         %>
          </select>
          <td>
          <input type=button value="←" onclick="f_add(form1.member2,form1.member1);"><br>
          <input type=button value="→" onclick="f_del(form1.member1);">
          <td>
         <select name="member2" size="7" style="width:180px" onDblClick="f_add(form1.member2,form1.member1);">
         <%=sb.toString()%>
          </select>
 			</tr></table>
         </td>
       </tr>
  </table>
           <input type="submit" value="提交">
           <input type="reset" value="重置" onClick="defaultfocus();">
           <input type="button" value="关闭" onClick="window.close();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>


