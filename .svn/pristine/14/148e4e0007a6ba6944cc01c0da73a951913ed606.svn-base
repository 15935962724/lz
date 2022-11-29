<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%@ page import ="java.util.Date" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
int maid = 0;

String vehicle=null,factory=null,engine=null,chauffeur=null,pic=null,remark=null;
int genre=0,fettle=0, maplen = 0;
float price =0;
Date times =null;
if(teasession.getParameter("maid")!=null && teasession.getParameter("maid").length()>0)
	maid = Integer.parseInt(teasession.getParameter("maid"));

Manage maobj = Manage.find(maid);
if(maid>0)
{
	vehicle = maobj.getVehicle();
	factory = maobj.getFactory();
	engine = maobj.getEngine();
	genre = maobj.getGenre();
	chauffeur= maobj.getChauffeur();
	price = maobj.getPrice();
	pic = maobj.getPic();
	times = maobj.getTimes();
	fettle = maobj.getFettle();
	remark = maobj.getRemark();
 if(pic!=null)
  {
    maplen=(int)new java.io.File(application.getRealPath(pic)).length();
  }

}
if(teasession.getParameter("delete")!=null)
{
	Manage deleteobj = Manage.find(maid);
	deleteobj.delete();
	response.sendRedirect("/jsp/admin/vehicle/manage1.jsp");
	return;
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
<script>
	function sub()
	{	
		if(form1.genre.value==0)
		{
			alert("请选择车辆的类型!");
			return false;
		}
		if(form1.times.value=="")
		{
			alert("请选择购车时间!");
			return false;
		}
	}
</script>

<body>

<form name=form1 METHOD=post enctype="multipart/form-data"  action="/servlet/EditManage" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" name ="maid" value="<%=maid %>">
	 <tr>
	      <td nowrap > 车牌号：</td>
	      <td nowrap>
	        <input type="text" name="vehicle" size="20" maxlength="100"  value="<%if(vehicle!=null)out.print(vehicle); %>">
	      </td>
	      <td  nowrap rowspan="6" ><center><%if(pic!=null && pic.length()>0){ %>
	      <img src='<%=pic %>' width='100' border=1> 
	      <%}else{out.print("暂无照片");} %>
	      
	      </center></td>
    </tr>
    <tr>
	      <td nowrap > 厂牌型号：</td>
	      <td nowrap>
	        <input type="text" name="factory" size="20" maxlength="100"  value="<%if(factory!=null)out.print(factory); %>">
	      </td>
    </tr>
    <tr>
	      <td nowrap> 发动机号：</td>
	      <td nowrap>
	        <input type="text" name="engine" size="20" maxlength="100" value="<%if(engine!=null)out.print(engine); %>">
	      </td>
    </tr>
    <tr>
      <td nowrap > 车辆类型：</td>
      <td nowrap>        
        <select name="genre" class="BigSelect">
          <option value="0">--------</option>
          <%
          		java.util.Enumeration came = Cargenre.findByCommunity(teasession._strCommunity,"");
          		while(came.hasMoreElements())
          		{
          			int caid = ((Integer)came.nextElement()).intValue();
          			Cargenre caobj = Cargenre.find(caid);
          			out.print("<option value="+caid);
          			if(caid==genre)
          				out.print(" selected");
          			out.print(">"+caobj.getCargenrename()+"</option>");
          		}
           %>
        </select>&nbsp;<input type="button" value="添加类型" onClick="location='/jsp/admin/vehicle/newtype.jsp';">
      </td>
    </tr>
    <tr>
	      <td nowrap > 司机：</td>
	      <td nowrap>
	        <input type="text" name="chauffeur" size="12" maxlength="100"  value="<%if(chauffeur!=null)out.print(chauffeur); %>">
	      </td>
    </tr>
    <tr>
	      <td nowrap > 购买价格：</td>
	      <td nowrap>
	        <input type="text" name="price" size="12" maxlength="25"  value="<%if(price!=0)out.print(price); %>">
	      </td>
    </tr>
    <tr>
	      <td nowrap > 车辆照片上传：</td>
	      <td nowrap colspan="2">
	        <input type="file" name="pic" size="40" "  title="选择附件文件">
	        <%
	    		if(maplen>0){
	    	 %> 
	        <input  id="CHECKBOX" type="CHECKBOX" name="clear" onClick="form1.pic.disabled=this.checked;"/>
	       清空
	        <%} %>
	      </td>
    </tr>
    <tr>
      <td nowrap> 购买日期：</td>
      <td nowrap colspan="2">
       <input name="times" size="7"  value="<%if(times!=null)out.print(times); %>" readonly><A href="###"><img onclick="showCalendar('form1.times');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
        日期格式形如 1999-1-2
      </td>
    </tr>
    <tr>
      <td nowrap > 当前状态：</td>
      <td nowrap colspan="2">
        <select name="fettle">
          <option value="1" <%if(fettle==1)out.print("selected"); %>>可用</option>
          <option value="2" <%if(fettle==2)out.print("selected"); %>>损坏</option>
          <option value="3" <%if(fettle==3)out.print("selected"); %>>维修中</option>
          <option value="4" <%if(fettle==4)out.print("selected"); %>>报废</option>
        </select>
      </td>
    </tr>
    <tr>
	      <td nowrap > 备注：</td>
	      <td nowrap colspan="2">
	        <textarea name="remark" cols="57" rows="3"><%if(remark!=null)out.print(remark); %></textarea>
	      </td>
    </tr>
    <tr >
      <td nowrap  align="center">
        <input type="submit" value="保存"  >&nbsp;&nbsp;
        <input type="reset" value="重填">&nbsp;&nbsp;
      </td>
    </tr>
   
</TABLE>

</FORM>

</body>
</html>



