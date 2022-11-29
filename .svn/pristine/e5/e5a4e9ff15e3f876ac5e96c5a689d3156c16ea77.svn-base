<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"  %>
<%@include file="/jsp/Header.jsp"%>

<%!
String community;

class DirFilter implements java.io.FilenameFilter
{
  private java.util.regex.Pattern pattern;
  public DirFilter(String regex)
  {
    pattern = java.util.regex.Pattern.compile(regex);
  }
  public boolean accept(java.io.File dir, String name)
  {
    // Strip path information, search for regex:
    return pattern.matcher(new java.io.File(name).getName()).matches();
  }
}
java.util.Vector vector=new java.util.Vector();
public void find(java.io.File file,String filter)
{
  java.io.File path[] = file.listFiles(new DirFilter(filter));
  for(int i = 0; i < path.length; i++)
  {
    vector.addElement(path[i]);
    if(path[i].isDirectory())
    find(path[i],filter);
  }
}
public String getDir(String path,boolean isDir)throws java.io.IOException
{
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("/<a href=\"?url=/\">"+r.getString(teasession._nLanguage, "Root")+"</a>");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    if(!isDir&&!tokenizer.hasMoreTokens())
    {
      sb.append(label);
    }else
    {
      sb.append(label+"/");
    }
    sb2.append("/").append(new tea.html.Anchor("?url="+java.net.URLEncoder.encode(sb.toString(),"UTF-8"),label));
  }
  return(sb2.toString());
}
String contextPath="";
%>
<%
community=teasession._strCommunity;

if(!Safety.find(teasession._rv.toString(),community,1).isExists()&&!Safety.find(teasession._rv.toString(),community,2).isExists()&&!Safety.find(teasession._rv.toString(),community,3).isExists()&&!License.getInstance().getWebMaster().equals(teasession._rv._strR))
{
  response.sendError(403);
  return;
}
r.add("/tea/resource/NetDisk");
boolean find=request.getParameter("find")!=null;
contextPath=request.getContextPath();
///////////////////////////////////////////增删改查
String url=request.getParameter("url");
if(url==null)
url="/";

Safety objwork=Safety.find(url);


%>
<html>
  <head>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <SCRIPT LANGUAGE=JAVASCRIPT  type="text/javascript">
      function LoadWindow(c,c1)
      {
        URL="/jsp/netdisk/NetDiskSelect.jsp?community=<%=teasession._strCommunity%>&text="+c+"&hidden="+c1;
        loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
        loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
        var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:520px;dialogHeight:740px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
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
      function LoadWindow2(c,c1)
      {
        URL="/jsp/admin/flow/NewDepartment.jsp?community=<%=teasession._strCommunity%>&text="+c+"&hidden="+c1;
        loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
        loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
        var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:640px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
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
        var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:540px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
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
      function clear_dept()
      {
        document.form1.personnel.value="";
        document.form1.members.value="";
      }
      function clear_dept2()
      {
        document.form1.bulletin.value="";
        document.form1.bulletinid.value="";
      }
      function clear_dept3()
      {
        document.form1.part.value="";
        document.form1.partid.value="";
      }
      </SCRIPT>
      </head>
      <body>
      <h1><%=r.getString(teasession._nLanguage, "EditNetDisk")%></h1>
      <div id="head6"><img height="6" src="about:blank"></div>
        <br>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td ><%
            if(url==null)
            url="/";

            out.print(r.getString(teasession._nLanguage, "Path")+":"+getDir(url,true)); %>
            </td>
            <td align="right" ><a href="javascript:location.reload()"><img src="/tea/image/other/refresh.gif" alt="" border="0"></a>
              <a href="/jsp/netdisk/NetDiskHelp.jsp"  target="_blank"><img src="/tea/image/other/help.gif" alt="" border="0"></a></td>
          </tr>
        </table>

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr ID=tableonetr>
            <td align=center class="huiditable">权限所有人</td>
            <td align=center class="huiditable">所有权限</td>
            <td align="center" class="huiditable">修改时间</td>
          </tr>
          <%
          java.util.Enumeration enumes = Safety.findbypath(teasession._strCommunity,"and path="+DbAdapter.cite(url),0,10);
          for(int index=0;enumes.hasMoreElements();index++)
          {
            int id  = Integer.parseInt(enumes.nextElement().toString());
            Safety obj=Safety.find(id);
            %>
            <tr>
              <td>
              <%
              if(obj.getPartid()!=null && obj.getPartid().length()>0)
              {
                out.print("<br>角色：");
                String str1=obj.getPartid();
                String stor1[]=str1.split(",");
                for(int i=1;i<stor1.length;i++)
                {
                  int aa1 = Integer.parseInt(stor1[i].toString());
                  AdminRole adminrole = AdminRole.find(aa1);
                  adminrole.getName();
                  out.print(adminrole.getName()+",");
                }
              }
              if(obj.getBulletinid()!=null && obj.getBulletinid().length()>0)
              {
                out.print("<br>部门：");
                String str2=obj.getBulletinid();
                String stor2[]=str2.split(",");
                for(int i=1;i<stor2.length;i++)
                {
                  int aa2 = Integer.parseInt(stor2[i].toString());
                  AdminUnit unit = AdminUnit.find(aa2);
                  out.print(unit.getName()+",");
                }
              }
              if(obj.getPersonnel()!=null && obj.getPersonnel().length()>0)
              {
                out.print("<br>人员：");
                String str3=obj.getPersonnel();
                String stor3[]=str3.split(",");
                for(int i=1;i<stor3.length;i++)
                {
                  if(i%8==0)
                  {
                    out.print("<br>");
                  }
                  Profile pro = Profile.find(stor3[i]);
                  out.print(pro.getName(teasession._nLanguage)+",");
                }
              }
              %>
              </td>
              <td>
              <%
              if(obj.getSystemreg()==1)
              {
                out.print("<input type=image src=/tea/image/other/renommer.gif>");
              }
              if(obj.getSystemdowload()==1)
              {
                out.print("<input type=image src=/tea/image/other/download.gif>");
              }
              if(obj.getSystemdel()==1)
              {
                out.print("<input type=image src=/tea/image/other/supprimer.gif>");
              }
              %>
              </td>
              <td><%=obj.getFiledate()%></td>
            </tr>
            <%
            }
            %>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <form name="form1" method="post" action="/servlet/EditNetDisk">
              <input type="hidden" name="rep" value="">
              <input type="hidden" name="action" value="mkdir">
              <input type="hidden" name="url" value="<%=url%>">
              <input type="hidden" name="ordre" value="">
              <input type="hidden" name="sens" value="0">
              <tr>
                <td>按（角色）分：</td><td><textarea cols=30 name="part" rows=2  wrap="yes" readonly><%
                if(objwork.getPartid()!=null && objwork.getPartid().length()>0)
                {
                  String str1=objwork.getPartid();
                  String stor1[]=str1.split(",");
                  for(int i=1;i<stor1.length;i++)
                  {
                    int aa1 = Integer.parseInt(stor1[i].toString());
                    AdminRole adminrole = AdminRole.find(aa1);
                    out.print(adminrole.getName()+",");
                  }
                }
                  %></textarea>
                  <input type="button" name="" value="添加" onClick="LoadWindow1('form1.part','form1.partid');" >
                  <input type="button" name="" value="清空" onClick="clear_dept3();">
                  <input type="hidden" value="<%=objwork.getPartid()%>" name="partid">
                </td>
              </tr>
              <tr>
                <td>按（部门）分：</td><td><textarea cols=30 name="bulletin" rows=2  title="yes" readonly><%
                if(objwork.getBulletinid()!=null && objwork.getBulletinid().length()>0)
                {
                  String str2=objwork.getBulletinid();
                  String stor2[]=str2.split(",");
                  for(int i=1;i<stor2.length;i++)
                  {
                    int aa2 = Integer.parseInt(stor2[i].toString());
                    AdminUnit unit = AdminUnit.find(aa2);
                    out.print(unit.getName()+",");
                  }
                }
                  %></textarea>
                  <input type="button" name="" value="添加" onClick="LoadWindow2('form1.bulletin','form1.bulletinid');" >
                  <input type="button" name="" value="清空" onClick="clear_dept2();">
                  <input type="hidden"  value="<%=objwork.getBulletinid()%>" name="bulletinid">
                </td>
              </tr>
              <tr>
                <td>按（人员）分：</td><td><textarea  name="personnel" cols="30" rows="2" ><%
                if(objwork.getBulletinid()!=null && objwork.getBulletinid().length()>0)
                {
                  String str3=objwork.getPersonnel();
                  String stor3[]=str3.split(",");
                  for(int i=1;i<stor3.length;i++)
                  {
                    Profile pro = Profile.find(stor3[i]);
                    out.print(pro.getName(teasession._nLanguage)+",");
                  }
                }%></textarea>
                <input type="button"  value="添加" onClick="LoadWindow('form1.personnel','form1.members');" >
                <input type="button" name="" value="清空" onClick="clear_dept();">
                <input type="hidden"  value="<%=objwork.getPersonnel()%>" name="members">
                </td>
              </tr>
              <tr>
                <td>权&nbsp;&nbsp;限&nbsp;&nbsp;设&nbsp;&nbsp;置&nbsp;&nbsp;：</td>
                <td>

                  <INPUT disabled="disabled" checked="checked"  id="CHECKBOX" type="CHECKBOX" NAME="chkRight1" VALUE="4" />查看
                  <%
                  out.print("<INPUT  id=CHECKBOX type=CHECKBOX NAME=systemdowload VALUE=1 ");
                  if(objwork.getSystemdowload()==1)
                  {
                    out.print(" checked");
                  }
                  out.print("/>");
                  %>
                  <%=r.getString(teasession._nLanguage, "Download")%>
                  <%
                  out.print("<INPUT  id=CHECKBOX type=CHECKBOX NAME=systemreg VALUE=2 ");
                  if(objwork.getSystemreg()==1)
                  {
                    out.print(" checked");
                  }
                  out.print("/>");
                  %><%=r.getString(teasession._nLanguage, "New")%>
                  <%
                  out.print("<INPUT  id=CHECKBOX type=CHECKBOX NAME=systemdel VALUE=3 ");
                  if(objwork.getSystemdel()==1)
                  {
                    out.print(" checked");
                  }
                  out.print("/>");
                  %><%=r.getString(teasession._nLanguage, "Delete")%>
                  </tr>
                  <tr>
                    <td>属&nbsp;&nbsp;性&nbsp;&nbsp;更&nbsp;&nbsp;改&nbsp;&nbsp;：</td>
                    <td><input type="radio" name="extendtype" checked="checked" value="0">仅将更改应用于本文件夹<input type="radio" name="extendtype"  value="1">将更改应用于本文件夹、子文件夹和文件</td>
                  </tr>
                  <tr><td></td><td><input type="submit"  name="systems" value="提交"/>
                    <input type="hidden" name="url" value="<%=url%>">
                    <input type="button" name="fanhui" value="返回" onclick="window.history.back();">
                    </td></tr>
              </form>
            </table>
            <div id="head6"><img height="6" src="about:blank"></div>
              <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
      </body>
</html>

