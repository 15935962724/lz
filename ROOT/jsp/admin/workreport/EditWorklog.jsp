<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@include file="/jsp/Header.jsp"%>
<%
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  Http h=new Http(request);

  String community = teasession._strCommunity;
  Resource r = new Resource("/tea/resource/Workreport");
  int worklog = 0;
  if (request.getParameter("worklog") != null)
  {
    worklog = Integer.parseInt(request.getParameter("worklog"));
  }
  int workproject = 0, worktype = 0, status = 0, wearhours = -1, wearminutes = -1;
  boolean publicity = false;
  boolean sumupreport = false; //是否是总结
  boolean problemreport = false; //问题反馈
  String content = null, time = null, worklinkman = null, tomember = null, path = null, accessories = null;
  java.util.Date time_obj;
  int len = 0;
  if (worklog > 0)
  {
    Worklog obj = Worklog.find(worklog);
    workproject = obj.getWorkproject();
    worklinkman = obj.getWorklinkman();
    worktype = obj.getWorktype();
    publicity = obj.isPublicity();
    sumupreport = obj.isSumupreport(); //取得boolean值
    problemreport = obj.isProblemreport(); //是否是问题
    time = obj.getTimeToString();
    time_obj = obj.getTime();
    content = obj.getContent(teasession._nLanguage);
    status = obj.getStates();
    tomember = obj.getToMember();
    accessories = obj.getAccessories();
    path = obj.getPath();
    wearhours = obj.getWearHours();
    wearminutes = obj.getWearMinutes();
    if (path != null)
    {
      java.io.File f = new java.io.File(application.getRealPath(path));
      len = (int) f.length();
    }
  }else
  {
    time_obj = new java.util.Date();
    time = Worklog.sdf.format(time_obj);
    AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, teasession._rv._strV);
    if(aur.getUnit()!=0)//////当前会员的 上级会员/////
    {
	    StringBuffer inbox = new StringBuffer();
	    java.util.Enumeration e = AdminUsrRole.find(teasession._strCommunity, " AND classes LIKE " + DbAdapter.cite("%/"+aur.getUnit()+"/%") + " AND member!=" + h.member, 0, Integer.MAX_VALUE);
	    while (e.hasMoreElements())
	    {
	      tomember = (String) e.nextElement();
	      inbox.append(tomember).append(";");
	    }
	    tomember = inbox.toString();
    }
  }

  java.util.Calendar c = java.util.Calendar.getInstance();
  c.setTime(time_obj);
  int hour = c.get(c.HOUR_OF_DAY);
  int mm = c.get(c.MINUTE);

  String nexturl = request.getParameter("nexturl");
  if (nexturl == null)
  {
    nexturl = request.getRequestURI() + "?" + request.getQueryString();
  }


int workproject_num=0;
if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
{
  workproject_num= Integer.parseInt(teasession.getParameter("workproject"));
}

%>
<%
        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();//最近填写的项目
        StringBuffer sb22 = new StringBuffer();//最近填写的项目
        String member = teasession._rv.toString();//登录的用户ID
        java.util.Enumeration flmejc = Flowitem.findzuijin(teasession._strCommunity, " AND type = 0",teasession._rv.toString());
        while(flmejc.hasMoreElements())
        {
          int flid = ((Integer) flmejc.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
            sb2.append("<option value=" + flid);
            sb22.append("<option value=" + flid);
            if (flid == workproject || flid==workproject_num)
            sb2.append(" selected ");
            sb2.append(" >" + flobj.getName(teasession._nLanguage));
            sb22.append(" >" + flobj.getName(teasession._nLanguage));
          }
          sb.append("case ").append(flid).append(": ");

          java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
          while(e2.hasMoreElements())
          {
            String member_e=((String)e2.nextElement());
            //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
            sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
          }
          sb.append("break;\r\n");
        }
%>
<%
StringBuffer sb3 = new StringBuffer();//进行中的项目
StringBuffer sb33 = new StringBuffer();//进行中的项目
java.util.Enumeration flmejx = Flowitem.find(teasession._strCommunity, "  AND type = 0 and itemgenre=2 order by flowitem desc");
        while (flmejx.hasMoreElements())
        {
          int flid = ((Integer) flmejx.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          sb3.append("<option value=" + flid);
	          sb33.append("<option value=" + flid);
	                  if (flid == workproject || flid==workproject_num)
	            sb3.append(" selected ");
	          sb3.append(" >" + flobj.getName(teasession._nLanguage));
	          sb33.append(" >" + flobj.getName(teasession._nLanguage));
	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
%>
<%
StringBuffer sb4 = new StringBuffer();//洽谈中的项目
StringBuffer sb44 = new StringBuffer();//洽谈中的项目
        java.util.Enumeration flmeqt = Flowitem.find(teasession._strCommunity, "  AND type = 0 and itemgenre=1 order by flowitem desc");
        while (flmeqt.hasMoreElements())
        {
          int flid = ((Integer) flmeqt.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          sb4.append("<option value=" + flid);
	          sb44.append("<option value=" + flid);

	                  if (flid == workproject || flid==workproject_num)
	            sb4.append(" selected ");
	          sb4.append(" >" + flobj.getName(teasession._nLanguage));
	          sb44.append(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
%>
<%
StringBuffer sb5 = new StringBuffer();//维护中的项目
StringBuffer sb55 = new StringBuffer();//维护中的项目
        java.util.Enumeration flmewh = Flowitem.find(teasession._strCommunity, "   AND type = 0 and itemgenre=3 order by flowitem desc");
        while (flmewh.hasMoreElements())
        {
          int flid = ((Integer) flmewh.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          sb5.append("<option value=" + flid);
	          sb55.append("<option value=" + flid);

	                 if (flid == workproject || flid==workproject_num)
	            sb5.append(" selected ");
	          sb5.append(" >" + flobj.getName(teasession._nLanguage));
	          sb55.append(" >" + flobj.getName(teasession._nLanguage));

	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity," AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
%>
<%

StringBuffer sb6 = new StringBuffer();//完成中的项目
StringBuffer sb66 = new StringBuffer();//完成中的项目
        java.util.Enumeration flme = Flowitem.find(teasession._strCommunity, "   AND type = 0 and itemgenre=4  order by flowitem desc");
        while (flme.hasMoreElements())
        {
          int flid = ((Integer) flme.nextElement()).intValue();
          Flowitem flobj = Flowitem.find(flid);
          if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
          {
	          sb6.append("<option value=" + flid);
	          sb66.append("<option value=" + flid);
	      if (flid == workproject || flid==workproject_num)
	            sb6.append(" selected ");
	          sb6.append(" >" + flobj.getName(teasession._nLanguage));
	          sb66.append(" >" + flobj.getName(teasession._nLanguage));
	 	  }
          sb.append("case ").append(flid).append(": ");

             java.util.Enumeration e2=Worklinkman.find(teasession._strCommunity,"  AND workproject="+flobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(e2.hasMoreElements())
             {
               String member_e=((String)e2.nextElement());
               //Worklinkman worklinkman_obj=Worklinkman.find(teasession._strCommunity,member_e);
               sb.append("obj.options[obj.options.length]=new Option(\""+member_e+"\",\""+member_e+"\");");
             }
             sb.append("break;\r\n");
        }
%>
<%
StringBuffer sb7 = new StringBuffer();//工作类型
StringBuffer sb77 = new StringBuffer();
        java.util.Enumeration e3 = Worktype.find(teasession._strCommunity, "", 0, Integer.MAX_VALUE);
        while (e3.hasMoreElements()) {
          int id = ((Integer) e3.nextElement()).intValue();
          Worktype obj = Worktype.find(id);
          sb7.append("<option value=" + id);
          sb77.append("<option value=" + id);
          if (id == worktype)
          sb7.append(" SELECTED ");
          sb7.append(" >" + obj.getName(teasession._nLanguage));
          sb77.append(" >" + obj.getName(teasession._nLanguage));
        }
%>
<%
StringBuffer sb8 = new StringBuffer();//状态
        for (int i = 0; i < Worklog.STATES_TYPE.length; i++) {
          sb8.append("<option value=" + i);
          if (i == status)
          sb8.append(" SELECTED ");
          sb8.append(" >" + r.getString(teasession._nLanguage, Worklog.STATES_TYPE[i]));
        }
%>
<%
StringBuffer sb9 = new StringBuffer();//小时
StringBuffer sb99 = new StringBuffer();
        for (int i = 0; i < 23; i++) {
          sb9.append("<option value=" + i);
          sb99.append("<option value=" + i);
          if (i == wearhours)
            sb9.append(" SELECTED ");
          sb9.append(" >" + i);
          sb99.append(" >" + i);
        }
%>
<%
StringBuffer sb10 = new StringBuffer();//分
StringBuffer sb1010 = new StringBuffer();
        for (int i = 0; i < 60; i++) {
          sb10.append("<option value=" + i);
          sb1010.append("<option value=" + i);
          if (i == wearminutes)
            sb10.append(" SELECTED ");
          sb10.append(" >" + i);
          sb1010.append(" >" + i);
        }
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript"">
var i=2;
function addmod(){
	$("#addtr").append(""+
	"<tr id='tr"+i+"'><td><table id='tab1'><tr>"+
    "<td class='td1' nowrap><%=r.getString(teasession._nLanguage,"1168584443703")%>"+
    "</td>"+
    "<td class='td2'>"+
      "<input type=hidden name='worklog"+i+"' value='0'/><select name='workproject"+i+"' alt='客户及项目' id='workproject"+i+"' onChange='fchange(this.value,"+i+");'>"+
        "<option value=''>---------</option>"+
        "<optgroup label='最近填写的项目'>"+
          "<%=sb22.toString() %>"+
        "</optgroup>"+
        "<optgroup label='进行中的项目'>"+
         " <%=sb33.toString() %>"+
       " </optgroup>"+
        "<optgroup label='洽谈中的项目'>"+
         " <%=sb44.toString() %>"+
        "</optgroup>"+
        "<optgroup label='维护中的项目'>"+
          "<%=sb55.toString() %>"+
       " </optgroup>"+
       " <optgroup label='完成的项目'>"+
         " <%=sb66.toString() %>"+
       " </optgroup>"+
      "</select>"+
     "<input type='button' value='...' onclick=mt.show('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&inpname="+i+"',2,'选择项目',500,500) >"+
   " </td>"+
 " </tr>"+
  "<tr>"+
    "<td nowrap><%=r.getString(teasession._nLanguage,"1168584403266")%>"+
    "</td>"+
    "<td class='td2'>"+
      "<select id='worklinkman"+i+"' name='worklinkman"+i+"'></select>"+
    "</td>"+
  "</tr>"+
  "<tr>"+
   " <td nowrap><%=r.getString(teasession._nLanguage,"1168592903313")%>    </td>"+
   " <td class='td2'>"+
      "<select name='worktype"+i+"'>"+
       " <option value='0'>-------------</option><%=sb77.toString() %>"+

      "</select>"+
   " </td>"+
  "</tr>"+
  "<tr>"+
    "<td nowrap><%=r.getString(teasession._nLanguage,"1173241008125")%>      <!-- 状态  -->"+
    "</td>"+
    "<td class='td2'>"+
      "<select name='states"+i+"'><%=sb8.toString() %>"+

      "</select>"+
    "</td>"+
 " </tr>"+
  "<tr>"+
    "<td nowrap><%=r.getString(teasession._nLanguage,"Attachment")%>      <!--附件 -->"+
    "</td>"+
    "<td class='td2'>"+
      "<input type='file' name='accessories"+i+"'>"+

     " &nbsp;"+
      "<input id='CHECKBOX' type='CHECKBOX' name=ClearFile onClick='form1.accessories"+i+".disabled=this.checked;' value=null>清空"+
    "</td>"+
 " </tr>"+
 "<tr>"+
    "<td class='td2' nowrap><%=r.getString(teasession._nLanguage,"Options")%></td>"+
    "<td class='td2'>"+
"<input name='publicity"+i+"' type='checkbox'  id='publicity'><label for='publicity'><%=r.getString(teasession._nLanguage,"1168595223953")%></label>"+
"<input name='sumupreport"+i+"' type='checkbox'  id='sumupreport'><label for='sumupreport'><%=r.getString(teasession._nLanguage,"总结报告") %></label>"+
"<input name='problemreport"+i+"' type='checkbox'  id='problemreport'><label for='problemreport'><%=r.getString(teasession._nLanguage,"问题反馈") %></label>"+
"<input name='tomember_check"+i+"' type='checkbox' onClick=f_tomember("+i+"); id='tomember_check"+i+"'><label for='tomember_check'><%=r.getString(teasession._nLanguage,"MsgOSendEmail")%></label>"+
"<input type='text' name='tomember"+i+"' id='tomember"+i+"' value='<%if(tomember!=null)out.print(tomember);%>' style='display:none'/>"+
"<input name='tomember_button' id='tomember_button"+i+"' type='button' value='...' onClick=LoadWindow('form1.tomember"+i+"',1); style='display:none'/>"+
    "</td>"+
 " </tr>"+
  "<tr>"+
    "<td nowrap><%=r.getString(teasession._nLanguage,"Text")%><!--内容--></td>"+
    "<td class='td2'>"+
      "<textarea name='content"+i+"' alt='内容' rows='8' cols='70'></textarea>"+
    "</td>"+
 " </tr>"+
 "<tr>"+
    "<td class='td2' nowrap><%=r.getString(teasession._nLanguage,"耗时") %>    </td>"+
    "<td class='td2'>"+
      "<select name='wearhours"+i+"' >"+
      "<option value=''>-----<%=sb99.toString()%></select>"+
      "<%=r.getString(teasession._nLanguage,"小时") %>&nbsp;"+
      "<select name='wearminutes"+i+"' >"+
      "<option value=''>-----<%=sb1010.toString()%></select>"+
"<%=r.getString(teasession._nLanguage,"分钟" ) %></td>"+
  "</tr></table></td><td class='td3'><a class='datt' href='###' onclick=deltr('"+i+"')>删除</a><td></tr>");
	$("#worklinkman"+i).html('<option>-------------</option>');
  i++;

}
function deltr(index,id){

		$("#tr"+index).remove();
		if(id!=undefined){
			form1.cids.value=form1.cids.value+""+id+"|";
		}
}
mt.receive=function(h,n){
	$("#workproject"+n).val(h);
	fchange(h,n);
}
function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=linkmen&workproject="+value,function(data){
	  $("#worklinkman"+b).html(data.trim());
  });
}
function f_load()
{
  form1.time.focus();
  //form1.workproject.value=getCookie('tea.workproject','');
  //fchange(form1.workproject.value);
  //form1.worktype.value=getCookie('tea.worktype','0');
  f_tomember('1');
  if($("#workproject1").val()){
	  fchange($("#workproject1").val(),1);
  }

}

function LoadWindow(obj,type)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
  if(window.Event)
  {
    window.open("/jsp/sms/psmanagement/FrameGU.jsp?index="+obj+"&field=member&type="+type,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
  }else
  {
    window.showModalDialog("/jsp/sms/psmanagement/FrameGU.jsp?index="+obj+"&field=member&type="+type,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
  }
}
function f_tomember(a)
{
	var tv = $("#tomember_check"+a).attr('checked')?"":"none";
  	$("#tomember_button"+a).css("display",tv);
	$("#tomember"+a).css("display",tv);

}
</script>
</head>
<body onLoad="f_load();">
  <!--工作记录管理-->
<h1><%=r.getString(teasession._nLanguage,"1168593689875")%></h1>
<div id="head6">
  <img height="6" src="about:blank">
</div>
<br>
  <!-- target="dialog_frame" -->
<form enctype="multipart/form-data" name="form1" METHOD="post" target="_ajax" action="/servlet/EditWorkreport" onSubmit="return mt.check(this)">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="worklog1" value="<%=worklog%>"/>
<input type=hidden name="nexturl" value="/jsp/admin/workreport/Worklogs.jsp"/>
<input type=hidden name="action" value="editworklog"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Time")%></td>
    <td>

        <input id="time" name="time" size="7"  value="<%if(time!=null)out.print(time);%>"  style="cursor:pointer" readonly onClick="new Calendar().show('form1.time');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time');" />

      <select name="hour">
      <%
        for (int i = 0; i < 24; i++) {
          out.print("<option value=" + i);
          if (i == hour)
            out.print(" SELECTED ");
          out.print(" >" + i);
        }
      %>
      </select>
      <select name="minute">
      <%
        for (int i = 0; i < 60; i++) {
          out.print("<option value=" + i);
          if (i == mm)
            out.print(" SELECTED ");
          out.print(" >" + i);
        }
      %>
      </select>
      &nbsp;&nbsp;&nbsp;<input type="button" onClick="addmod()" value="添加项目" class="butt">
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1168584443703")%><!--  客户或项目-->
    </td>
    <td>
      <select id="workproject1" name="workproject1" alt="客户或项目" onChange="fchange(this.value,1);">
        <option value="">---------</option>
        <optgroup label="最近填写的项目">
          <%=sb2.toString() %>
        </optgroup>
        <optgroup label="进行中的项目">
          <%=sb3.toString() %>
        </optgroup>
        <optgroup label="洽谈中的项目">
          <%=sb4.toString() %>
        </optgroup>
        <optgroup label="维护中的项目">
          <%=sb5.toString() %>
        </optgroup>
        <optgroup label="完成的项目">
          <%=sb6.toString() %>
        </optgroup>
      </select>
     <input type="button" value="..." onClick="mt.show('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&inpname=1',2,'选择项目',500,500);" >
     <!--  <input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=0&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>','_self');">-->
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1168584403266")%>      <!-- 联系人 -->
    </td>
    <td>
      <select name="worklinkman1" id="worklinkman1">
        <option value="">-------------</option>
      </select>
		<script>
           <%
           if(worklinkman!=null)
           {
             out.print("form1.worklinkman1.value=\""+worklinkman+"\";");
           }
           %>
           </script>
      <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Worklinkmans_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.worklinkman1&workproject='+form1.workproject1.value,'','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1168592903313")%>    </td>
    <td>
      <select name="worktype1">
        <option value="0">-------------</option>
        <%=sb7.toString() %>
      </select>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1173241008125")%>      <!-- 状态  -->
    </td>
    <td>
      <select name="states1">
        <%=sb8.toString() %>
      </select>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Attachment")%>      <!--附件 -->
    </td>
    <td>
      <input type="file" name="accessories1">
    <%
      if (len > 0)
        out.print(len + r.getString(teasession._nLanguage, "Bytes") + "<a href=/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(path, "UTF-8") + "&name=" + java.net.URLEncoder.encode(accessories, "UTF-8") + "> " + accessories + "</a>");
    %>
      &nbsp;
      <input id="CHECKBOX" type="CHECKBOX" name=ClearFile1 onClick="form1.accessories1.disabled=this.checked;" value=null>清空
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Options")%></td>
    <td>
<input name="publicity1" type="checkbox" <%if(publicity)out.print("checked");%> id="publicity"><label for="publicity"><%=r.getString(teasession._nLanguage,"1168595223953")%></label>
<input name="sumupreport1" type="checkbox" <%if(sumupreport)out.print("checked");%> id="sumupreport"><label for="sumupreport"><%=r.getString(teasession._nLanguage,"总结报告") %></label>
<input name="problemreport1" type="checkbox" <%if(problemreport)out.print("checked");%> id="problemreport"><label for="problemreport"><%=r.getString(teasession._nLanguage,"问题反馈") %></label>
<input name="tomember_check1" type="checkbox" onClick="f_tomember(1);" id="tomember_check1"><label for="tomember_check"><%=r.getString(teasession._nLanguage,"MsgOSendEmail")%></label>
<input type="text" name="tomember1" id="tomember1" value="<%if(tomember!=null)out.print(tomember);%>" style="display:none"/>
<input name="tomember_button" id="tomember_button1" type="button" value="..." onClick="LoadWindow('form1.tomember1',1);" style="display:none"/>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Text")%><!--内容--></td>
    <td>
      <textarea name="content1" alt="内容" rows="8" cols="70"><%if(content!= null)out.print(content);%></textarea>
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"耗时") %>    </td>
    <td>
      <select name="wearhours1" >
      <option value="">-----
      <%=sb9.toString()%>
      </select>
      <%=r.getString(teasession._nLanguage,"小时") %>&nbsp;
      <select name="wearminutes1">
      <option value="">-----
      <%=sb10.toString()%>
      </select>
<%=r.getString(teasession._nLanguage,"分钟") %></td>
  </tr>
  <tr>
  <td colspan="2" class="tdp0"><table id="addtr"></table></td>
   </tr>
</table>
<div class="tj">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" onClick="setCookie('tea.workproject',form1.workproject.value); setCookie('tea.worktype',form1.worktype.value);">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="<%if(nexturl.startsWith("javascript:"))out.print(nexturl);else out.print("history.back();");%>">
</div>
</form>
<br>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
