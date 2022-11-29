<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.entity.member.Profile"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Photography");

String parameter=teasession.getParameter("nexturl");

if(!"-1-2-3-4-5-6".equals(teasession.getParameter("add-1-5-6-7"))){
	out.println("<script>");
	out.println("alert('"+r.getString(teasession._nLanguage,"787514407")+"！');");
	out.println("window.location.href='http://"+request.getServerName()+":"+request.getServerPort()+"';");
	out.println("</script>");
}


Node node=Node.find(teasession._nNode);



Category category = Category.find(teasession._nNode);//显示类别中的内容



boolean _bNew=request.getParameter("NewNode")!=null&&request.getParameter("NewNode").length()>0;


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
 
 
///////////

boolean parambool=(parameter!=null&&!parameter.equals("null"));

String subject=null,byname=null,camerabrand=null,caption=null,picname=null,picpath=null,mark=null;
boolean mostly=false,mostly1=true,mostly2=true;
int categories = -1,len=0,camerabrandtype = -1;
int flag = 0;
if(_bNew)
{
  out.println("<input type=hidden NAME=NewNode VALUE=ON>"); 
  // 
  StringBuffer sql2 = new StringBuffer(" and n.rcreator="+DbAdapter.cite(teasession._rv.toString())+" and n.type = 94 ");
  int count = tea.entity.node.Node.countPhotography(teasession._strCommunity,sql2.toString());
  if(count>20){
	  out.print("<script>");
	  out.print("alert('"+r.getString(teasession._nLanguage,"1718407339")+"！');");
	  out.print("history.go(-1);");
	  out.print("</script>");
	  
  }
 
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



<script src="/tea/layer.js" type="text/javascript" ></script>
<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/mt.js" type="text/javascript"></script> 

 
<script type="text/javascript">

function f_submit()
{
	
	
		if(form1.subject.value==''){
			alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"Title") %>');
			form1.subject.focus();
			return false;
		}
	
	
			if(form1.byname.value==''){
				alert('<%=r.getString(teasession._nLanguage,"Pleasefillin") %><%=r.getString(teasession._nLanguage,"By") %>');
				form1.byname.focus();
				return false;
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
		}else{
		
			  var obj = form1.picname;
			 var sUploadAllowedExtensions  = ".gif .jpg .jpeg .png" ;//".doc,.docx,.xls,.xlsx" ;
			  var sExt = eval(obj).value.match( /.[^.]*$/ ) ;
			  sExt = sExt ? sExt[0].toLowerCase() : "." ;
			  if ( sUploadAllowedExtensions.indexOf( sExt ) < 0 )
			  {
				    alert("<%=r.getString(teasession._nLanguage,"1360318864")%>:" + sUploadAllowedExtensions + "<%=r.getString(teasession._nLanguage,"1957806216")%>.");
				    return false;
			  }
			 
		}	 
		
		if(!form1.check.checked){
			alert('<%=r.getString(teasession._nLanguage,"Pleaseselect") %><%=r.getString(teasession._nLanguage,"Terms2") %>');
			form1.check.focus();
			return false;
		}
		
		if(<%=_bNew%>)
		{
			//openNewDiv('newDiv');
			  mt.show("<%=r.getString(teasession._nLanguage,"251462265")%>...",0);
			
		}else{
				if(confirm('<%=r.getString(teasession._nLanguage,"493120078")%><%=r.getString(teasession._nLanguage,"1182235425")%>'))
				{
					//openNewDiv('newDiv');
					  mt.show('<%=r.getString(teasession._nLanguage,"251462265")%>...',0);
					 sendx('/servlet/Ajax?act=http.length',function(a){
							 a=parseInt(a)/1048576;
							
							 if(a<=2){
								  return true;
							 }else{
								 
								 alert('<%=r.getString(teasession._nLanguage,"1658866021")%>:'+a.toFixed(2)+'M\n<%=r.getString(teasession._nLanguage,"2021634753")%>\n<%=r.getString(teasession._nLanguage,"1725192017")%>');
								 location.reload();
							 }
							// mt.show('您上传的附件大小为:'+a.toFixed(2)+'M<br/>附件的大小限制为:"2M');
							// location.reload();
						 }
					 ); 
				}else 
				{
					return false;
				}
	
			
		} 
} 
function checkinput(obj){
	 
  var sUploadAllowedExtensions  = ".gif .jpg .jpeg .png" ;//".doc,.docx,.xls,.xlsx" ;
  var sExt = eval(obj).value.match( /.[^.]*$/ ) ;
  sExt = sExt ? sExt[0].toLowerCase() : "." ;
  if ( sUploadAllowedExtensions.indexOf( sExt ) < 0 )
  {
    alert("<%=r.getString(teasession._nLanguage,"1360318864")%>:" + sUploadAllowedExtensions + "<%=r.getString(teasession._nLanguage,"1957806216")%>.");
    return false;
  }
 
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
</script>




   


<form name="form1" METHOD=POST action="/servlet/EditPhotography" enctype="multipart/form-data" target="_ajax"   onsubmit="return f_submit();" >
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
<input type="hidden" name="myact" value="MyPHO"/>
<input type="hidden" name="audit" value="0"/>
<input type="hidden" name="editnode" value="<%=teasession.getParameter("editnode") %>"/>
<input type="hidden" name="phonode" value="<%=teasession.getParameter("phonode") %>"/>




<table border="0" cellpadding="0" cellspacing="0" id="tableup">

  <tr id="EditPhotography_1">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Title") %>：<!--标题--></TD>
    <td height="30" align="left" nowrap><input name="subject" size=70 maxlength=200 class="edit_input" value="<%=node.getNULL(subject) %>"/></td>
  </tr>
  
  <tr id="EditPhotography_2">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"By") %>：<!--作者--></TD>
    <td height="30" align="left" nowrap>
  
    <input name="byname" size=70 maxlength=200 class="edit_input" value="<%if(byname!=null&&byname.length()>0){out.print(node.getNULL(byname));}else{out.print(Profile.find(teasession._rv.toString()).getLastName(teasession._nLanguage)+Profile.find(teasession._rv.toString()).getFirstName(teasession._nLanguage));} %>"/>    </td>
  </tr>
  
  <tr id="EditPhotography_3">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"CameraBrand") %>：<!--相机信息--></TD>
    <td height="30" align="left" nowrap>
    
    <select name ="camerabrandtype" onchange="f_camerabrandtype();">
    	<option value="-1">-<%=r.getString(teasession._nLanguage,"CameraBrand") %>-</option>
    	<%
    		for(int i=0;i<Photography.CAMERABRAND_TYPE.length;i++){ 
    			
    			out.print("<option value ="+i);
    			if(camerabrandtype==i){
    				out.print(" selected ");
    			}
    			out.print(">"+r.getString(teasession._nLanguage,""+Photography.CAMERABRAND_TYPE[i])+"");
    			 
    			out.print("</option>");
    		}
    	%>
    </select>
    <input name="camerabrand" id="camerabrand"  style="width:97px;" maxlength=30 class="edit_input" value="<%=node.getNULL(camerabrand) %>" <%if(camerabrandtype!=13){ %> style="display:none" <%} %>>
    
    </td>
  </tr>
  
    
     
    
  <tr id="EditPhotography_4">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Categories") %>：<!--类型--></TD>
    <td height="30" align="left" nowrap>
		
			
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
				out.print("<input type=text name=categories value="+teasession._nNode+">");
				out.print(node.getSubject(teasession._nLanguage));
			}
			
			%>	</td>
  </tr>
  
  <tr id="EditPhotography_5">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Caption") %>：<!--描述--></TD>
    <td height="30" align="left" nowrap><textarea rows="5" cols="50" name="caption" class="miaoshu"><%=node.getNULL(caption) %></textarea></td>
  </tr>
  
  <tr id="EditPhotography_6">
    <td height="30" align="left" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage,"Upload") %>：<!--上传--></TD>
    <td height="30" align="left" nowrap><input type="file" name="picname" id="picname" onChange="checkinput('form1.picname');">
     <%
      if(len > 0)
      {
    	  out.print("<a href='"+picpath+"' target='_blank'>"+picname+"</a>");
       // out.print("<a href='"+picname+"' target='_blank'>"+len+"</a>&nbsp;"+r.getString(teasession._nLanguage, "Bytes"));
      //  out.print("<input id='checkbox' type='checkbox' name='clear_picname' onclick='form1.picname.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>    </td>
  </tr>
  <tr id="EditPhotography_6">
    <td height="30" align="left" nowrap>&nbsp;</TD>
    <td height="30" align="left"><%=r.getString(teasession._nLanguage,"1329452510") %><br>
	（<%=r.getString(teasession._nLanguage,"1652428578") %>）。</td>
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



   <!-- 同意条款 隐藏 不使用 -->
  <tr id="EditPhotography_8" >
    <td height="30" align="left" nowrap></TD>
    <td height="30" align="left" nowrap><input type="checkbox" name="check" value="1"  <%if(!_bNew)out.print("checked"); %>/> 
      <a href="/html/folder/44.htm" target="_blank"><%=r.getString(teasession._nLanguage,"Terms") %></a></td>
  </tr>
</table>

<h1>
  <input type="hidden" name="act" value="">
  <!--完成***下一步****高级-->
  <%
  if(category.getClewtype()!=0){
    %>
    <input type=image name="GoFinish" ID="edit_GoFinish"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Submit") %>" >&nbsp;
    <input type="reset"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Reset") %>" >
    <%
    }else{
      %>

      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish"  onClick="act.value='finish';" class="edit_button" value="<%=r.getString(teasession._nLanguage,"Submit") %>" src="/res/Home/1007/10079948.jpg" />&nbsp;
      <input type="reset"   class="edit_button" value="<%=r.getString(teasession._nLanguage,"Reset") %>" >
      <%
      }
      %>
     <!--  <input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage,"Advanced") %>">&nbsp; -->
      <input type=button value="<%=r.getString(teasession._nLanguage,"1315968283") %>" onClick="window.open('<%=parameter %>','_self');">
</h1>
</FORM>

