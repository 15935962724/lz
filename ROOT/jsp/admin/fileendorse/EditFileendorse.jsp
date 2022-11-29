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


String community=teasession._strCommunity;

String id = teasession.getParameter("id");

String nexturl = request.getParameter("nexturl");
int fileendorse = Integer.parseInt(request.getParameter("fileendorse"));
FileEndorse feobj = FileEndorse.find(fileendorse);
String acceptmember =null, caption=null,content=null;
int maplen=0;
if(fileendorse>0)
{
  acceptmember = feobj.getAcceptmember();
  caption = feobj.getCaption();
  content = feobj.getContent();
   if(feobj.getFileurl()!=null)
 {
 	maplen=(int)new java.io.File(application.getRealPath(feobj.getFileurl())).length();
 }

}



%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>
  <body>
  <script>


 function LoadWindow2(c,c1)
  {
    URL="/jsp/admin/fileendorse/optmember.jsp?community=<%=teasession._strCommunity%>&text="+c+"&hidden="+c1;
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
    if(form1.acceptmember.value=="")
    {
      alert("请选择发布人员");
      return false;
    }
    if(form1.caption.value=="")
    {
      alert("请填写文件标题");
      return false;
    }

  }

    function clear_dept()
  {
    document.form1.bulletin.value="";

  }

  </script>
  <h1>新建文件会签</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form enctype="multipart/form-data" name="form1" METHOD="post" action="/servlet/EditFileEndorse" onSubmit="return sub(this);">
    <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <input type="hidden" name="act" value="EditFileendorse"/>
    <input type="hidden" value="<%=fileendorse%>" name="fileendorse"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>发布人员：</td><td><textarea cols=30 name="acceptmembers" rows=2  title="yes" readonly>
          <%
                if(acceptmember!=null){
                  String memstr[] =   acceptmember.split("/");
                  for(int i=0;i<memstr.length;i++)
                  {
                    tea.entity.member.Profile p = tea.entity.member.Profile.find(memstr[i]);
                    out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"/");
                  }
                }
          %>
          </textarea>
            <input type="button" name="" value="添加" onClick="LoadWindow2('form1.acceptmembers','form1.acceptmember');" >
            <input type="button" name="" value="清空" onClick="clear_dept();">
              <input type="hidden"  value="<%if(acceptmember!=null)out.print(acceptmember); %>" name="acceptmember">



          </td>
        </tr>
        <tr>
          <td>文件标题：</td><td><input type="text" name="caption" value="<%if(caption!=null)out.print(caption);%>" size=50></td>
        </tr>

        <tr>
          <td>文件备注：</td><td><textarea name="content" cols=60 rows=10 ><%if(content!=null)out.print(content);%></textarea> </td>
        </tr>
         <tr>
          <td>附件文件：</td><td><input type="file" name ="fileurl" value="" />
          <%
              if(maplen>0){out.print(maplen+"字节");
              %>
              <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.fileurl.disabled=this.checked;"/> 清空
            <%  }%>

         </td>
        </tr>

      </table>
      <input type="Submit" name="" value="发布"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='/jsp/admin/fileendorse/fileendorse.jsp'" >
    </FORM>

    <br>
    <div id="head6"><img height="6" src="about:blank"></div>
  </body>
</html>




