<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.db.*" %><%@ page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


Resource r=new Resource();
 
String newemail="";
if(session.getAttribute("tea.newemail")!=null)
newemail=(String)session.getAttribute("tea.newemail");
CommunityOption co=CommunityOption.find(teasession._strCommunity);
String nodes[]=co.get("subnode").split("/");

String cmnode=co.get("customnode");
String  nodes2[]=cmnode==null?new String[]{}:cmnode.split("/");
int lens=nodes.length+nodes2.length;
String email="";
String snode="";
if(newemail!=null)
{email =newemail;
 snode=Subscibe.find(teasession._strCommunity,email).getNode();
}
if(teasession._rv!=null)
 {Profile profile=Profile.find(teasession._rv._strV);
 email=profile.getEmail();
 snode=Subscibe.find(teasession._strCommunity,email).getNode();
 //System.out.println("snode:"+snode);
}

Community cobj = Community.find(teasession._strCommunity);
%>
function checkEmail(){
	var tmail=form_subscibe.email.value;
	if(tmail.trim()==""){
		alert("Please enter a correct email address.");
		return false;
	}else{
		var v = /(\S)+[@]{1}(\S)+[.]{1}(\w)+/;
		if(!v.test(tmail)){
			alert("Please enter a correct email address.");
			return false;
		}else{
			return true;
		}
	}
}
//<script>
document.write("<div class=title>邮件订阅</div><div class=con><form name='form_subscibe' method='post' action='/servlet/Subscibes' TARGET='form_subscibe_iframe' onSubmit=\"return <%if(nodes.length>2){out.print("submitCheckbox(this.nodes,'请先选择栏目')&&");}%>submitText(this.email,'无效邮件地址');\" >");
document.write("<input type='hidden' name='community' value='<%=teasession._strCommunity%>' />");
document.write("<input type='hidden' name='act' value='edit' />");
document.write("<iframe name='form_subscibe_iframe' id='form_subscibe_iframe' src='about:blank' style='display:none'></iframe>");
document.write("<table>");
document.write("<%
int j=1;
if(lens==0){
	
}else if(lens==2){
	 String nodid=nodes.length==2?nodes[1]:nodes2[1];
	  out.print("<tr><td id ='jxtdid'><input name='nodes'  type='hidden' value='"+nodid+"' ></td></tr>");	
}else{
	for(int i=1;i<lens;i++)
	{String ischecked="";
	  int node=0;
	  if(i<nodes.length){
	  	node=Integer.parseInt(nodes[i]);
	  }else{
		  if(nodes2[i-nodes.length].trim().length()==0){
			  continue;
		  }
		  node=Integer.parseInt(nodes2[i-nodes.length]);
	  }
	  
	  Node n=Node.find(node);
	  if(n.getTime()==null)
	  {
	    j++;
	    continue;
	  }
	  if((i-j)%3==0)
	  {
	    out.print("<tr>");
	  }
	 // if(snode.indexOf("/"+nodes[i]+"/")>=0)
	//  ischecked="checked";
	//  out.print("<td id ='jxtdid'><input name='nodes' "+ischecked+" type='checkbox' value='"+node+"' id='"+i+"'");
	  out.print("<td id ='jxtdid'><input name='nodes'  type='checkbox' value='"+node+"' id='"+i+"'");
	  out.print(" />　<label for='"+i+"'>"+n.getSubject(teasession._nLanguage)+"</label></td>");
	   if((i-j)%3==3)
	  {
	    out.print("</tr>");
	  }
	}
	out.print("<tr><td><input type='checkbox' onclick='selectAll(form_subscibe.nodes,checked)' id='sa' /><label for='sa'><span id ='qxid'>全选</span></label></td></tr>");
}
%>");
//document.write("<tr><td><input type='checkbox' onclick='selectAll(form_subscibe.nodes,checked)' id='sa' /><label for='sa'><span id ='qxid'>全选</span></label></td></tr>");
document.write("</table>");

 
document.write("<div id='tongyi'><br>我同意<%=cobj.getName(teasession._nLanguage)%>保存我的电邮地址，直到我选择停止订阅媒体资讯。</div>");
document.write("<br>");
document.write("<span id ='emailid'> 电子邮件：</span><input type='text' name='email' id='email' value='<%=email%>'>");
document.write("  <input type='submit' value='订 阅' id='dingyue'>");
//document.write("  <input type='button' value='返回' onclick='history.back();' >");
document.write("</form></div>");
//</script>
