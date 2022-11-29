<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Service"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)return;

Profile p=Profile.find(h.member);
int xpinpai=h.getInt("xpinpai", 0);
int xxinghao=h.getInt("xxinghao", 0);
String sername=h.get("name", "");
StringBuffer sql=new StringBuffer();
sql.append(" and hidden=0 and finished=1 and father=14050241 and n.type=65 and vcreator="+DbAdapter.cite(h.username));
if(xpinpai>0)sql.append("  AND sv.nstype1="+xpinpai);
if(xxinghao>0)sql.append("  AND sv.nstype2="+xxinghao);
if(sername.length()>0)sql.append("  AND nl.subject like "+DbAdapter.cite("%"+sername+"%"));
int count=Node.count(sql.toString());
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.list{border:1px solid #0A95F1;height:280px;overflow:auto;text-align:left;width:95%;padding:5px;margin-bottom:10px}

</style>
</head>
<body class="iframe">

<form name="form1" action="?" onsubmit="mt.query(this.name.value);return false;">
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="name" /></td>
  <td class="th">分类：</td>
  <td>
   <select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">----</option>
 				<%
 				java.util.List catList  = WomenOptions.findByTpyeAndLan(0,1,h.language);
 				if(catList!=null && !catList.isEmpty()){
	 				for(int i = 0;i<catList.size();i++){
	 					java.util.List detaList = (java.util.List)catList.get(i);
	 					String id = (String)detaList.get(0);
	 					String name = (String)detaList.get(1);
	 					out.println("<option value="+id);
	 					if(xpinpai==Integer.parseInt(id))
	 		            {
	 		            	out.println(" selected ");
	 		            }
	 		            out.println(">"+name);
	 		            out.print("</option>");
		 					
		 				}
 				}				
 				
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">----</option>
	 				
	 			</select>
 			</span>
  </td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="subqualification"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class="list" id="list">
<%
if(count==0){
	out.print("暂无记录！");
}else{
Enumeration e= Node.find(sql.toString(), 0, Integer.MAX_VALUE);
for(int i=0;e.hasMoreElements();i++)
{ 
  int node=((Integer)e.nextElement()).intValue();
  Node n=Node.find(node);
  Service s=Service.find(node, h.language);

	%>
	<input name="id" id="<%=s.getNode() %>"  type="checkbox" data='{id:<%=s.getNode() %>,name:"<%=n.getSubject(h.language) %>"}' value="<%=s.getNode() %>"/><%=n.getSubject(h.language) %>
	
	<%
}}
%>
</div>

<input type="button" value="确 定" onclick="f_ok()"/>
<input type="button" value="取 消" onclick="pmt.close()"/>
</form>

<script>
var pmt=parent.mt;
function f_xp(igd,igdstrid,igdname,igdpingpai)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wotype=1&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			   data = data.trim();
				 	   document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );
}
function f_ok()
{
  var attr=['name','value','data'];
  var arr=form2.id,h='';
  if(!arr.length)arr=[arr];
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    eval('d='+t.getAttribute('data'));
    h+="<span id='_q"+t.value+"' ><input type='hidden' name='serviceNode'";
    for(var j=0;j<attr.length;j++)
      h+=" "+attr[j]+"='"+t.getAttribute(attr[j])+"'";
    h+=" />"+d.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>";
    //删除旧的
    //t=parent.$('_q'+t.value);
    //if(t)t.parentNode.removeChild(t);textContent
  }
  pmt.receive(h);
  pmt.close();
}
window.onload=f_xp('<%=xpinpai %>','xxinghaoid','xxinghao','<%=xxinghao %>');
</script>
</body>
</html>
