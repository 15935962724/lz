<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.admin.sales.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String community = teasession._strCommunity;
int taid = 0, flowitem = 0;
int maplen = 0;
if (teasession.getParameter("taid") != null && teasession.getParameter("taid").length() > 0)
taid = Integer.parseInt(teasession.getParameter("taid"));
Task taobj = Task.find(taid);
int aa=0;
if(taobj.getTaskfrequency()!=0)
{
  aa  = taobj.getTaskfrequency();
}
Taskfrequency taskobj  =  Taskfrequency.find(aa);


String assigner = null, motif = null, remark = null, assignerid = null;
Date attime = new Date();
int fettle = 1, pri = 2;
if (taid > 0)
{
  assigner = taobj.getAssigner();
  motif = taobj.getMotif();
  attime = taobj.getAttime();
  fettle = taobj.getFettle();
  pri = taobj.getPri();
  remark = taobj.getRemark();
  assignerid = taobj.getAssignerid();
  flowitem = taobj.getFlowitem();
  if (taobj.getAcceefile() != null)
  {
    maplen = (int)new java.io.File(application.getRealPath(taobj.getAcceefile())).length();
  }
}
if (teasession.getParameter("delete") != null)
{
  taobj.delete();
  response.sendRedirect("/jsp/admin/sales/task.jsp");
  return;
}

int workproject_num=0;
if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
{
  workproject_num= Integer.parseInt(teasession.getParameter("workproject"));
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
</head>
<script>
function LoadWindow()
{

  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/admin/sales/assigner.jsp";
  var aio ="";
  var arr =window.showModalDialog(url,aio,sFeatures);
  if(arr!=null)
  {
    var arr1 = arr.split(",");
    document.all.assignerid.value=arr1[0];
    document.all.assigner.value = arr1[1];
  }
}
function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX+240;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+100;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:445px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/admin/workreport/Workprojects_2.jsp";
  var aio ="";
  document.all.flowitem.value =window.showModalDialog(url,aio,sFeatures);

}

function sub()
{
  return submitText(form1.assigner,'请选择被分配人')
  &&submitText(form1.flowitem,'请选择客户或项目')
  &&submitText(form1.motif,'请填写任务的主题')
  &&submitText(form1.attime,'请选择到期时间');
}

function   hiddentr(y)
{
  for(var i=0;i<form1.frequency.length;i++)
  {
    var str="";
    if(!form1.frequency[i].checked)
    {
      str= 'none';
    }
    eval("task_test"+i).style.display=str;
  }
}

function f_load()
{
  form1.datefq.onchange();

  var arr=form1.frequency;
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].checked)
    {
      hiddentr(arr[i]);
      break;
    }
  }
}


</script>
<body  onload="f_load()">
<h1>我的任务编辑</h1>
<div id="head6">
  <img height="6" src="about:blank">
</div>
<br>
<form name=form1 METHOD=post action="/servlet/EditTask" enctype="multipart/form-data" onsubmit="return sub(this);">
  <input type="hidden" name="taid" value="<%=taid %>">
  <input type="hidden" name="Taskfrequency"  value="<%=aa%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap>被分配的人:</td>
      <td nowrap>
        <input type="text" name="assigner" value="<%if(assigner!=null)out.print(assigner); %>">
        <input type="hidden" value="<%if(assignerid!=null && assignerid.length()>0)out.print(assignerid); %>" name="assignerid">
        <input type="button" value="添加" onclick="LoadWindow();">
      </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>      客户或项目
        <!--  客户或项目-->
      </td>
      <td>
        <select name="flowitem" >
          <option value="">------------------</option>
          <optgroup label="经常填写的项目">
          <%
          StringBuffer sb = new StringBuffer();
          String member = teasession._rv.toString(); //登录的用户ID
          java.util.Enumeration flmejc = Flowitem.findzuijin(teasession._strCommunity, "",teasession._rv.toString());

          //java.util.Enumeration flmejc = Flowitem.find(teasession._strCommunity, "and Flowitem in (select top 10 workproject from  Worklog  where member ="+DbAdapter.cite(teasession._rv.toString())+" group by workproject order by count(workproject) desc)");
          while (flmejc.hasMoreElements())
          {
            int flid = ((Integer) flmejc.nextElement()).intValue();
            Flowitem flobj = Flowitem.find(flid);
            if (flobj.getManager().indexOf(member) != -1 || flobj.getMember().indexOf(member) != -1)
            {
              out.print("<option value=" + flid);
              if (flid == flowitem || flid == workproject_num)
              out.print(" selected ");
              out.print(" >" + flobj.getName(teasession._nLanguage));
            }
            sb.append("case ").append(flid).append(": ");
            java.util.Enumeration e2 = Worklinkman.find(teasession._strCommunity, " AND workproject=" + flobj.getWorkproject(), 0, Integer.MAX_VALUE);
            while (e2.hasMoreElements())
            {
              String member_e = ((String) e2.nextElement());
              //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
              sb.append("obj.options[obj.options.length]=new Option(\"" + member_e + "\",\"" + member_e + "\");");
            }
            sb.append("break;\r\n");
          }
          %>
          </optgroup>
          <optgroup label="进行中的项目">
          <%

          java.util.Enumeration flmejx = Flowitem.find(teasession._strCommunity, " and itemgenre=2  order by flowitem desc");
          while (flmejx.hasMoreElements())
          {
            int flid = ((Integer) flmejx.nextElement()).intValue();
            Flowitem flobj = Flowitem.find(flid);
            if (flobj.getManager().indexOf(member) != -1 || flobj.getMember().indexOf(member) != -1)
            {
              out.print("<option value=" + flid);
              if (flid == flowitem || flid == workproject_num)
              out.print(" selected ");
              out.print(" >" + flobj.getName(teasession._nLanguage));
            }
            sb.append("case ").append(flid).append(": ");
            java.util.Enumeration e2 = Worklinkman.find(teasession._strCommunity, " AND workproject=" + flobj.getWorkproject(), 0, Integer.MAX_VALUE);
            while (e2.hasMoreElements())
            {
              String member_e = ((String) e2.nextElement());
              //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
              sb.append("obj.options[obj.options.length]=new Option(\"" + member_e + "\",\"" + member_e + "\");");
            }
            sb.append("break;\r\n");
          }
          %>          </optgroup>
          <optgroup label="洽谈中的项目">
          <%

          java.util.Enumeration flmeqt = Flowitem.find(teasession._strCommunity, " and itemgenre=1  order by flowitem desc");
          while (flmeqt.hasMoreElements())
          {
            int flid = ((Integer) flmeqt.nextElement()).intValue();
            Flowitem flobj = Flowitem.find(flid);
            if (flobj.getManager().indexOf(member) != -1 || flobj.getMember().indexOf(member) != -1)
            {
              out.print("<option value=" + flid);
              if (flid == flowitem || flid==workproject_num)
              out.print(" selected ");
              out.print(" >" + flobj.getName(teasession._nLanguage));
            }
            sb.append("case ").append(flid).append(": ");
            java.util.Enumeration e2 = Worklinkman.find(teasession._strCommunity, " AND workproject=" + flobj.getWorkproject(), 0, Integer.MAX_VALUE);
            while (e2.hasMoreElements())
            {
              String member_e = ((String) e2.nextElement());
              //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
              sb.append("obj.options[obj.options.length]=new Option(\"" + member_e + "\",\"" + member_e + "\");");
            }
            sb.append("break;\r\n");
          }
          %>          </optgroup>
          <optgroup label="维护中的项目">
          <%
          java.util.Enumeration flmewh = Flowitem.find(teasession._strCommunity, " and itemgenre=3  order by flowitem desc");
          while (flmewh.hasMoreElements())
          {
            int flid = ((Integer) flmewh.nextElement()).intValue();
            Flowitem flobj = Flowitem.find(flid);
            if (flobj.getManager().indexOf(member) != -1 || flobj.getMember().indexOf(member) != -1)
            {
              out.print("<option value=" + flid);
              if (flid == flowitem || flid==workproject_num)
              out.print(" selected ");
              out.print(" >" + flobj.getName(teasession._nLanguage));
            }
            sb.append("case ").append(flid).append(": ");
            java.util.Enumeration e2 = Worklinkman.find(teasession._strCommunity, " AND workproject=" + flobj.getWorkproject(), 0, Integer.MAX_VALUE);
            while (e2.hasMoreElements())
            {
              String member_e = ((String) e2.nextElement());
              //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
              sb.append("obj.options[obj.options.length]=new Option(\"" + member_e + "\",\"" + member_e + "\");");
            }
            sb.append("break;\r\n");
          }
          %>          </optgroup>
          <optgroup label="完成的项目">
          <%

          java.util.Enumeration flme = Flowitem.find(teasession._strCommunity, " and itemgenre=4  order by flowitem desc");
          while (flme.hasMoreElements())
          {
            int flid = ((Integer) flme.nextElement()).intValue();
            Flowitem flobj = Flowitem.find(flid);
            if (flobj.getManager().indexOf(member) != -1 || flobj.getMember().indexOf(member) != -1)
            {
              out.print("<option value=" + flid);
              if (flid == flowitem || flid==workproject_num)
              out.print(" selected ");
              out.print(" >" + flobj.getName(teasession._nLanguage));
            }
            sb.append("case ").append(flid).append(": ");
            java.util.Enumeration e2 = Worklinkman.find(teasession._strCommunity, " AND workproject=" + flobj.getWorkproject(), 0, Integer.MAX_VALUE);
            while (e2.hasMoreElements())
            {
              String member_e = ((String) e2.nextElement());
              //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
              sb.append("obj.options[obj.options.length]=new Option(\"" + member_e + "\",\"" + member_e + "\");");
            }
            sb.append("break;\r\n");
          }
          %>          </optgroup>
          </select>
          <input type="button" value="..." onclick="Loadnew(form1.workproject);" >
          <!--onClick="window.showModalDialog('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height:500,width:500,left:200,top:100,scrollbars:yes,toolbar:no,status:no,menubar:no,location:no,resizable:yes');"/>
      --></td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>任务主题:</td>
      <td nowrap>
        <textarea cols=35 rows=4 name="motif"><%if(motif!=null)out.print(motif); %></textarea>
      </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>到期日期:</td>
      <td nowrap>
        <input name="attime" size="16" value="<%=Task.sdf.format(attime)%>" readonly><A href=###  onclick="javascript:showCalendar('form1.attime');"><img src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>状态:</td>
      <td nowrap>
        <select name="fettle">
        <%
        for (int i = 1; i < Task.FETTLE.length; i++)
        {
          out.print("<option value=" + i);
          if (fettle == i)
          out.print(" selected");
          out.print(">" + Task.FETTLE[i]);
          out.print("</option>");
        }
        %>
        </select>
      </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>优先级:</td>
      <td nowrap>
        <select name="pri">
        <%
        for (int ii = 1; ii < Task.PRI.length; ii++)
        {
          out.print("<option value=" + ii);
          if (pri == ii)
          out.print(" selected");
          out.print(">" + Task.PRI[ii]);
          out.print("</option>");
        }
        %>
        </select>
      </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td>发生频率：</td>
      <td>
        <select name="datefq" onchange="document.getElementById('tr_mailing').style.display=(this.value==1?'':'none');">
        <%
        for(int i = 0 ; i<Taskfrequency.Falgs.length;i++)
        {
          out.print("<option value="+i);
          if(taskobj.getDatefq()==i)
          {
            out.print(" selected");

          }
          out.print(">"+Taskfrequency.Falgs[i]);
          out.print("</option>");
        }
        %></select>
        </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tbody id="tr_mailing" style="display:none">
      <tr>
      <%
      for(int i=1 ;i<Taskfrequency.Frequencys.length;i++)
      {

        if(i==1 || i==2)
        {
          out.print("<td nowrap=nowrap>");
        }
        out.print(Taskfrequency.Frequencys[i]+"<input  type=radio name=frequency  value="+i+" onclick=hiddentr(this)");

        if(taskobj.getFrequencyid()==i)
        {
          out.print(" checked");
        }
        out.print(">");
        if(i==(Taskfrequency.Frequencys.length-1) || i==1)
        {
          out.print("</td>");
        }
      }

      %><tr>
      <td nowrap="nowrap">持续时间：</td><td><input type="radio"  name="task" value="" >结束日期：<input name="Enddatetime"  value="<%if(taskobj.getEnddatetime()!=null){out.print(taskobj.getEnddatetimeToString());}%>"  />
        <a href=### onclick="showCalendar('form1.Enddatetime');"><img  alt="" src="/tea/image/public/Calendar2.gif"   ></a><input type="radio" name="task" value="">无结束日期：</td>
      </tr>

      <tr  id="task_test0" style="display:none">
        <td nowrap>每天：</td><td nowrap>默认每天都创建的任务</td>      </tr>
        <tr  id="task_test1" style="display:none">
          <td nowrap>每周：</td>
          <%
          for(int i=0;i<Taskfrequency.WEEKS.length;i++ )
          {
            if(i==0)
            {
              out.print("<td nowrap=nowrap>");
            }
            out.print(Taskfrequency.WEEKS[i]+"<input  type=checkbox name=week"+i+" value="+i );
            String it = taskobj.getWeek();
            if(it!=null)
            {
              if(it.indexOf(""+i)!=-1)
              out.print(" checked");
            }

            out.print(" >");

            if(i==(Taskfrequency.WEEKS.length-1))
            {
              out.print("</td>");
            }

          }

          %>
          </tr >
          <tr  id="task_test2" style="display:none"><td nowrap="nowrap">每月：</td><td>
            <select name="month">
            <%
            for(int j=1 ;j<29;j++)
            {
              out.print("<option value="+j);
              if(taskobj.getMonth()==j)
              {
                out.print(" selected");
              }
              out.print(">"+j+"</option>");
            }
            %>  </select>号</td></tr>
            <tr>

            </tr>
            <tr  id="task_test3" style="display:none"><td nowrap="nowrap">日期：</td><td><input name="expressdate"  value="<%if(taskobj.getExpressdate()!=null){out.print(taskobj.getExpressdatetoString());}else{out.print(Task.sdf.format(attime));}%>" /><a href=### onclick="showCalendar('form1.expressdate');"><img  alt="" src="/tea/image/public/Calendar2.gif"   ></a></td>
      </tr>
    </tbody>
    <tr>
      <td>上传附件</td>
      <td nowrap>
        <input NAME="acceefile" TYPE=FILE class="edit_input" onclick="" size="40">
        <%
        String accessories = taobj.getAcceename();
        if (accessories != null && accessories.length() != 0)
        {
          String url = taobj.getAcceefile();
          String picType = accessories.substring(accessories.lastIndexOf("."));
          String picImg = "<img src=/tea/image/other/download.gif>";
          if (picType.equals(".jpg") || picType.equals(".gif") || picType.equals(".bmp") || picType.equals(".JPG") || picType.equals(".GIF") || picType.equals(".BMP")) {
            picImg = "<img height=20 width=20 src=" + url + ">";
          }
          %>
          <%
          if (maplen > 0)
          {
            out.println("<a href= /jsp/include/DownFile.jsp?uri=" + url + "&name=" + java.net.URLEncoder.encode(accessories, "UTF-8") + ">" + accessories + "&nbsp" + picImg + "</a>");
            %>
            &nbsp;
            <input id="CHECKBOX" type="CHECKBOX" name=ClearFile onClick="form1.acceefile.disabled=this.checked;" value=null>
            清空
            <%
            }
          }
          %>
          </td><td nowrap="nowrap"></td><td nowrap="nowrap"></td>
    </tr>
    <tr>
      <td nowrap>说明:</td>
      <td nowrap>
        <textarea cols=40 rows=6 name="remark" wrap="yes"><%if (remark != null) {out.print(remark);}%></textarea>
      </td><td nowrap="nowrap"> </td><td nowrap="nowrap"> </td>
    </tr>
  </table>
  <input type="submit" value="提交"  onclick="">
  &nbsp;&nbsp;
  <input type="button" value="返回" onclick="location='/jsp/admin/sales/task.jsp'">
</FORM>
</body>
</html>



