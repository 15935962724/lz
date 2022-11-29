<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");

String text=request.getParameter("text");

String hidden=request.getParameter("hidden");


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

  <style>
  .menulines{}
  </style>

  <SCRIPT>
  <!--

  var menu_enter="";

  function borderize_on(e)
  {
    color="#708DDF";
    source3=event.srcElement;
    if(source3.className=="menulines" && source3!=menu_enter)
    source3.style.backgroundColor=color;
  }

  function borderize_on1(e)
  {
    for (i=0; i<document.all.length; i++)
    { document.all(i).style.borderColor="";
    document.all(i).style.backgroundColor="";
    document.all(i).style.color="";
    document.all(i).style.fontWeight="";
  }

  color="#003FBF";
  source3=e.srcElement;

  if(source3.className=="menulines")
  { source3.style.borderColor="black";
  source3.style.backgroundColor=color;
  source3.style.color="white";
  source3.style.fontWeight="bold";
}

menu_enter=source3;
}

function borderize_off(e)
{
  source4=e.srcElement;

  if(source4.className=="menulines" && source4!=menu_enter)
  {source4.style.backgroundColor="";
  source4.style.borderColor="";
}
}

var v="";
function add_dept(dept_name)
{
  if(v!="")
  v=v;
  v=v+"/"+dept_name;
  window.returnValue = v;
  window.close();
}

    function selectAll(form,check)
    {
      if(form2.checkbox2.length)
      {
        for(index=0;index<form2.checkbox2.length;index++)
        {
          if(form2.checkbox2[index].type=='checkbox')
          {
            form2.checkbox2[index].checked=check.checked;
          }
        }
      }
      else
      {
          form2.checkbox2.checked=check.checked;
      }
    }
    function add_all()
    {
      var hidden="";
      var check=document.all('checkbox2');
      var sunsk= document.all('checkbox1');
      for(var i=0;i<check.length;i++)
      {
        if(check[i].checked)
        {
          if(v!="")
          v=v;
          v=v+"/"+check[i].value;
          hidden=hidden+"/"+sunsk[i].value;
        }
      }
      window.dialogArguments.<%=text%>.value=v;
      window.dialogArguments.<%=hidden%>.value=hidden;
      window.close();
    }

    </SCRIPT>


    <body class="bodycolor" onMouseover="borderize_on(event);" onMouseout="borderize_off(event);" onclick="borderize_on1(event);" topmargin="5">
    <form action="" name="form2">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <thead class="TableControl">
        <th colspan="2" bgcolor="#d6e7ef" align="center">选择人员</th>
      </thead>


      <%
     // String member = teasession._rv.toString();//当前用户



   //  AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);


      //String sql = " and unit="+au_obj.getUnit()+" and classes="+au_obj.getClasses()+" and creator = '"+member+"'";

       // sql ="";

       // java.util.Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,sql);
       java.util.Enumeration e=AdminUsrRole.findByCommunity(teasession._strCommunity,"");
for(int i=1;e.hasMoreElements();i++)
{
  String _member=(String)e.nextElement();
  AdminUsrRole obj=AdminUsrRole.find(teasession._strCommunity,_member);
  Profile pf_obj_temp=Profile.find(_member);



      //  while(enumer.hasMoreElements())
       // {
        //  int adid=((Integer)enumer.nextElement()).intValue();
         // AdminUnit obj_au=  AdminUnit.find(adid);

        %>



          <input type="hidden" value="<%=_member%>" name="checkbox1">
          <tr><td id=unitlist nowrap class="menulines" align="center" >

            <input type="checkbox" name="checkbox2" value="<%=pf_obj_temp.getLastName(teasession._nLanguage)+pf_obj_temp.getFirstName(teasession._nLanguage)%>" style="cursor:hand"></td>
            <td><%=pf_obj_temp.getLastName(teasession._nLanguage)+pf_obj_temp.getFirstName(teasession._nLanguage)%></td></tr>
            <%

          }

        %>
        <tr>
        <td id=unitlist nowrap class="menulines" align="center"><input type="CHECKBOX" onclick="selectAll(form2,this)" value="0" style="cursor:hand">全选</td>
          <td><input name="button"  type="button" value="提交" onclick="add_all()" /></td>
      </tr>
        </table>

    </form>
    </body>
</html>




