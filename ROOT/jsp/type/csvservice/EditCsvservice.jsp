<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %><%@page import="java.util.*" %><%@ page import="tea.entity.csvclub.*" %><%@ page import="tea.ui.TeaSession" %>
<jsp:directive.page import="java.math.BigDecimal"/><% request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

//boolean _bNew=request.getParameter("NewNode")!=null;

int csvservice = 0;
if(request.getParameter("csvservice")!=null && request.getParameter("csvservice").length()>0)
	csvservice = Integer.parseInt(request.getParameter("csvservice"));
//out.print(request.getParameter("NewNode"));

String nexturl=request.getParameter("nexturl");

String content=null,principal=null,sort=null;
int type=-1,sequence=0,servicefrist=0,name=0;
java.math.BigDecimal outlay=null;
java.util.Date time=null;
java.math.BigDecimal registeroutlay =null;
  Node noobj = Node.find(csvservice);
    Csvservice obj=Csvservice.find(csvservice);
if(csvservice>0)
{
  name=obj.getName();
   type=obj.getType();
  sequence=obj.getSequence();
  outlay=obj.getOutlay();
  content=obj.getContent();
  time=obj.getTime();
  registeroutlay= obj.getRegisteroutlay();
  sort = obj.getSort();
  servicefrist = obj.getServicefrist();
  
}

if(request.getParameter("delete")!=null)
{	
    obj.delete();
    noobj.delete(teasession._nLanguage);
     response.sendRedirect("/jsp/type/csvservice/Csvservices.jsp");
     return;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.name.focus();
}
function sub()
{
	if(form1.name.value=="")
	{	
		alert("服务名称不能为空!");
		return false;
	}
	if(form1.time.value=="")
	{
		alert("时间不能为空!");
		return false;
	}
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>创建/编辑 服务</h1>
<br>
<div id="head6"><img height="6"></div>
<br/>
<form name="form1" action="/servlet/EditCsvservice" method="post"  onSubmit="return sub(this);">
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="editcsvservice"/>
<input type="hidden" name ="csvservice" value="<%=csvservice %>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>服务前题</td>
         <td nowrap><label>   
           <select name="servicefrist">
          <%
          		for(int i =0;i<Csvservice.FRIST_NAME.length;i++)
          		{
          			out.print("<option value="+i);
          			if(i==servicefrist)
          				out.print(" selected");
          			out.print(">"+Csvservice.FRIST_NAME[i]);
          			out.print("</option>");
          		}
           %>
         </select>
         </label></td>
      </tr>  
   
  <tr>
        <td>服务名称</td>
         <td nowrap>
         <select name="name">
         <%
         		for(int j =0;j<Csvservice.FU_NAME.length;j++)
         		{
         			out.print("<option value="+j);
         			if(j==name)
         				out.print(" selected");
         			out.print(">"+Csvservice.FU_NAME[j]+"</option>");
         		}
          %>
          </select>
          <!-- <input name="name" type="text" value="<%//if(noobj.getSubject(teasession._nLanguage)!=null)out.print(noobj.getSubject(teasession._nLanguage));%>" size="40"></td> -->
       
       </tr>
        <!--
       <tr>
         <td>服务类别</td>
         <td nowrap><select name="type">
         <option value="">------------</option>
           <%
          // for(int index=0;index<Csvservice.SERVICE_TYPE.length;index++)
          // {
           // out.print("<option value="+index);
           // if(index==type)
            //out.println(" SELECTED ");
          //  //out.println(" >"+Csvservice.SERVICE_TYPE[index]);
          // }
           %></select>
         </td>
       </tr> -->
	          <tr>
        <td>所属类型</td>
         <td nowrap>
         <%
         
         	java.util.Enumeration jome = Csvjoinoutlay.find(teasession._strCommunity,"",0,20);
         	
         	while(jome.hasMoreElements())
         	{
         		int joid = ((Integer)jome.nextElement()).intValue();
         		Csvjoinoutlay joobj = Csvjoinoutlay.find(joid);
         		out.print("<input name=\"sort\" type=\"checkbox\" value= "+joid+"");
         	
         	if(obj.getSort()!=null){
         		if(obj.getSort().indexOf("/"+joid+"/")>-1)
         			out.print(" checked=true  ");
         	}
         
         		out.print(">"+joobj.getName());
         	}
          %>
       </tr>
       <tr>
        <td>注册费用</td>
         <td nowrap><input name="outlay" type="text" value="<%if(outlay==null)out.print("0.00");else out.print(outlay);%>" >
           元/终身</td>
       </tr>
	          <tr>
        <td>服务费用</td>
         <td nowrap><input name="registeroutlay" type="text" value="<%if(registeroutlay!=null){out.print(registeroutlay);}else{out.print("0.00");}%>" >
         元/年.</td>
       </tr>
       <tr>
        <td>顺序</td>
         <td nowrap><input name="sequence" type="text" value="<%=noobj.getSequence()%>" ></td>
       </tr>
       <tr>
         <td>备注</td>
         <td nowrap>
         <textarea name="content" cols="50" rows="5"  ><%if(noobj.getText(teasession._nLanguage)!=null)out.print(noobj.getText(teasession._nLanguage).replaceAll("</","&lt;/"));%></textarea></td>
       </tr>
       <tr>
        <td >时间:</td>    
        <td>
        <input name="time" size="7"  value="<%if(noobj.getTime()!=null)out.print(noobj.getTimeToString()); %>"><A href="###"><img onclick="showCalendar('form1.time');" src="/tea/image/public/Calendar2.gif" align="top"/></a> 
        </td>
      </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6"></div>
</body>
</html>



