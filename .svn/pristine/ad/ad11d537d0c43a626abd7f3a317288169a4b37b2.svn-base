<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.entity.util.Card"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Photography");




Node node=Node.find(teasession._nNode);


Category category = Category.find(teasession._nNode);//显示类别中的内容



boolean _bNew=request.getParameter("NewNode")!=null;

String community=node.getCommunity();
String act = teasession.getParameter("act");

int options1=node.getOptions1();
if(!_bNew)//如果是编辑就取父节点的选项,即：类别
{
  options1=Node.find(node.getFather()).getOptions1();
}
int type=node.getType();
if(type==1)
{
  type=category.getCategory();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
  {
    //response.sendError(403);
    //return;
  }
}

///////////
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));

String subject=null,byname=null,camerabrand="",caption=null,picname=null,picpath=null,mark=null;
boolean mostly=false,mostly1=true,mostly2=true;
int categories = -1,len=0,camerabrandtype = -1;
int flag = 0;
if(_bNew)
{
  out.println("<input type=hidden NAME=NewNode VALUE=ON>");
}else
{
	subject = node.getSubject(teasession._nLanguage);
	Photography pobj = Photography.find(teasession._nNode);
	byname = pobj.getByname(teasession._nLanguage);
	camerabrand=pobj.getCamerabrand(teasession._nLanguage);
	caption = Report.getHtml(node.getText(teasession._nLanguage));
	categories = pobj.getCategories();
	
	picpath = pobj.getPicpath(teasession._nLanguage);
	if(picpath!=null && picpath.length()>0){
		len = (int)new java.io.File(application.getRealPath(picpath)).length();
	}
	picname=pobj.getPicname(teasession._nLanguage);
	 mostly=node.isMostly();
	  mostly1=node.isMostly1();
	  mostly2=node.isMostly2();
	  mark=node.getMark();
	  camerabrandtype = pobj.getCamerabrandtype();
}

%>
<html>
<head>
<title><%=r.getString(teasession._nLanguage,"Photography") %></title>


<script src="/tea/layer.js" type="text/javascript" ></script>
<script src="/tea/tea.js" type="text/javascript" ></script>

<script src="/res/<%=community%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=community%>/cssjs/community.css" type="text/css" rel="stylesheet">


<script type="text/javascript">

function f_ceng()
{
   openNewDiv('newDiv');
}

function f_submit()
{
	if(form1.subject.value==''){
		alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"Title") %>');
		form1.subject.focus();
		return false;
	}

	if('<%=teasession.getParameter("act")%>'!='audit')
	{
		if(form1.byname.value==''){
			alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"By") %>');
			form1.byname.focus();
			return false;
		}
	}
	
	if(form1.camerabrandtype.value==-1){
		alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"CameraBrand") %>');
		form1.camerabrandtype.focus();
		return false;
	}else{
		if(form1.camerabrandtype.value==13 && form1.camerabrand.value==''){
			alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"CameraBrand") %>');
			form1.camerabrand.focus();
			return false;
		}
	}
	
	if(form1.categories.value==-1){
		alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"Categories") %>');
		form1.categories.focus();
		return false;
	}
	if(form1.caption.value==''){
		alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"Caption") %>');
		form1.caption.focus();
		return false;
	}
	if(form1.picname.value==''&&<%=_bNew%>){
		alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"pic") %>');
		form1.picname.focus();
		return false;
	}
	/*
	if(!form1.check.checked){
		alert('<%=r.getString(teasession._nLanguage,"Pleaseselect") %><%=r.getString(teasession._nLanguage,"Terms2") %>');
		form1.check.focus();
		return false;
	}
	*/
	if(form1.audit.value==-1){
		   alert("请选择作品审核状态!");
		   form1.audit.focus();
		   return false;
	   }
	
	
	 openNewDiv('newDiv');
}

function f_camerabrandtype()
{
	if(form1.camerabrandtype.value==13)//选择的是其他
	{
		document.getElementById("camerabrand").style.display='';
	}else{
		document.getElementById("camerabrand").style.display='none';
		
			form1.camerabrand.value='';

	}
}
function f_list()
{
  var rs=window.showModalDialog('/jsp/listing/SelListing.jsp?community=<%=teasession._strCommunity%>&type=<%=type%>&listing='+form1.listing.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:420px;');
  if(!rs)return;
  var i=rs.indexOf(':');
  form1.listing.value=rs.substring(0,i);
  form1.listingname.value=rs.substring(i+1);
}
</script>
</head>
<body>  
<h1><%=r.getString(teasession._nLanguage,"Photography") %></h1>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" METHOD=POST action="/servlet/EditPhotography" enctype="multipart/form-data" onsubmit="return f_submit();" >
<%
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
%>
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=community%>">
<input type='hidden' name='nexturl' value="<%=parameter %>">
<input type='hidden' name='act' value='EditPhotography'>


<input type="hidden" name='watermark' value='false'/>
<input type="hidden" name="repository" value="Photography"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr id="EditPhotography_1">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Title") %>：<!--标题--></TD>
    <td nowrap><input name="subject" size=70 maxlength=255 class="edit_input" value="<%=node.getNULL(subject) %>"/></td>
  </tr>
  
  <tr id="EditPhotography_2">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"By") %>：<!--by--></TD>
    <td nowrap>
    <%
    //审核的信息
    	if("audit".equals(act)){
    		out.print(node.getNULL(byname));
    		out.print(" <input type=hidden name=byname value="+node.getNULL(byname)+">");
    	}else
    		{
    %>
    <input name="byname" id="byname" size=70 maxlength=255 class="edit_input" value="<%=node.getNULL(byname) %>" >
    <%} %>
    </td>
  </tr>
  
  <tr id="EditPhotography_3">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"CameraBrand") %>：<!--相机信息--></TD>
    <td nowrap>
    <select name ="camerabrandtype" onchange="f_camerabrandtype();">
    	<option value="-1">-<%=r.getString(teasession._nLanguage,"CameraBrand") %>-</option>
    	<%
    		for(int i=0;i<Photography.CAMERABRAND_TYPE.length;i++){
    			
    			out.print("<option value ="+i);
    			if(camerabrandtype==i){
    				out.print(" selected ");
    			}
    			//out.print(">"+Photography.CAMERABRAND_TYPE[i]);
    			out.print(">"+r.getString(teasession._nLanguage,""+Photography.CAMERABRAND_TYPE[i])+"");
    			 
    			out.print("</option>");
    		}
    	%>
    </select>
    <input name="camerabrand" id="camerabrand" size=50 maxlength=255 class="edit_input" value="<%=node.getNULL(camerabrand) %>" <%if(camerabrandtype!=13){ %> style="display:none" <%} %>></td>
  </tr>
  
    
  <tr id="EditPhotography_4">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Categories") %>：<!--类型--></TD>
    <td nowrap>
		
			
			<%
			
			if(node.getType()!=1)// 说明是文件夹 则要显示 下面的类别
			{
				
				if(node.getType()==94){//如果是摄影
					teasession._nNode = Node.find(Node.find(teasession._nNode).getFather()).getFather();
				}
				
				out.print("<select name=\"categories\">");
				out.print("<option value=\"-1\">-"+r.getString(teasession._nLanguage,"Pleaseselect")+r.getString(teasession._nLanguage,"Categories")+"-</option>");
				java.util.Enumeration e = Node.find(" and father = "+teasession._nNode,0,Integer.MAX_VALUE);
				while(e.hasMoreElements()){
					int fnid = ((Integer)e.nextElement()).intValue();
					Node fobj = Node.find(fnid);
					out.print("<option value="+fnid);
					if(categories == fnid){
						out.print(" selected ");
					}
					out.print(">"+fobj.getSubject(teasession._nLanguage));
					out.print("</option>"); 
				}
				out.print("</select>");
			}else{
				out.print("<input type=hidden  name=categories value="+teasession._nNode+">");
				out.print(node.getSubject(teasession._nLanguage));
			}
			
			%>
		
	</td>
  </tr>
  
  <tr id="EditPhotography_5">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Caption") %>：<!--描述--></TD>
    <td nowrap><textarea rows="5" cols="50" name="caption"><%=node.getNULL(caption) %></textarea></td>
  </tr>
  
  <tr id="EditPhotography_6">
    <td nowrap align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Upload") %>：<!--上传--></TD>
    <td nowrap><input type="file" name="picname"/>
     <%
      if(len > 0)
      {
    	  out.print("<a href='"+picpath+"' target='_blank'>"+picname+"</a>");
       // out.print("<a href='"+picname+"' target='_blank'>"+len+"</a>&nbsp;"+r.getString(teasession._nLanguage, "Bytes"));
      //  out.print("<input id='checkbox' type='checkbox' name='clear_picname' onclick='form1.picname.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
    </td>
  </tr>
  <% if(len > 0)
  {
	  out.print("<tr>");
	  out.print("<td>&nbsp;</td>");
	  out.print("<td>");
	  out.print("<img src="+picpath+" width=100 >");
	  out.print("</td>");
	  out.print("</tr>");
	 
  }
	  
  %>


 <%if("audit".equals(teasession.getParameter("act"))){ %>
       <tr>
        <td align="right"><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "审核状态")%>:</td>
        <td><select name="audit">
        	<option value="-1">-评论状态-</option>
        	<option value="1" <%if(node.getAudit()==1)out.print(" selected "); %>>-审核通过-</option>
        	<option value="2" <%if(node.getAudit()==2)out.print(" selected "); %>>-拒绝作品-</option>
        	
        </select></td>
      </tr>
      <%}else{//编辑使用
    	  
    	  out.print("<input type='hidden' name='act2' value='EditPhotography'>");
    	  out.print("<input type=hidden name=audit value="+node.getAudit()+" >"); } %>
    	  
    	  
    	  
	    	    <%//一稿多投
	    	    
	    	    out.print("<input type=hidden name=listact value=listact>");
		  StringBuilder lid=new StringBuilder("/");
		  //int cml=Listing.count(" AND type=3 AND node IN(SELECT node FROM node WHERE path LIKE '/"+c.getNode()+"/%' AND type<2 AND hidden=0) AND listing IN(SELECT listing FROM PickNode WHERE type IN(255,"+type+"))");
		  //if(cml>0)//是否存在手动列举
		  {
			  out.print("<tr");
			  if("audit".equals(teasession.getParameter("act"))){out.print(" style=display:none;");} 
			  out.print(">");
		    out.print("<td nowrap  align=right>"+r.getString(teasession._nLanguage, "Report.show")+":</td><td nowrap><input name='listingname' size='40' readonly='true' value=\"");
		    if(!_bNew)
		    {
		      Enumeration e=Listed.findListing(teasession._nNode);
		      while(e.hasMoreElements())
		      {
		        int id=((Integer)e.nextElement()).intValue();
		        Listing obj=Listing.find(id);
		        if(!obj.isExisted())continue;
		        out.println(obj.getName(teasession._nLanguage)+";　");
		        lid.append(id).append("/");
		      }
		    }
		    out.print("\" /> <input type='button' value='...' onclick='f_list()' /></td></tr>");
		  }
		  out.print("<input type='hidden' name='listing' value='"+lid.toString()+"' />");
	  %>
	    	  
    <tr id="EditPhotography_7" <%if("audit".equals(teasession.getParameter("act"))){out.print(" style=display:none;");} %> >
    <td align="right"><%=r.getString(teasession._nLanguage, "选项")%>:</td>
    <td  rowspan="" >
      <input type="checkbox" name="mostly" id="mostly" <%if(mostly)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "设为栏目关键")%>
      <input type="checkbox" name="mostly1" id="mostly1" <%if(mostly1)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170373281")%>
      <input type="checkbox" name="mostly2" id="mostly2" <%if(mostly2)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170388968")%>
      <%=Mark.toHtml(teasession._strCommunity,type,mark)%>
    </td>
  </tr>
   <!-- 同意条款 隐藏 不使用 -->
  <tr id="EditPhotography_8" <%out.print(" style=display:none;");%>>
    <td nowrap align="right"><input type="checkbox" name="check" value="1"  <%if(!_bNew)out.print("checked"); %>/></TD>
    <td nowrap><a href="###"><%=r.getString(teasession._nLanguage,"Terms") %></a></td>
  </tr>
   

</table>

<center>
  <input type="hidden" name="act" value="">
  <!--完成***下一步****高级-->
  <%
  if(category.getClewtype()!=0){
    %>
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Submit") %>" >&nbsp;
    <input type="reset"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Reset") %>" >
    <%
    }else{
      %>

      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage,"Submit") %>">&nbsp;
      <input type="reset"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Reset") %>" >
      <%
      }
      %>
     <!--  <input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage,"Advanced") %>">&nbsp; -->
      <input type=button value="返回" onClick="javascript:history.back()">
</center>
</FORM>
 
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
