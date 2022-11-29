<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");


int worktel=0;
if(request.getParameter("worktel")!=null)
{
  worktel=Integer.parseInt(request.getParameter("worktel"));
}
int workproject=0,worktype=0;
boolean teltype=false;
String content=null,time=null,worklinkman=null,telephone=null,imember=null;
if(worktel>0)
{
  Worktel obj=Worktel.find(worktel);
  workproject=obj.getWorkproject();
  worklinkman=obj.getWorklinkman();
  teltype=obj.isTeltype();
  telephone=obj.getTelephone();
  imember=obj.getImember();
  time=obj.getCtimeToString();
  content=obj.getContent(teasession._nLanguage);
}else
{
  time=Worktel.sdf.format(new java.util.Date());
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
<script>
function func_move(select1,select2)
{
  for(var i=0;i<select1.options.length;)
  {
    if(select1.options[i].selected)
    {
      var len=select2.options.length;
      select2.options[len]=new Option(select1.options[i].text,select1.options[i].value);
      select2.options[len].selected=true;
      select1.options[i]=null;
    }else
    i++;
  }
}
function func_check()
{
  form1.imember.value="/";
  for(var i=0;i<form1.toList.options.length;i++)
  {
    form1.imember.value=form1.imember.value+form1.toList.options[i].value+"/";
  }
}
</script>
</head>
<body onLoad="form1.time.focus();">
<!--1170212391937=电话记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1170212391937")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

   <form name="form1" METHOD="post" action="/servlet/EditWorkreport" onSubmit="return submitText(this.time,'<%=r.getString(teasession._nLanguage,"Time")%>')&&submitText(this.workproject,'<%=r.getString(teasession._nLanguage,"1168584443703")%>')&&submitText(this.telephone,'<%=r.getString(teasession._nLanguage,"1168584722562")%>')&&submitText(this.content,'<%=r.getString(teasession._nLanguage,"InvalidText")%>')&&func_check();">
     <input type=hidden name="community" value="<%=community%>"/>
     <input type=hidden name="worktel" value="<%=worktel%>"/>
     <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
     <input type=hidden name="action" value="editworktel"/>
     <input type=hidden name="imember" value="/"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr><td><%=r.getString(teasession._nLanguage,"Time")%></td>
     <td><input name="time" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(time!=null)out.print(time);else{out.print("yyyy-MM-dd");}%>" maxlength="10">
     <A href="###"><img onClick="showCalendar('form1.time');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td></tr>

     <tr><td><%=r.getString(teasession._nLanguage,"1168584443703")%></td>
       <td>
         <select name="workproject" onChange="fchange(this.value);">
           <option value="">-------------</option>
           <%
           StringBuffer sb=new StringBuffer();
           java.util.Enumeration e=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(e.hasMoreElements())
           {
             int id=((Integer)e.nextElement()).intValue();
             Workproject obj=Workproject.find(id);
             out.print("<option value="+id);
             if(id==workproject)
             out.print(" SELECTED ");
             out.print(" >"+obj.getName(teasession._nLanguage));

             sb.append("case ").append(id).append(": ");
             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+id,0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String worklinkman_id=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,worklinkman_id);
               sb.append("obj.options[obj.options.length]=new Option(\""+worklinkman_id+"\",\""+worklinkman_id+"\");");
             }
             sb.append("break;\r\n");
           }
           %>
           </select>
           <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
           <input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=0&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>','_self');">
       </td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"1168584403266")%></td>
       <td><select name="worklinkman"><option value="">-------------</option></select>
           <script type="">
           function fchange(value)
           {
             var obj=form1.worklinkman;
             while(obj.options.length>1)
             {
               obj.options[1]=null;
             }
             switch(parseInt(value))
             {
               <%=sb.toString()%>
             }
           }
           fchange(form1.workproject.value);
           <%
           if(worklinkman!=null)
           {
             out.print("form1.worklinkman.value=\""+worklinkman+"\";");
           }
           %>
           </script><input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Worklinkmans_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.worklinkman&workproject='+form1.workproject.value,'','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
     </td></tr>

     <tr><td><%=r.getString(teasession._nLanguage,"1168592903313")%></td>
       <td><input name="teltype" type="radio" value="true" checked="checked" /><%=r.getString(teasession._nLanguage,"1170212958984")%>
         <input name="teltype" type="radio" value="false" <%if(!teltype)out.print(" checked ");%> /><%=r.getString(teasession._nLanguage,"1170212966468")%></td></tr>

     <tr><td><%=r.getString(teasession._nLanguage,"1168584722562")%></td>
       <td><input name="telephone" type="text" value="<%if(telephone!=null)out.print(telephone);%>"></td></tr>


     <tr><td><%=r.getString(teasession._nLanguage,"1170213683406")%></td><td>

       <table cellSpacing="0" cellPadding="0" border="0">
            <tr>
              <td ><select name="toList"  size="5" multiple style="WIDTH: 140px;"  ondblclick="func_move(form1.toList,form1.fromList);" >
              <%
              if(imember!=null)
              {
                String is[]=imember.split("/");
                for(int i=0;i<is.length;i++)
                {
                  if(is[i].length()>0)
                  {
                    out.print("<option value="+is[i]+" >"+is[i]);
                  }
                }
              }
              %>
              </select></td>
              <td width="20">
                <input onClick="func_move(form1.fromList,form1.toList);" type="button" value=" ← " id=button1 name=button1>
                <input onClick="func_move(form1.toList,form1.fromList);" type="button" value=" → " id=button2 name=button2>
              </td>
              <td >
                <select multiple ondblclick="func_move(form1.fromList,form1.toList);" style="WIDTH: 140px; " size="5" name="fromList" >
                  <%
                  java.util.Enumeration e__=AdminUsrRole.find(teasession._strCommunity," AND DATALENGTH(role)>1",0,Integer.MAX_VALUE);
                  while(e__.hasMoreElements())
                  {
                    String member=(String) e__.nextElement();
                    out.print("<option value="+member+" >"+member);
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

     </td></tr>
     <tr><td></td><td><input name="sendmail" type="checkbox" value=""><%=r.getString(teasession._nLanguage,"1170219368359")%><!--1170219368359=需要通知的人员--></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"Text")%><!--内容--></td><td><textarea name="content" rows="8" cols="80"><%if(content!=null)out.print(content);%></textarea></td></tr>
   </table>
   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
   <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



