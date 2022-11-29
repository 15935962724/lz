<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>

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




String id = teasession.getParameter("id");

String nexturl = request.getParameter("nexturl");

int archives = Integer.parseInt(request.getParameter("archives"));
Archives avobj = Archives.find(archives);
String adminunit =null,role=null,caption=null,content=null,fileurl=null;
int maplen =0;
if(archives>0)
{
  adminunit =avobj.getAdminunit();
  role=avobj.getRole();
  caption=avobj.getCaption();
  content=avobj.getContent();
  fileurl=avobj.getFileurl();
  maplen=(int)new java.io.File(application.getRealPath(fileurl)).length();

}

%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>
  <body>
  <script language="javascript" type="">

  function LoadWindow2(c,c1)
  {
    URL="/jsp/admin/flow/NewDepartment.jsp?community=<%=teasession._strCommunity%>&text="+c+"&hidden="+c1;
    loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
    loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:240px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");

    if(arr!=null)
    {

      var app = arr.split("/");
      for(var i=0;i<app.length;i++)
      {
        form1.tounitname.value+=app[0];
        form1.tounit.value+=app[1]+"/";
      }
    }

  }
  function LoadWindow1(c,c1)
  {
    URL="/jsp/admin/flow/Newpart.jsp?community=<%=teasession._strCommunity%>&text="+c+"&hidden="+c1;
    loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
    loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:240px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");

    if(arr!=null)
    {

      var app = arr.split("/");
      for(var i=0;i<app.length;i++)
      {
        form1.tounitname.value+=app[0];
        form1.tounit.value+=app[1]+"/";
      }

    }

  }


  function sub()
  {
      if(form1.adminunit.value=='' && form1.role.value=='')
      {
        alert("发布范围中部门和角色选择一个即可！");
        return false;
      }
      if(form1.caption.value=='')
      {
        alert("文件标题不能为空！");
        return false;
      }
  }
  function clear_dept()
  {
    document.form1.adminunits.value="";
    document.form1.adminunit.value="";

  }
  function clear_dept1()
  {
    document.form1.roles.value="";
    document.form1.role.value="";

  }


  </script>
  <h1>新建文件会签</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form enctype="multipart/form-data" name="form1" METHOD="post" action="/servlet/EditArchives" onSubmit="return sub(this);">
      <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
      <input type="hidden" name="act" value="EditArchives"/>
      <input type="hidden" name="archives" value="<%=archives%>"/>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>发布范围（部门）：</td><td><textarea cols=30 name="adminunits" rows=2  title="yes" readonly>
             <%
             if(adminunit!=null){
               String auid[] =   adminunit.split(",");
               for(int i=1;i<auid.length;i++)
               {
                 AdminUnit auobj = AdminUnit.find(Integer.parseInt(auid[i]));
                 out.print(auobj.getName()+",");

               }
             }
          %>
         </textarea>
            <input type="button" name="" value="添加" onClick="LoadWindow2('form1.adminunits','form1.adminunit');" >
            <input type="button" name="" value="清空" onClick="clear_dept();">
            <input type="hidden"  value="<%if(adminunit!=null)out.print(adminunit);%>" name="adminunit">

          </td>
        </tr>

        <tr>
          <td>发布范围（角色）：</td><td><textarea cols=30 name="roles" rows=2  title="yes" readonly>
          <%
          if(role!=null){
            String roid[] =   role.split(",");
            for(int ii=1;ii<roid.length;ii++)
            {
              AdminRole roobj = AdminRole.find(Integer.parseInt(roid[ii]));
              out.print(roobj.getName()+",");
            }
          }
          %>
          </textarea>
            <input type="button" name="" value="添加" onClick="LoadWindow1('form1.roles','form1.role');" >
            <input type="button" name="" value="清空" onClick="clear_dept1();">
            <input type="hidden" value="<%if(role!=null)out.print(role);%>" name="role">
          </td>
        </tr>
        <tr>
          <td>文件标题：</td><td><input type="text" name="caption" value="<%if(caption!=null)out.print(caption);%>" size=50></td>
        </tr>

        <tr>
          <td>文件备注：</td><td><textarea name="content" cols=60 rows=10 ><%if(content!=null)out.print(content);%></textarea> </td>
        </tr>
        <tr><td>附件上传：</td><td>
          <input type="file" name="fileurl" size="30"/>
          <%
              if(maplen>0){out.print(maplen+"字节");
              %>
              <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.fileurl.disabled=this.checked;"/> 清空
            <%  }%>
        </td></tr>
      </table>
      <br>
      <input type="Submit" name="" value="发布"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='/jsp/admin/archives/Archives.jsp'" >
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</html>




