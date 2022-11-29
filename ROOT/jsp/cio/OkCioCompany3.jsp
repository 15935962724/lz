<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

Resource r=new Resource();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
sql.append(" and ciocompany in (select ciocompany from CioCompany where community="+DbAdapter.cite(teasession._strCommunity)+")");

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String ccname=request.getParameter("ccname");
if(ccname!=null&&ccname.length()>0)
{
  sql.append(" AND ciocompany IN (SELECT ciocompany FROM CioCompany WHERE name LIKE "+DbAdapter.cite("%"+ccname+"%")+")");
  param.append("&ccname=").append(DbAdapter.cite(ccname));
}
String cpname=request.getParameter("cpname");
if(cpname!=null&&cpname.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+cpname+"%"));
  param.append("&cpname=").append(DbAdapter.cite(cpname));
}
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}
String c_job=request.getParameter("c_job");
if(c_job!=null && c_job.length()>0)
{
  sql.append(" and job like "+DbAdapter.cite("%"+c_job+"%"));
  param.append("&c_job=").append(DbAdapter.cite(c_job));
}

String c_dept=request.getParameter("c_dept");
if(c_dept!=null && c_dept.length()>0)
{
  sql.append(" and dept like "+DbAdapter.cite("%"+c_dept+"%"));
  param.append("&c_dept=").append(DbAdapter.cite(c_dept));
}

String c_cometrain=request.getParameter("c_cometrain");
if(c_cometrain!=null&&c_cometrain.length()>0)
{
  sql.append(" AND cometrain LIKE "+DbAdapter.cite("%"+c_cometrain+"%"));
  param.append("&c_cometrain=").append(DbAdapter.cite(c_cometrain));
}

String c_backtrain=request.getParameter("c_backtrain");
if(c_backtrain!=null&&c_backtrain.length()>0)
{
  sql.append(" AND backtrain LIKE "+DbAdapter.cite("%"+c_backtrain+"%"));
  param.append("&c_backtrain=").append(DbAdapter.cite(c_backtrain));
}

String c_cioclerkid=request.getParameter("c_cioclerkid");
if(c_cioclerkid!=null&&c_cioclerkid.length()>0)
{
  sql.append(" AND cioclerkid in (select id from Cioclerk where sname like "+DbAdapter.cite("%"+c_cioclerkid+"%")+")");
  param.append("&c_cioclerkid=").append(DbAdapter.cite(c_cioclerkid));
}
String sex=request.getParameter("sex");
if(sex!=null&&sex.length()>0&&!sex.equals("2"))
{
  sql.append(" AND sex="+sex);
  param.append("&sex=").append(sex);
}

String c_talk=request.getParameter("c_talk");
if(c_talk!=null&&c_talk.length()>0&&!c_talk.equals("2"))
{
  sql.append(" AND talk="+c_talk);
  param.append("&c_talk=").append(c_talk);
}

String c_tourism=request.getParameter("c_tourism");
if(c_tourism!=null&&c_tourism.length()>0&&!c_tourism.equals("0"))
{
  sql.append(" AND tourism like "+DbAdapter.cite("%"+c_tourism+"%"));
  param.append("&c_tourism=").append(c_tourism);
}

String c_room=request.getParameter("c_room");
if(c_room!=null&&c_room.length()>0&&!c_room.equals("2"))
{
  sql.append(" AND room="+c_room);
  param.append("&c_room=").append(c_room);
}
String c_rname=request.getParameter("c_rname");
if(c_rname!=null&&c_rname.length()>0)
{
  sql.append(" AND rname LIKE "+DbAdapter.cite("%"+c_rname+"%"));
  param.append("&c_rname=").append(DbAdapter.cite(c_rname));
}

String c_rchamber=request.getParameter("c_rchamber");
if(c_rchamber!=null&&c_rchamber.length()>0)
{
  sql.append(" AND rchamber LIKE "+DbAdapter.cite("%"+c_rchamber+"%"));
  param.append("&c_rchamber=").append(DbAdapter.cite(c_rchamber));
}

String c_rstime=request.getParameter("c_rstime");
if(c_rstime!=null&&c_rstime.length()>0)
{
  sql.append(" AND datediff(day,rstime,"+DbAdapter.cite(c_rstime)+")=0");
  param.append("&c_rstime=").append(c_rstime);
}


String name = request.getParameter("name");
if(name!=null && name.length()>0)
{

}

String order=request.getParameter("order");
if(order==null)
order="name";
param.append("&order="+order);
int count = CioPart.count(teasession._strCommunity,sql.toString());
//
String desc=request.getParameter("desc");
if(desc==null)
{
  desc="asc";
}
sql.append(" ORDER BY "+order+" "+desc);

CioCustomList ccl = CioCustomList.find("pagelist");
String showlists = ccl.getShowlist();
String changelists = ccl.getChangelist();
if(showlists.length()<1)
{
  showlists=",1,2,3,4,5,";
}
if(changelists.length()<1)
{
  changelists=",d_cpame,d_sex,d_job,d_ccname,";
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  var   bShow   =   false;
  function   hideTD(str,str2)
  {
    // var charflag = str.split(",");
    var   rows   =   tablecenterleft2.tBodies[0].rows;

    for( var j=1;j<16;j++)
    {
      if(str.indexOf(","+j)==-1)
      {

        for   (var   i=0;   i   <   rows.length;   i++)
        {
          rows[i].cells[j].style.display="none";
        }
      }
    }
    var changeflag = str2.split(",");
    for( var x=1;x<changeflag.length-1;x++)
    {
      document.getElementById(changeflag[x]).style.display="";
    }
    bShow   =   !bShow;
  }

  function f_action(act,ccid)
  {
    switch(act)
    {
      case "go":
      form1.action="?";
      form1.method="get";
      break;
      case "delete":
      if(!confirm("确认删除?"))
      {
        return false;
      }
      break;
    }
    form1.ciocompany.value=ccid;
    form1.act.value=act;
    form1.submit();
  }
  </script>
  </head>
  <body onLoad="hideTD('<%=showlists%>','<%=changelists%>')">
  <!--img src="/res/cavendishgroup/u/0810/w4f123.jpg" border="0" ><map name="Map"><area shape="rect" coords="208,615,361,639" href="/jsp/cio/OkCioCompan12.jsp">
</map-->
<h1>参会人员统一管理</h1>
<div id="body_nei">
  <form name="form1" action="?" method="get" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="id" value="<%=menuid%>"/>
  <table border='0' cellpadding='0' cellspacing='0' id='table_left'>
    <div id="d_all">
      <div id="d_cpame" style="display:none"><div class="d_left">参会人员姓名：</div><div class="d_right"><input type="text" name="cpname" value="<%if(cpname!=null)out.print(cpname);%>"></div></div>
        <div id="d_sex" style="display:none"><div class="d_left">性　　别：</div><div class="d_right"><select name="sex"><option value="2" selected="selected">-----</option><option value="1" <%if("1".equals(sex))out.print(" selected ");%>>男</option><option value="0" <%if("0".equals(sex))out.print(" selected ");%>>女</option></select></div></div>
        <div id="d_job" style="display:none"><div class="d_left">职　　务：</div><div class="d_right"><input type="text" name="c_job" value="<%if(member!=null)out.print(member);%>"></div></div>
          <div id="d_ccname" style="display:none"><div class="d_left">企业集团名称：</div><div class="d_right"><input size="16" type="text" name="ccname" value="<%if(ccname!=null)out.print(ccname);%>"></div></div>
            <div id="d_dept" style="display:none"><div class="d_left">部门或子企业：</div><div class="d_right"><input type="text" name="c_dept" value="<%if(c_dept!=null)out.print(c_dept);%>"></div></div>
              <div id="d_talk" style="display:none"><div class="d_left">是否发言：</div><div class="d_right"><select name="c_talk"><option value="2" selected="selected">-----</option><option value="1" <%if("1".equals(c_talk))out.print(" selected ");%>>发言</option><option value="0" <%if("0".equals(c_talk))out.print(" selected ");%>>不发言</option></select></div></div>
              <div id="d_tourism" style="display:none"><div class="d_left">观光意向：</div><div class="d_right"><select name="c_tourism"><option value="0" selected="selected">-----</option><option value="1" <%if("1".equals(c_tourism))out.print(" selected ");%>>东部华侨城</option><option value="2" <%if("2".equals(c_tourism))out.print(" selected ");%>>大亚湾核电站</option><option value="3" <%if("3".equals(c_tourism))out.print(" selected ");%>>中兴通讯公司</option></select></div></div>
              <div id="d_room" style="display:none"><div class="d_left">是否合住：</div><div class="d_right"><select name="c_room"><option value="2" selected="selected">-----</option><option value="1" <%if("1".equals(c_room))out.print(" selected ");%>>合</option><option value="0" <%if("0".equals(c_room))out.print(" selected ");%>>单</option></select></div></div>
              <div id="d_member" style="display:none"><div class="d_left">代 表 号：</div><div class="d_right"><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></div></div>
                <div id="d_cometrain" style="display:none"><div class="d_left">到达航班/车次：</div><div class="d_right"><input type="text" name="c_cometrain" value="<%if(c_cometrain!=null)out.print(c_cometrain);%>"></div></div>
                  <div id="d_backtrain" style="display:none"><div class="d_left">返回航班/车次：</div><div class="d_right"><input type="text" name="c_backtrain" value="<%if(c_backtrain!=null)out.print(c_backtrain);%>"></div></div>
                    <div id="d_cioclerkid" style="display:none"><div class="d_left">接送人姓名：</div><div class="d_right"><input type="text" name="c_cioclerkid" value="<%if(member!=null)out.print(member);%>"></div></div>
                      <div id="d_rname" style="display:none"><div class="d_left">酒 店 名：</div><div class="d_right"><input type="text" name="c_rname" value="<%if(c_rname!=null)out.print(c_rname);%>"></div></div>
                        <div id="d_rchamber" style="display:none"><div class="d_left">房　　型：</div><div class="d_right"><input type="text" name="c_rchamber" value="<%if(c_rchamber!=null)out.print(c_rchamber);%>"></div></div>
                          <div id="d_rstime" style="display:none"><div class="d_left">入住时间：</div><div class="d_right"><input type="text" name="c_rstime" value="<%if(c_rstime!=null)out.print(c_rstime);%>" readonly="readonly" onClick="showCalendar(this)"></div></div>
                          </div>
                          <div style="margin:10px 0px;"><input  type="submit" value="模糊查询" /></div>
                          <div id="zhid"><a href="#" onClick="window.showModalDialog('/jsp/cio/CioCustomlist.jsp?listname=showlist&pagelist=pagelist','_blank','height:400;width:300;left:400,top:300;scrollbars:yes;toolbar:no;status:no;menubar:no;location:no;resizable:yes'); location.reload();">定义显示列项</a>
                            <a href="#" onClick="window.showModalDialog('/jsp/cio/CioCustomlist.jsp?listname=changelist&pagelist=pagelist','_blank','height:500;width:300;left:400;top:300;scrollbars:yes;toolbar:no;status:no;menubar:no;location:no;resizable:yes'); location.reload();"> 定义查询列项</a>
                      </div>
  </table>
  </form>
  <form action="/servlet/EditCioExcel" name="form2" method="get">
  <input type="hidden"  name="sql" value="<%=sql.toString()%>" />
  <input type="hidden"  name="act" value="OkCioCompany3" />
  <input type="hidden"  name="files" value="OkCioCompany3" />

  <style>
  #tablecenterleft2 td,#tablecenterleft2 #tableonetr td{padding:0px 5px;}
  </style>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft2" >
    <tr id='tableonetr'>
      <td nowrap id="xuhao">序号</td>
      <td nowrap id="xingm" style="">
      <%
      if("name".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >姓名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=name&"+param.toString()+" >姓名</a>");
      }
      %></td>

      <td nowrap id="xingb" style="">
      <%
      if("sex".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >性别 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=sex&"+param.toString()+" >性别</a>");
      }
      %></td>


      <td nowrap id="zhiwu">
      <%
      if("job".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >职务 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=job&"+param.toString()+" >职务</a>");
      }
      %>
      </td>
      <td nowrap id="qiye">
      <%
      if("ciocompany".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >企业（集团）名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=ciocompany&"+param.toString()+" >企业（集团）名称</a>");
      }
      %>
      </td>
      <td nowrap id="bum">
      <%
      if("dept".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >部门或子企业"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=dept&"+param.toString()+" >部门或子企业</a>");
      }
      %>
      </td>
      <td nowrap id="fayan">
      <%
      if("talk".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >是否发言"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=talk&"+param.toString()+" >是否发言</a>");
      }
      %>
      </td>
      <td nowrap id="luyou">
      <%
      if("tourism".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >观光意向"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=tourism&"+param.toString()+" >观光意向</a>");
      }
      %></td>
      <td nowrap id="zhusu">
      <%
      if("room".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >是否住宿"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=room&"+param.toString()+" >是否合住</a>");
      }
      %></td>
      <td nowrap id="daibiao">
      <%
      if("member".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >代表号"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=member&"+param.toString()+" >代表号</a>");
      }
      %>
      </td>
      <td nowrap id="checi">  <%
      if("cometrain".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >到达航班/车次"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=cometrain&"+param.toString()+" >到达航班/车次</a>");
      }
      %></td>
      <td nowrap id="fcheci"><%
      if("backtrain".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >返回航班/车次"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=backtrain&"+param.toString()+" >返回航班/车次</a>");
      }
      %></td>
      <td nowrap id="sname"><%
      if("sname".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >接送人姓名"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=sname&"+param.toString()+" >接送人姓名</a>");
      }
      %></td>
      <td nowrap id="rname"><%
      if("rname".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >酒店名"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=rname&"+param.toString()+" >酒店名</a>");
      }
      %></td>
      <td nowrap id="rchamber"><%
      if("rchamber".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >房型"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=rchamber&"+param.toString()+" >房型</a>");
      }
      %></td>
      <td nowrap id="rtime"><%
      if("rstime".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >入住时间"+("desc".equals(desc)?"▼":"▲")+"</a>");
      }
      else
      {
        out.print("<A href="+request.getRequestURI()+"?order=rstime&"+param.toString()+" >入住时间</a>");
      }
      %></td>
      <td nowrap="nowrap">查看

      </td>
    </tr>
    <%
    Enumeration e=CioPart.find(sql.toString(),0,Integer.MAX_VALUE);
    for(int i=1;e.hasMoreElements();i++)
    {
      CioPart cp=(CioPart)e.nextElement();
      CioCompany cc2=CioCompany.find(cp.getCioCompany());
      int cpid=cp.getCioPart();

      String sexy = cp.isSex()?"男":"女";
      String talks = cp.isTalk()?"发言":"不发言";
      String tourisms = cp.getTourism();
      String[] tr = tourisms.split("/");
      String tour = "";
      int itr=0;
      for(int z=1;z<tr.length;z++)
      {
        itr=Integer.parseInt(tr[z]);
        if(z!=tr.length-1){
          tour+=CioPart.TOURISM_TYPE[itr]+",";
        }else
        {
          tour+=CioPart.TOURISM_TYPE[itr];
        }
      }

      String rooms = cp.isRoom()?"合":"单";
      CioClerk cck=CioClerk.find(cp.getCioClerkid());
      out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
      out.print("<td nowrap id=xuhao>"+i+"</td>");
      out.print("<td nowrap id=xingm>");
      if(cp.getName()!=null && cp.getName().length()>0)
      {
        out.print(cp.getName());
      }
      out.print("</td>");


      out.print("<td nowrap id=xingb>"+sexy);
      out.print("</td>");
      out.print("<td nowrap id='zhiwu'>");
      if(cp.getJob()!=null && cp.getJob().length()>0)
      {
        out.print(cp.getJob());
      }
      out.print("</td>");

      out.print("<td nowrap id=qiye>");
      if(cc2.getName()!=null && cc2.getName().length()>0)
      {
        out.print(cc2.getName());
      }
      out.print("</td>");
      out.print("<td nowrap id=bum>");
      if(cp.getDept()!=null && cp.getDept().length()>0)
      {
        out.print(cp.getDept());
      }
      out.print("</td>");


      out.print("<td nowrap id=fayan>"+talks);
      out.print("<td nowrap id=luyou>"+tour);
      out.print("<td nowrap id=zhusu>"+rooms);
      out.print("<td nowrap id=daibiao>");
      if(cp.getMember()!=null && cp.getMember().length()>0)
      {
        out.print(cp.getMember());
      }
      out.print("</td>");

      out.print("<td nowrap id=checi>");
      if(cp.getComeTrain()!=null && cp.getComeTrain().length()>0)
      {
        out.print(cp.getComeTrain());
      }
      out.print("</td>");
      out.print("<td nowrap id=fcheci>");
      if(cp.getBackTrain()!=null && cp.getBackTrain().length()>0)
      {
        out.print(cp.getBackTrain());
      }
      out.print("</td>");

      out.print("<td nowrap id=sname>");
      if(cck.getSname()!=null && cck.getSname().length()>0)
      {
        out.print(cck.getSname());
      }
      out.print("</td>");
      out.print("<td nowrap id=rname>");
      if(cp.getRname()!=null && cp.getRname().length()>0)
      {
        out.print(cp.getRname());
      }
      out.print("</td>");
      out.print("<td nowrap id=rchamber>");
      if(cp.getRchamber()!=null && cp.getRchamber().length()>0)
      {
        out.print(cp.getRchamber());
      }
      out.print("</td>");

      out.print("<td nowrap id=rtime>"+cp.getRstimeToString());
      if(cp.getRstimeToString()!=null && cp.getRstimeToString().length()>0)
      {
        out.print("到");
      }
      out.print(cp.getBackRoomToString()+"</td>");
      out.print("<td nowrap ><a href=# onclick=\"window.open('/jsp/cio/CiopInfoView.jsp?ciopart="+cpid+"&ciocompany="+cp.getCioCompany()+"','_self')\" >人员及企业详细信息</a>　<a href=# onclick=window.location.href='/jsp/cio/CioUpdatePer.jsp?ciopart="+cpid+"'; >人员信息变更</a></td>");

    }
    if(count>10){
      %>
      <tr><td colspan="18" align="right" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
      <%}%>

  </table>
  <input  type="submit" value="导出EXCEL">
  </form>

  <div  id="tablebottom_002">
    <br>说明：<br>
    点击可进行指定条件排序<br>
    可自定义显示列内容及查询内容<br>
  </div>

                    </div>
  </body>
  <%@include file="/jsp/include/Calendar2.jsp" %>
</html>
