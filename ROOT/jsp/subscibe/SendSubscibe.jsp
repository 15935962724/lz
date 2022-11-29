<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.service.SendEmaily" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

//此周期内默认选中
CommunityOption co=CommunityOption.find(teasession._strCommunity);
String ssubnode=co.get("subnode");
String nodes[]=ssubnode==null?new String[]{}:ssubnode.split("/");
int subday=co.getInt("subday");
String cmnode=co.get("customnode");
String  cutsnode[]=cmnode==null?new String[]{}:cmnode.split("/");
if(subday==0)subday=1;
Calendar ca=Calendar.getInstance();
ca.add(Calendar.DAY_OF_YEAR,-subday);
Date time=ca.getTime();
String url=request.getRequestURL().substring(0,request.getRequestURL().length()-request.getRequestURI().length());
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<style>.tree{padding-left:20px;}</style>
<script type="text/javascript">
function f_ex(obj)
{
  var d=obj.parentNode;
  while(d.tagName!="DIV")
  {
    d=d.nextSibling;
  }
  if(obj.src.indexOf("plus")!=-1)
  {
    obj.old=obj.src;
    obj.src="/tea/image/tree/tree_blank.gif";
    d.style.display="";
  }else
  {
    obj.src=obj.old;
    d.style.display="none";
  }
}
function f_se(obj)
{
  
  var d=obj.nextSibling.nextSibling.nextSibling;
  var is=d.getElementsByTagName("INPUT");
  for(var i=0;i<is.length;i++)
  {
    is[i].checked=obj.checked;
  }

}
function f_pa(obj)
{
  if(obj.checked)
  {
    var d=obj.parentNode;
    while(d.tagName!="INPUT")
    {
      d=d.previousSibling;
    }
    d.checked=true;
  }
}
function f_tb()
{
  if(form1.type[0].checked)
  {
    tb0.style.display="";
    tb1.style.display="none";
  }else
  {
    tb0.style.display="none";
    tb1.style.display="";
  }
}
function f_submit()
{
  if(form1.type[0].checked)
  {
    for(var i=0;i<form1.nodes.length;i++)
    {
      if(form1.nodes[i].checked)
      {
        var f=form1.nodes[i].parentNode.nextSibling;
        f.value=f.value+form1.nodes[i].value+"/";
      }
    }
  }else
  {
    //return submitText(form1.url,"网址不能为空...");
	  if(form1.url.value.trim()==""){
	    	 alert("网址不能为空...");
	    	 return false;
	     }
  }
  if(form1.email.value != ""){
	     var v = /(\S)+[@]{1}(\S)+[.]{1}(\w)+/;
	    var mails=form1.email.value.split(",");
	       for(var j = 0;j <= (mails.length - 1);j++){
	    	   if(j==(mails.length - 1)&&mails[j].trim()==""){
	    		   return true;
	    	   }
	       if(!v.test(mails[j]))
	       {
	         alert("您的邮箱地址有误"+mails[j]);
	 	return false;
	       }
	    }

	      return true;
	  }else{
		  if(form1.check_email.checked){
			   alert("邮箱地址不能为空");
			    return false;
			}
  }
}

function changeUrl(url,nid){
selectAll(form1.nodeurls,false);
document.getElementById(nid).checked=true;
	form1.url.value=url;
}
</script>
</head>
<body>
<h1>发送</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="/servlet/Subscibes" target="_ajax" method="POST" onsubmit="return f_submit()&&mt.show(null,0);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="send"/>
<input type="hidden" name="nexturl"/>

<table cellSpacing="0" cellPadding="0" width="100%"  border="0" id="tablecenter">
<tr>
<td align="right">发送类型:</td>
<td>
  <input type="radio" name="type" value="0" onclick="f_tb()" id="t0" checked="checked"/><label for="t0">网页列表</label>
  <input type="radio" name="type" value="1" onclick="f_tb()" id="t1" /><label for="t1">网页内容</label>
</td>
</tr>
<tbody id="tb0">
<tr>
<td>
  <td>
<%
for(int z=1;z<nodes.length;z++)
{
  int father=Integer.parseInt(nodes[z]);
  Node f=Node.find(father);
  if(f.getTime()==null)
  {
    continue;
  }
  boolean fsel=false;
  StringBuilder h=new StringBuilder();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT n.node FROM Node n WHERE n.father="+father+" AND hidden=0 ORDER BY n.node DESC",0,200);
    for(int i=0;db.next();i++)
    {
      int node=db.getInt(1);
      Node obj=Node.find(node);
      boolean nsel=time.compareTo(obj.getTime())==-1;
      if(i>20&&!nsel)
      {
        break;
      }
      h.append("<input type='checkbox' name='nodes' onclick='f_pa(this);' value='"+node+"'");
      if(nsel)
      {
        fsel=true;
        h.append(" checked='true'");
      }
      h.append(">");
      h.append("<a href=/servlet/Node?node="+node+" target=_blank>"+obj.getSubject(teasession._nLanguage)+"</A>");
      h.append(" ["+obj.getTimeToString()+"]<br>");
    }
  }finally
  {
    db.close();
  }
  if(h.length()>0)
  {
    out.print("<a href='###'><img src='/tea/image/tree/tree_plus.gif' onclick='f_ex(this)'></a>");
    //else
    //out.print("<img src='/tea/image/tree/tree_blank.gif'>");
    out.print("<input type='checkbox' name='fathers' onClick='f_se(this);' value='"+father+"'");
    if(fsel)
    {
      out.print(" checked='true'");
    }
    out.print(">");
    out.print("<span>"+f.getSubject(teasession._nLanguage)+"</span>"+"<br>");
    out.print("<div class='tree' style='display:none'>");
    out.print(h.toString());
    out.print("</div>");
    out.print("<input type='hidden' name='f"+father+"' value='/' />");
  }
}
%>
<tr><td><td><input type="checkbox" onClick="selectAll(form1.fathers,checked);selectAll(form1.nodes,checked);"><%=r.getString(teasession._nLanguage,"SelectAll")%></td></tr>
</tbody>
<tbody id="tb1" style="display:none">
<tr>
<td>
  <td>
<%
for(int z=1;z<nodes.length;z++)
{
  int father=Integer.parseInt(nodes[z]);
  Node f=Node.find(father);
  if(f.getTime()==null)
  {
    continue;
  }
  boolean fsel=false;
  StringBuilder h=new StringBuilder();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT n.node FROM Node n WHERE n.father="+father+" AND hidden=0 ORDER BY n.node DESC",0,200);
    for(int i=0;db.next();i++)
    {
      int node=db.getInt(1);
      Node obj=Node.find(node);
      boolean nsel=time.compareTo(obj.getTime())==-1;
      if(i>20&&!nsel)
      {
        break;
      }
      h.append("<input type='checkbox' name='nodeurls' id='t"+node+"' onclick=changeUrl('"+url+"/html/"+teasession._strCommunity+"/report/"+node+"-"+teasession._nLanguage+".htm','t"+node+"'); value='"+node+"'");
      if(nsel)
      {
        fsel=true;
        h.append(" checked='true'");
      }
      h.append(">");
      h.append("<a href=/servlet/Node?node="+node+" target=_blank>"+obj.getSubject(teasession._nLanguage)+"</A>");
      h.append(" ["+obj.getTimeToString()+"]<br>");
    }
  }finally
  {
    db.close();
  }
  if(h.length()>0)
  {
    out.print("<a href='###'><img src='/tea/image/tree/tree_plus.gif' onclick='f_ex(this)'></a>");
    
    /*out.print("<input type='checkbox' name='fathers' onClick='f_se(this);' value='"+father+"'");
    if(fsel)
    {
      out.print(" checked='true'");
    }
    out.print(">");*/
    out.print(f.getSubject(teasession._nLanguage)+"<br>");
    out.print("<div class='tree' style='display:none'>");
    out.print(h.toString());
    out.print("</div>");
    out.print("<input type='hidden' name='f"+father+"' value='/' />");
  }

} 
for(int i=1;i<cutsnode.length;i++){
	out.print("<input type='checkbox' id='n"+cutsnode[i]+"' name='nodeurls' onclick=changeUrl('"+url+"/html/"+teasession._strCommunity+"/report/"+cutsnode[i]+"-"+teasession._nLanguage+".htm','n"+cutsnode[i]+"'); value='"+cutsnode[i]+"' >");
	int nid=Integer.parseInt(cutsnode[i]);
	Node  obj=Node.find(nid);
	out.print("<a href='/servlet/Node?node="+nid+"' target=_blank>"+obj.getSubject(teasession._nLanguage)+"</a><br>");
}
%>
<%--<tr><td><td><input type="checkbox" onClick="selectAll(form1.fathers,checked);selectAll(form1.nodes,checked);"><%=r.getString(teasession._nLanguage,"SelectAll")%></td></tr>--%>
<tr>
  <td align="right">网址:</td>
  <td><input type="text" name="url" size="80"/></td>
</tr>
</tbody>
<tr>
  <td align="right">主题:</td><td><input type="text" name="theme" size="40"/></td>
</tr>
<tr>
  <td align="right">内容:</td>
  <td><textarea name="contents" id="text" rows="5" cols="50"></textarea></td>
</tr>
<tr>
  <td align="right">附加E-Mail:</td>
  <td>
    您共输入了<span id="emailNums">0</span>个邮箱地址(以“,”分隔多个邮箱地址)<br><br>
    <textarea id="email" name="email" rows="5" cols="50" onkeydown="countEmailAddr();" onkeyup="countEmailAddr();"></textarea>
  </td>
</tr>
<tr>
  <td align="right">只发送附加E-Mail:</td>
  <td><input type="checkbox" name="check_email" value="1" checked="checked"/></td>
</tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSend")%>"/>
</form>
<script type="">
form1.nexturl.value=location.pathname+location.search;
function countEmailAddr()
{
  var mails = form1.email.value.split("@");
  document.getElementById("emailNums").style.display = "";
  var i = mails.length - 1;
  document.getElementById("emailNums").innerHTML = i;
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>
