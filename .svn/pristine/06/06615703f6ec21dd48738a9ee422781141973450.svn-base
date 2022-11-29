<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.Entity"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.RV"%>
<%@page import="tea.html.*" %>
<%@page import="tea.resource.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    out.print("请先登录系统");
    return;
}
Resource r=new Resource("/tea/ui/node/listing/Listings");


if("POST".equals(request.getMethod()))
{
	  String target = teasession.getParameter("target");
	  int sorttype =Integer.parseInt(teasession.getParameter("SortType"));  
	  int sortdir = Integer.parseInt(teasession.getParameter("SortDir"));
	  int ltype = Integer.parseInt(teasession.getParameter("ltype"));
	  
	  
	  
	  
	  DbAdapter db = new DbAdapter();
	//  DbAdapter db2 = new DbAdapter();
	  try
	  {
		  db.executeQuery("select listing from Listing where exists (select node from Node n where n.node= Listing.node and n.community='REDCOME') ");
		  while(db.next())
		  {
			  int l = db.getInt(1);
			  //db2.executeUpdate("UPDATE Listing SET target ="+DbAdapter.cite(target)+",sorttype= "+sorttype+",sortdir="+sortdir+",type="+ltype+" WHERE listing="+l);
			  Listing obj = Listing.find(l);
			  obj.setVolumeUpdateListing( target , sorttype, sortdir, ltype);
		  }
	  } 
	  finally
	  { 
		  db.close();
		  //db2.close();
	  }
	  
		 out.print("<script  language='javascript'>alert('批量修改列举选项成功!');window.close();;</script> ");
		 return;
	  
	
} 

%>

<html>
<head>
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
  <script type="text/javascript" language="javascript" src="/tea/ym/ymPrompt.js"></script>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>
</head>
<script>
function f_sub()
	{
	if(confirm('确定要批量修改列举选项吗？'))
		{
			form1.action="?";
			form1.method="POST";
			ymPrompt.win({message:'<br><center><%=r.getString(teasession._nLanguage,"正在批量修改列举选项,请稍候...")%></center>',title:'',width:'300',height:'50',titleBar:false});
			form1.submit();
		}
	
	 	
	}
</script>
<body>
<h1>批量修改列举选项</h1>
 <form name="form1" action="?" method="POST" >
 <input type=hidden name="community" value="<%=teasession._strCommunity %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
      <td nowrap align="right">目标：</td>
      <td><input type="TEXT" class="edit_input" maxlength="15"  name=target VALUE="_self">
      <select name="tar" onchange="form1.target.value=form1.tar.value;">
      	<option value=_self>_self</option>
      	<option value=_blank>_blank</option>
      	<option value=_parent>_parent</option>
      	<option value=_top>_top</option>
     
      </select>
      </td>
</tr>
 <tr>
	   <td nowrap align="right">排序类型：</td>
      <td>  
          <%
          DropDown dropdown = new DropDown("SortType", 0);
          for (int l9 = 0; l9 < Listing.LISTING_SORTTYPE.length; l9++)
          {
            dropdown.addOption(l9, r.getString(teasession._nLanguage, Listing.LISTING_SORTTYPE[l9]));
          }
          out.print(dropdown);
          %></td>
   </tr>
   <tr>    
      <td nowrap align="right">排序方向：</td>
       <td>
        <input  id="radio" type="radio" name=SortDir VALUE=0  checked='true'>升序
        <input  id="radio" type="radio" name=SortDir VALUE=1 >降序
      </td>

   </tr>
   <tr>
       <td nowrap align="right">类型：</td>
       <td><%
      for(int i9 = 0; i9 < Listing.LISTING_TYPE.length; i9++)
      {
        out.print("<input id='radio' type='radio' name='ltype' value='"+i9+"'");
        if(0==i9)out.print(" checked='true'");
        out.print(">"+r.getString(teasession._nLanguage, Listing.LISTING_TYPE[i9]));
      }
      %>
      </td>
   </tr>


</table>
</form>
<br>
<input type=button value="提交" onclick="f_sub();">&nbsp;<input type=button value="关闭" onClick="window.close();">
</body>

</html>