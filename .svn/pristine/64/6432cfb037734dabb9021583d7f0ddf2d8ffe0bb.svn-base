<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crbookin=Integer.parseInt(request.getParameter("crbookin"));
String scrbid=null,classno=null,swname=null,shortname=null,author=null,nation=null,pubdate=null,pubarea=null,price=null,pricedollar=null,version=null,passdate=null,remark1=null,remark2=null;

if(crbookin>0)
{
	Crbookin obj=Crbookin.find(crbookin);
	scrbid=obj.getScrbid();
	classno=obj.getClassno();
	swname=obj.getSwname();
	shortname=obj.getShortname();
	author=obj.getAuthor();
	nation=obj.getNation();
	pubdate=obj.getPubdateToString();
	pubarea=obj.getPubarea();
	price=obj.getPrice();
	pricedollar=obj.getPricedollar();
	version=obj.getVersion();
	passdate=obj.getPassdateToString();
	remark1=obj.getRemark1();
	remark2=obj.getRemark2();
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.scrbid.focus();">

<h1>计算机软件著作权登记公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-登记号')&&submitText(this.classno,'无效-分类号')&&submitText(this.swname,'无效-软件名称');">
  <input type="hidden" name="act" value="editcrbookin"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crbookin" value="<%=crbookin%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD >登记号</TD>
      <TD><input type="text" name="scrbid" <%if(crbookin>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>">
      </TD>
      <TD >分类号</TD>
      <TD><input type="text" name="classno" value="<%if(classno!=null)out.print(classno);%>">
      </TD>
    </tr>
    <tr>
      <TD>软件名称</TD>
      <TD><input type="text" name="swname" value="<%if(swname!=null)out.print(swname);%>">
      </TD>
      <TD>简称</TD>
      <TD><input type="text" name="shortname" value="<%if(shortname!=null)out.print(shortname);%>">
      </TD>
    </tr>
    <tr>
      <TD>著作权人姓名</TD>
      <TD><input type="text" name="author" value="<%if(author!=null)out.print(author);%>">
      </TD>
      <TD>著作权人国籍</TD>
      <TD><input type="text" name="nation" value="<%if(nation!=null)out.print(nation);%>">
      </TD>
    </tr>
    <tr>
      <TD>软件首次发表日期</TD>
      <TD><input type="text" name="pubdate" value="<%if(pubdate!=null)out.print(pubdate);%>">
      </TD>
      <TD>软件首次发表地区</TD>
      <TD><input type="text" name="pubarea" value="<%if(pubarea!=null)out.print(pubarea);%>">
      </TD>
    </tr>
    <tr>
      <TD>软件零售价（￥）</TD>
      <TD><input type="text" name="price" value="<%if(price!=null)out.print(price);%>">
      </TD>
      <TD>软件零售价（$）</TD>
      <TD><input type="text" name="pricedollar" value="<%if(pricedollar!=null)out.print(pricedollar);%>">
      </TD>
    </tr>
    <tr>
      <TD>版本登记号</TD>
      <TD><input type="text" name="version" value="<%if(version!=null)out.print(version);%>">
      </TD>
      <TD>批准日期</TD>
      <TD><input type="text" name="passdate" value="<%if(passdate!=null)out.print(passdate);%>">
      </TD>
    </tr>
    <tr>
      <TD colspan="4">备注1</TD>
    </tr>
    <tr>
      <TD colspan="4"><textarea name="remark1" cols="50" rows="5"><%if(remark1!=null)out.print(remark1);%></textarea>
      </TD>
    </tr>
    <tr>
      <TD colspan="4">备注2</TD>
    </tr>
    <tr>
      <TD colspan="4"><textarea name="remark2" cols="50" rows="5"><%if(remark2!=null)out.print(remark2);%></textarea>
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

