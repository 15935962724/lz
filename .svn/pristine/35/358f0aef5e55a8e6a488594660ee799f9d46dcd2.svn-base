<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %>
<%!
private void tree1(java.io.Writer jw,int nodecode,int step,int language,String function,String name,String member)throws Exception
{ 
	
	  java.util.Enumeration enumer=Node.find(" AND finished = 1 AND hidden = 0 AND father="+nodecode+" ORDER BY sequence asc ",0,200);
	  if(!enumer.hasMoreElements()){
		  jw.write("暂无记录");
	  }
	  while(enumer.hasMoreElements())
	  {
	    int j=((Integer)enumer.nextElement()).intValue();
	    Node n=Node.find(j);
	    
	    Category category = Category.find(j);
	    if((n.getType()==0 || n.getType()==1)&&(n.getOptions1() & 8) != 0){

	      if(n.getType()==0)
	      {
	        jw.write("<a href='###' onclick=fclick3("+j+"); >");
	       		 jw.write("<img id=img"+j+" src=/tea/image/tree/tree_plus.gif >");
	        jw.write("</a>");
	      }else//功能菜单
	      {
	    	  //类别
	         jw.write("<img src=/tea/image/tree/tree_blank.gif ID=img"+j+" />");
	      }
	      
	      
	      
	      jw.write("<input type=checkbox name="+name+" id=check"+j+" value="+j+" ");
	      if(function!=null&&function.indexOf("/"+j+"/")!=-1)
	      {
	    	  jw.write(" checked ");
	      }
	    	jw.write(" onclick=fsel(document.getElementById('div"+j+"'),this.checked)   style=cursor:pointer>&nbsp;");
	    	
	     jw.write("<a id=test href=###  style=cursor:pointer ");
	     
	    	 jw.write(" onclick=fclick5('"+member+"','"+j+"');");
 
	     jw.write(">");
	     
	     	 jw.write(n.getSubject(language));
	     	 
	     
	     	
	      jw.write("</a><br/>");
	
	   
	      jw.write("<div class='tree' style=display:none  id=div"+j+">");
	      if(n.getType()==0)
	      {
	        tree1(jw,j,step+1,language,function,name,member);
	      }
	      jw.write("</div>\r\n");
	    }
	  
  	}
}
%><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


int root= Node.getRoot(teasession._strCommunity);
request.setCharacterEncoding("UTF-8");
String member = teasession.getParameter("member");
AdminUsrRole aobj = AdminUsrRole.find(teasession._strCommunity,member);

if("POST".equals(request.getMethod()))
{
	String ethernet = teasession.getParameter("ethernet");
	StringBuffer sp = new StringBuffer("/");
	if(ethernet!=null && ethernet.length()>0)
	{
		String earr [] = teasession.getParameterValues("ethernet");
		for(int i=0;i<earr.length;i++)
		{
			sp.append(earr[i]).append("/");
			
		}
	}
	aobj.setContentfunction(sp.toString());
	out.print("<script>alert('菜单设置成功!');window.returnValue=1;window.close();</script>");
}
%>

<html>
<head>
<title>内容管理权限</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
window.name='tar';
function fsel(obj,bool)
{
  fclick(obj,bool);
  if(bool)
  fclick4(obj,bool);
}

function fclick(obj,bool)
{
  for(var objchild=obj.firstChild;objchild;objchild=objchild.nextSibling)
  {
    if(objchild.type=='checkbox')
    objchild.checked=bool;
    else
    fclick(objchild,bool);
  }
}

function fclick4(obj)
{
  obj=obj.parentNode;
  if(obj)
  {
    var idvalue=obj.id;
    if(idvalue&&idvalue.indexOf("div")==0)
    {
      document.getElementById("check"+idvalue.substring(3)).checked=true;
    }
    fclick4(obj);
  }
}

function fclick3(j)
{
	
  if(document.getElementById("div"+j).style.display=="")
  {
    document.getElementById("div"+j).style.display='none';
    document.getElementById("img"+j).src='/tea/image/tree/tree_plus.gif';
  }else
  {
    document.getElementById("div"+j).style.display='';
    document.getElementById("img"+j).src='/tea/image/tree/tree_minus.gif';
  }
}
function fclick5(igd,igd2)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:350px;dialogHeight:220px;';
	 var url = '/jsp/admin/popedom/MemberNodeRole2.jsp?member='+encodeURIComponent(igd)+'&node='+igd2+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1){ 
		 window.location.reload();
	 }
} 
</script>
<style type="text/css">.tree{padding-left:15px;}
a#test:hover{text-decoration:underline;color:#00f;}
</style>
</head>
<h1>内容管理权限</h1>
<body id="leftup" scroll="yes">
<div id="leftupdiv2">
	<div id="leftup_bottom" >
	<form name="form1" action="?" method="POST" target="tar">
	<input type="hidden" name="member" value="<%=member %>"/>
	<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
	
	<table border="0" align="left" cellpadding="0" cellspacing="0" id="tablecenter" >
		<tr><td ><%tree1(out,root,0,teasession._nLanguage,aobj.getContentfunction(),"ethernet",member);%></td></tr> 
		<tr><td><input type="submit" value="提交"/>&nbsp;<input type="button" value="关闭" onClick="javascript:window.close();"> </td></tr>
	</table>
	</form>
	</div>
	
</div>
</body>
</html>
