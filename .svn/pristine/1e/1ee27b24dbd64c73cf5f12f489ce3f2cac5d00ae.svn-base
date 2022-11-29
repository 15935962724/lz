<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Communitysubscriber obj=Communitysubscriber.find(teasession._strCommunity);
if(request.getMethod().equals("POST"))
{
  String to[]=request.getParameterValues("toList");
  StringBuffer sb=new StringBuffer();
  for(int i=0;i<to.length;i++)
  {
    sb.append("/").append(to[i]);
  }
  if(obj.isExists())
  {
    obj.set(sb.toString());
  }else
  {
    Communitysubscriber.create(teasession._strCommunity,sb.toString());
  }
  response.sendRedirect(request.getRequestURI()+"?community="+teasession._strCommunity);
  return;
}
Resource r=new Resource("/tea/ui/member/community/Subscribers");

String exports=obj.getExports();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT language="JavaScript">

function func_insert(select2,select1)
{
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options[select2.selectedIndex].text;
    option_value=select2.options[select2.selectedIndex].value;

    for (i=0; i< select1.options.length; i++)
    {
      if(select1.options[i].value==option_value)
      {
        return ;
      }
    }
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    select1.options[select1.length]=(my_option);

    select1.selectedIndex=select1.length-1;
    select2.options[select2.selectedIndex]=null;
  }
}

function func_delete(select2,select1)
{
  if(select1.selectedIndex!=-1)
  {
    option_text=select1.options[select1.selectedIndex].text;
    option_value=select1.options[select1.selectedIndex].value;
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;
    select2.options[select2.length]=(my_option);

    select1.options[select1.selectedIndex]=null;
  }
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

function func_submit(obj)
{
   for(var i=0;i<obj.options.length;i++)
   {
     obj.options[i].selected=true;
   }
   if(obj.options.length<1)
   {
     alert('<%=r.getString(teasession._nLanguage, "1172641990437")%>');
     obj.focus();
     return false;
   }
   return true;
}
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Subscribers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="" onsubmit="return func_submit(this.toList);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
<TR>
<TD  noWrap ><%=r.getString(teasession._nLanguage, "1172641990438")%>:</TD>
  <TD>
    <table>
    <tr align="center">
      <td ><%=r.getString(teasession._nLanguage, "1172641990437")%></td>
      <td >&nbsp;</td>
      <td ><%=r.getString(teasession._nLanguage, "1172641977453")%></td>
    </tr>
    <tr>
    <td ><select name="toList"  size="13" multiple style="WIDTH: 140px;"  ondblclick="func_delete(form1.fromList,form1.toList);" >
                  <%--
                  if(exports!=null)
                  {
                    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(exports,"/");
                    while(tokenizer_obj.hasMoreTokens())
                    {
                      String export=(String)tokenizer_obj.nextElement();
                        out.print("<option value="+export+" >"+export);
                    }
                  }
--%>
                </select></td>
              <td width="50" align="center" ><input onClick="func_insert(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <input  onClick="func_delete(form1.fromList,form1.toList);" type="button" value=" → " id=button2 name=button2>
                <br>
                <input onClick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
                <br>
                <input onClick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td width="140">
                <select ondblclick="func_insert(form1.fromList,form1.toList);" style="WIDTH: 140px; " size="13" name="fromList" >
                  <%
                  for (int i=0;i<obj.FIELD_TYPE.length;i++)
                  {
                    if(obj.FIELD_TYPE[i]!=null)
                    out.print("<option value="+i+" >"+r.getString(teasession._nLanguage,obj.FIELD_TYPE[i]));
                  }
                  %>
                </select>
                <script type="">
                var exports="<%=exports%>".split("/");
                for(var index=0;index<exports.length;index++)
                {
                  for(var i=0;i<form1.fromList.length;i++)
                  {
                    if(exports[index]==form1.fromList[i].value)
                    {
                      form1.toList.options[form1.toList.options.length]=new Option(form1.fromList.options[i].text,form1.fromList.options[i].value);
                      form1.fromList.options[i]=null;
                      break;
                    }
                  }
                }
                </script>
              </td>
            </tr>
          </table>
  </TD>
</TR>
</table>

<input type="submit"  class="edit_input"  name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


