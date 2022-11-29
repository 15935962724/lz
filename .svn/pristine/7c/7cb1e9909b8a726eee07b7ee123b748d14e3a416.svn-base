<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page  import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.netdisk.*" %><%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String path=request.getParameter("path");
String nexturl=request.getParameter("nexturl");

if(request.getMethod().equals("POST"))
{
  String toList[]=request.getParameterValues("toList");
  NetDiskShare.delete(path);
  if(toList!=null)
  for(int index=0;index<toList.length;index++)
  {
    int purview=0;
    if(request.getParameter(toList[index]+"_purview2")!=null)
    {
      purview=2;
    }else if(request.getParameter(toList[index]+"_purview1")!=null)
    {
      purview=1;
    }else if(request.getParameter(toList[index]+"_purview0")!=null)
    {
      purview=0;
    }else
    {//如果没有选择任何权限,则不保存
      continue ;
    }
    int type=toList[index].startsWith("G")?0:1;
    int name=Integer.parseInt(toList[index].substring(1));
    NetDiskShare.create(name,path,purview,type,teasession._rv._strR);
  }
  //"/jsp/netdisk/NetDiskMember.jsp?community="+teasession._strCommunity
  response.sendRedirect(nexturl);
  return ;
}

Resource r=new Resource();
r.add("/tea/resource/NetDisk");

NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,path);

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_click(name,i)
{
  if(document.all(name+"_purview"+i).checked)
  {
    var j=i;
    while(j>0)
    {
      j--;
      document.all(name+"_purview"+j).checked=true;
    }
  }else
  {
    var j=i;
    while(j<2)
    {
      j++;
      document.all(name+"_purview"+j).checked=false;
    }
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NetDiskShare")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=obj.getAncestor(null)%></td></tr>
</table>

<form name="form1" action="?" method="POST" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="path" value="<%=path%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
      <td>组或会员</td>
      <td>下载</td>
      <td>上传</td>
      <td>修改</td>
    </tr>
<%
java.util.Enumeration e=SMSGroup.findByMember(teasession._strCommunity,teasession._rv._strR);
while(e.hasMoreElements())
{
  int ar_id=((Integer)e.nextElement()).intValue();
  out.print("<input type=hidden name=toList value=G"+ar_id+" >");
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>(组)"+SMSGroup.find(ar_id).getName());

  NetDiskShare nds=NetDiskShare.find(path,ar_id,0);
  int p=nds.getPurview();
  out.print("<td><input type=checkbox name=G"+ar_id+"_purview0 onclick=f_click('G"+ar_id+"',0)");
  if(nds.isExists()&&p>=0)out.print(" CHECKED ");
  out.print(" value=0>");

  out.print("<td><input type=checkbox name=G"+ar_id+"_purview1 onclick=f_click('G"+ar_id+"',1)");
  if(nds.isExists()&&p>=1)out.print(" CHECKED ");
  out.print(" value=1>");

  out.print("<td><input type=checkbox name=G"+ar_id+"_purview2 onclick=f_click('G"+ar_id+"',2)");
  if(nds.isExists()&&p>=2)out.print(" CHECKED ");
  out.print(" value=2>");
}

e=SMSPhoneBook.findByMember(teasession._strCommunity,teasession._rv._strR);
while(e.hasMoreElements())
{
  int ar_id=((Integer)e.nextElement()).intValue();
  out.print("<input type=hidden name=toList value=U"+ar_id+" >");
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><tr><td>(用)"+SMSGroup.find(ar_id).getName());

  NetDiskShare nds=NetDiskShare.find(path,ar_id,1);
  int p=nds.getPurview();
  out.print("<td><input type=checkbox name=U"+ar_id+"_purview0 onclick=f_click('U"+ar_id+"',1)");
  if(nds.isExists()&&p>=0)out.print(" CHECKED ");
  out.print(" value=0>");

  out.print("<td><input type=checkbox name=U"+ar_id+"_purview1 onclick=f_click('U"+ar_id+"',1)");
  if(nds.isExists()&&p>=1)out.print(" CHECKED ");
  out.print(" value=1>");

  out.print("<td><input type=checkbox name=U"+ar_id+"_purview2 onclick=f_click('U"+ar_id+"',2)");
  if(nds.isExists()&&p>=2)out.print(" CHECKED ");
  out.print(" value=2>");
}
%>
  </table>
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
  <input type="button" value="返回" onClick="history.back();">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

<%-------------------//以前的管理样子-----------------
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  for (i=0; i< form1.toList.options.length; i++)
  {
    form1.toList[i].selected=true;
  }
  return true;
}
    		function func_up(select2,select1)
			{
                          if(select1.selectedIndex!=-1 && select1.selectedIndex!=0)
                          {
                            option_text=select1.options(select1.selectedIndex).text;
                            option_value=select1.options(select1.selectedIndex).value;

                            var my_option = document.createElement("OPTION");
                            my_option.text=option_text;
                            my_option.value=option_value;

                            new_index=select1.selectedIndex-1;
                            select1.remove(select1.selectedIndex);
                            select1.add(my_option,new_index);
                            select1.selectedIndex=new_index;
                          }
			}


			function func_down(select2,select1)
			{
                          if(select1.selectedIndex!=-1 && select1.selectedIndex!=(select1.options.length-1))
                          {
                            option_text=select1.options(select1.selectedIndex).text;
                            option_value=select1.options(select1.selectedIndex).value;

                            var my_option = document.createElement("OPTION");
                            my_option.text=option_text;
                            my_option.value=option_value;

                            new_index=select1.selectedIndex+1;
                            select1.remove(select1.selectedIndex);
                            select1.add(my_option,new_index);
                            select1.selectedIndex=new_index;
                          }
			}
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NetDiskShare")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form action="?" method="POST" name="form1" onSubmit="CheckForm()">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="path" value="<%=path%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>组或会员:</td>
<td>
<table><tr>
              <td>选定会员</td>
              <td>&nbsp;</td>
              <td>备选会员</td>
            </tr>
            <tr>
              <td>
                <!-- onblur="purview_disabled()"  onfocus="purview_disabled()" -->
                <select name="toList" onChange="purview_disabled()"  multiple size="12"  style="WIDTH: 140px;"  ondblclick="move(form1.toList,form1.fromList,true);" >
                  <%StringBuffer sb_purview=new StringBuffer();
                  java.util.Enumeration enumer= NetDiskShare.findPath(path);
                    while(enumer.hasMoreElements())
                    {
                      int id=((Integer)enumer.nextElement()).intValue();
                      NetDiskShare nds=NetDiskShare.find(id);
                      id=nds.getName();

                      if( nds.getType()==0)
                      {
                        out.print("<option value=G"+id+">(组)"+SMSGroup.find(id).getName()+"</option>");
                        sb_purview.append("form1.G"+id+"_purview"+nds.getPurview()+".checked=true;");
                      } else
                      {
                        out.print("<option value=U"+id+">(用)"+SMSPhoneBook.find(id).getName()+"</option>");
                        sb_purview.append("form1.U"+id+"_purview"+nds.getPurview()+".checked=true;");
                      }
                    }
                  %>
                </select></td>
              <td align="center" ><input onClick="move(form1.fromList,form1.toList,true);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <input onClick="move(form1.toList,form1.fromList,true);" type="button" value=" → " id=button2 name=button2>
                <br>
                <input onClick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
                <br>
                <input onClick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td>
                <select onBlur="purview_disabled()"  onfocus="purview_disabled()" ondblclick="move(form1.fromList,form1.toList,true);" style="WIDTH: 140px;" multiple size="12" name="fromList" >
                  <%
                  StringBuffer sb=new StringBuffer();
                  StringBuffer sb_display=new StringBuffer();
                  java.util.Enumeration ar_enumer=SMSGroup.findByMember(teasession._rv._strR,teasession._strCommunity);
                  while(ar_enumer.hasMoreElements())
                  {
                    int ar_id=((Integer)ar_enumer.nextElement()).intValue();
                    sb.append("<span id=G"+ar_id+" style=\"display:none\"><input onclick=purview_onclick_select(this) name=G"+ar_id+"_purview0   id=CHECKBOX type=CHECKBOX value=0>下载 ");
                    sb.append("<input onclick=purview_onclick_select(this) name=G"+ar_id+"_purview1  id=CHECKBOX type=\"CHECKBOX\" value=1>上传 ");
                    sb.append("<input onclick=purview_onclick_select(this)  name=G"+ar_id+"_purview2  id=CHECKBOX type=\"CHECKBOX\" value=2>修改</span>");
                    sb_display.append("document.all('G"+ar_id+"').style.display='none';");

                    out.print("<option value=G"+ar_id+">(组)"+SMSGroup.find(ar_id).getName());
				  }

                  ar_enumer=SMSPhoneBook.findByMember(teasession._rv._strR,teasession._strCommunity);
                  while(ar_enumer.hasMoreElements())
                  {
                    int ar_id=((Integer)ar_enumer.nextElement()).intValue();
                    sb.append("<span id=U"+ar_id+" style=\"display:'none'\"><input onclick=purview_onclick_select(this)  name=U"+ar_id+"_purview0   id=CHECKBOX type=\"CHECKBOX\" value=0>下载 ");
                    sb.append("<input onclick=purview_onclick_select(this)  name=U"+ar_id+"_purview1  id=CHECKBOX type=\"CHECKBOX\" value=1>上传 ");
               		sb.append("<input onclick=purview_onclick_select(this)  name=U"+ar_id+"_purview2  id=CHECKBOX type=\"CHECKBOX\" value=2>修改</span>");
                    sb_display.append("document.all('U"+ar_id+"').style.display='none';");

                    out.print("<option value=U"+ar_id+">(用)"+SMSPhoneBook.find(ar_id).getName());
				 }
				%>
                </select>
                <script type="">
                for(index=0;index<form1.toList.length;index++)
                {
                  for(i=0;i<form1.fromList.length;i++)
                  {
                    if( form1.toList[index].value==form1.fromList[i].value)
                    {
                      form1.fromList.remove(i);
                    }
                  }
                }
                </script>
              </td>
            </tr>
			</table>
		<tr><td>权限:</td><td><%=sb.toString()%></td></tr>
		</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>
<script>
<%=sb_purview.toString()%>
function purview_onclick_select(obj)
{
  if(obj.name.lastIndexOf("_purview2")!=-1)
  {
   if(obj.checked)
   {
     var name=obj.name.substring(0,obj.name.length-1);
     eval('form1.'+name+'1').checked=true;
     eval('form1.'+name+'0').checked=true;
   }
  }else if(obj.name.lastIndexOf("_purview1")!=-1)
  {
    var name=obj.name.substring(0,obj.name.length-1);
    if(obj.checked)
    {
      eval('form1.'+name+'0').checked=true;
    }else
    {
      eval('form1.'+name+'2').checked=false;
    }
  }else if(obj.name.lastIndexOf("_purview0")!=-1)
  {
    var name=obj.name.substring(0,obj.name.length-1);
    if(!obj.checked)
    {
      eval('form1.'+name+'1').checked=false;
      eval('form1.'+name+'2').checked=false;
    }
  }
}


function purview_select()
{
  for(var index=0;index<form1.elements.length;index++)
  {
    if(form1.elements[index].name.lastIndexOf("_purview2")!=-1)
    {
      if(form1.elements[index].checked)
      {
        var name=form1.elements[index].name.substring(0,form1.elements[index].name.length-1);
        eval('form1.'+name+'1').checked=true;
        eval('form1.'+name+'0').checked=true;
      }
    }else
    if(form1.elements[index].name.lastIndexOf("_purview1")!=-1)
    {
      if(form1.elements[index].checked)
      {
        var name=form1.elements[index].name.substring(0,form1.elements[index].name.length-1);
        eval('form1.'+name+'0').checked=true;
      }
    }
  }
}
purview_select();
function purview_disabled()
{
  <%=sb_display.toString()%>
  //document.write(form1.toList.selectedIndex);
  disabled_bool= form1.toList.selectedIndex==-1;
  //for(var index=0;index<form1.purview.length;index++)
  //form1.purview[index].disabled=disabled_bool;
  if(!disabled_bool)
  {
    var  name = form1.toList.options[form1.toList.selectedIndex].value;
    document.all(name).style.display='';
   // document.all(name+'_purview0').checked=true;
  }
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
--------------------------%>

