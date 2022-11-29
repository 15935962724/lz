<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int type = Integer.parseInt(request.getParameter("type"));
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


  <SCRIPT>


 function   returnID(id)
  {
        window.returnValue   =   id;
        window.close();
  }
    </SCRIPT>


    <body>
    <form action="" name="form2">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <thead class="TableControl">
        <th colspan="2" bgcolor="#d6e7ef" align="center">选择部门</th>
      </thead>


      <%

     // AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
     // String sql = " and unit="+au_obj.getUnit()+" and classes="+au_obj.getClasses();
       // sql ="";
       if(type==0){
       java.util.Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,"");
       while(enumer.hasMoreElements())
       {
         AdminUnit obj_au=(AdminUnit)enumer.nextElement();
         int adid=obj_au.getId();
         %>
         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
           <td align="center" onclick="returnID('<%=adid+"/"+obj_au.getName()%>');"><%=obj_au.getName()%></td></tr>
           <%
           }
          }
          if(type==1){


            //out.print(AdminUsrRole.find("DEV","webmaster").getRole());//取出当前会员的角色

            java.util.Enumeration adme=AdminRole.findByCommunity(teasession._strCommunity,-1);
            while(adme.hasMoreElements())
            {
              int adid=((Integer)adme.nextElement()).intValue();
              AdminRole adobj = AdminRole.find(adid);

              %>

              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
                  <td align="center" onclick="returnID('<%=adid+"/"+adobj.getName()%>');"><%=adobj.getName()%></td>
              </tr>


              <%
              }
            }
 %>
        </table>

    </form>
    </body>
</html>




