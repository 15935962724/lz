<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.html.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(request.getParameter("ajax")!=null)
{
	int card=Integer.parseInt(request.getParameter("card"));

    if(card<99999)
    {
    	Enumeration e=Card.find(" AND card LIKE "+DbAdapter.cite(card+"__"),0,100);
        while(e.hasMoreElements())
        {
      	  Card c=(Card)e.nextElement();
      	  out.print("op[op.length]=new Option('"+c.getAddress()+"','"+c.getCard()+"');");
        }
    }else
    {
    	Enumeration e=Street.find(" AND card="+card,0,100);
        while(e.hasMoreElements())
        {
        	Street c=(Street)e.nextElement();
      	  	out.print("op[op.length]=new Option('"+c.getName()+"','"+c.getStreet()+"');");
        }
    }
    return;
}

if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

Node node=Node.find(teasession._nNode);

String subject=null,content=null;
int street=0,card=0;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_c(value,s)
{
	var op=s.options;
	while(op.length>1)
	{
	  op[1]=null;
	}
	sendx("?ajax=ON&card="+value,function aa(d){ eval(d); } );
}
</script>
</head>
<body onload="form1.subject.focus();">

<h1>District</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM NAME="form1" ACTION="/servlet/EditDistrict" METHOD="post" onSubmit="return submitText(this.subject,'无效-名称')&&submitText(this.street,'无效-街道');">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
<%
if(request.getParameter("NewNode")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  subject=node.getSubject(teasession._nLanguage);
  content=HtmlElement.htmlToText(node.getText(teasession._nLanguage));

  District d=District.find(teasession._nNode,teasession._nLanguage);
  street=d.getStreet();
  
  Street s=Street.find(street);
  card=s.getCard();
}
%>            
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD>名称</TD>
      <TD><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>">
      </TD>
	</tr>
    <tr>
      <TD>街道</TD>
      <TD>
      <select name=s1 onchange="f_c(this.value,form1.s2);">
      <option value="" >--------------
      <%
      Enumeration e=Card.find(" AND card<100",0,100);
      while(e.hasMoreElements())
      {
    	  Card c=(Card)e.nextElement();
    	  out.print("<option value="+c.getCard()+" >"+c.getAddress());
      }
      %>
      </select>
      <select name=s2 onchange="f_c(this.value,form1.s3);">
      <option value="" >--------------
      </select>
      <select name=s3 onchange="f_c(this.value,form1.street);">
      <option value="" >--------------
      </select>
      <select name=street>
      <option value="0" >--------------
      </select>
      <%
      if(street>0)
      {
    	  out.println("<script>");
          String str=String.valueOf(card);
    	  if(str.length()>5)
    	  {
    		  out.println("form1.s1.value='"+str.substring(0,2)+"';form1.s1.onchange();");
    		  out.println("var v2=setInterval(\" if(form1.s2.options.length>1){form1.s2.value='"+str.substring(0,4)+"';form1.s2.onchange(); clearInterval(v2); } \",50);");
    		  out.println("var v3=setInterval(\" if(form1.s3.options.length>1){form1.s3.value='"+str.substring(0,6)+"';form1.s3.onchange(); clearInterval(v3); } \",50);");
    		  out.println("var v4=setInterval(\" if(form1.street.options.length>1){form1.street.value='"+street+"'; clearInterval(v4); } \",50);");
    	  }
    	  out.println("</script>");
      }
      %>
      </TD>
    </tr>       
    <tr>
      <TD>内容</TD>
      <TD><textarea name="content" cols="50" rows="5"><%if(content!=null)out.print(content);%></textarea>
      </TD>
    </tr>
  </TABLE>
  <input type="submit" value="提交">
  <input type="reset" value="重置">
  <input type="button" value="返回" onClick="window.history.back();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
