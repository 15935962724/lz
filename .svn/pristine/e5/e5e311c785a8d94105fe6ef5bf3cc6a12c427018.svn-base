<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");


String nexturl = teasession.getParameter("nexturl");

int tid = Integer.parseInt(teasession.getParameter("tid"));
Tactics tobj = Tactics.find(tid);


%>
<html>
<head>
<title>查看策略信息</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >


<h1>查看策略信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name=form1 method=POST action="/servlet/EditSubscribe" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "策略名称")%>:</td>
    <td><%=tobj.getTacname() %></td>
  </tr>
<%


	String str_HTML = "";
	Enumeration e = ReadRight.find(" and node ="+teasession._nNode+" and father ="+tid+"  and type ="+DbAdapter.cite("Tactics"),0,Integer.MAX_VALUE);
	while(e.hasMoreElements())
	{
		int rrid = ((Integer)e.nextElement()).intValue();
		
		ReadRight rrobj = ReadRight.find(rrid);
		int rnum = rrobj.getRnum();

		 str_HTML+="<tr id= SignItem"+rnum+">";
		 str_HTML+="<td>&nbsp;</td>";
		 str_HTML+="<td>";
		
		 str_HTML += "<table>";
		str_HTML += "<tr>";
		   str_HTML += "<td align=\"right\" nowrap>版面：</td>";
		  str_HTML += "<td><input type=checkbox  name=suoyou_"+rnum+" value=0 id=suoyou_"+rnum+" onclick=f_suoyou('"+rnum+"'); ";
		
		  if(rrobj.getSuoyou()==0)
		  {
			  str_HTML +="  checked=true ";
		   } 
		  str_HTML +=" disabled=\"disabled\" style=border:0px;background:#ccc;";
		  str_HTML += " nowrap>&nbsp;所有版面</td><td></td>";
		str_HTML += "</tr>";
	
	////////--------------隐藏的版面信息---------------////////////////
		str_HTML += "<tr id=sybanci_"+rnum+"   ";
		if(rrobj.getSuoyou()==0)
		{
			str_HTML +=" style=display:none ";
		}
	  
		str_HTML += ">";
			str_HTML += "<td>&nbsp;</td>";
			str_HTML += "<td style=word-break:break-all;>";
			if(rrobj.getSuoyou()==1){
				ReadRight rrobj_2 = ReadRight.find(ReadRight.getRRid(teasession._nNode,tid,"Tactics",rnum));
				
				//Enumeration e = Pageinform.find(teasession._strCommunity," and node = "+teasession._nNode,0,Integer.MAX_VALUE);
				int pfid = Pageinform.getPfid(teasession._nNode,teasession._strCommunity);
				Pageinform pfobj = Pageinform.find(pfid);
				StringBuffer sb = new StringBuffer();
				for(int i =1;i<=pfobj.getPagenumber();i++)
				{ 
					
					String pname = "";
					if(i<=9)
					{
						pname=String.valueOf("0")+i;
					}else
					{
						pname= String.valueOf(i);
					}
					sb.append("<span style=word-break:keep-all;white-space:nowrap;><input type=checkbox name=banci_"+rnum+" id = banci_"+rnum+" value=");
					sb.append(i);
					if(rrobj.getBanci()!=null && rrobj_2.getBanci().length()>0&& rrobj_2.getBanci().indexOf("/"+String.valueOf(i)+"/")!=-1)
					{
						sb.append(" checked = true ");
					}
					sb.append("  disabled=\"disabled\" style=border:0px;background:#ccc; >"+pname+"&nbsp;&nbsp;</span>");
				}
			
				
				
					str_HTML += sb.toString();
			}
			str_HTML += "</td>"; 
		str_HTML += "</tr>";
		
	 ////////--------------//显示期次范围---------------////////////////
		str_HTML += "<tr>";
	   str_HTML += "<td align=right nowrap>期次范围：</td>";
	  str_HTML += "<td>";
	  /* 
		  str_HTML += "<select name=qici_fanwei_"+rnum+"  id=qici_fanwei_"+rnum+" onchange=f_qici_fanwei('"+rnum+"');>";

		  for(int j = 1;j<ReadRight.FANWEI_TYPE.length;j++)
			{
			  str_HTML += "<option value="+j;
				if(rrobj.getQici_fanwei()==j)
				{
					 str_HTML += " selected ";
				}
				 str_HTML += ">"+ReadRight.FANWEI_TYPE[j];
				 str_HTML += "</option>";
			}
		  
		  str_HTML += "</select>";
		 */ 
		  
		  str_HTML += "<span id=span_1_qc_time_"+rnum+"";
		  if(rrobj.getQici_fanwei()==2)
		  {
			  str_HTML +=" style=display:none ";
		  }
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text name=qc_timec_"+rnum+" id=qc_timec_"+rnum+"  size=7  disabled=\"disabled\" value=";
			  if(rrobj.getQc_timec()!=null)
			  {
				  str_HTML += rrobj.getQc_timecToString();
			  }
			  
			  str_HTML +=">";
			  
			  str_HTML += "<img style=margin-bottom:-8px; disabled=\"disabled\" style=cursor:pointer  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timec_"+rnum+"');\" />";
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_timed_"+rnum+" id=qc_timed_"+rnum+"  size=7  disabled=\"disabled\" value=";
			  if(rrobj.getQc_timed()!=null)
			  {
				  str_HTML += rrobj.getQc_timedToString();
			  }
			  
			  str_HTML +=">";
			  
			  
			  str_HTML += "<img style=margin-bottom:-8px; disabled=\"disabled\" style=cursor:pointer  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timed_"+rnum+"');\" />";
		  str_HTML += "</span>";
				
		  str_HTML += "<span id=span_2_qc_time_"+rnum+" ";
		  if(rrobj.getQici_fanwei()==1 || rrobj.getQici_fanwei()==0)
		  {
			  str_HTML +="style=display:none";
		  } 
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text  name=qc_2_timec_"+rnum+" id=qc_2_timec_"+rnum+"  size=7  value=";
			  if(rrobj.getQc_2_timec()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timec();
			  }
			  str_HTML +=">";
			  
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_2_timed_"+rnum+" id=qc_2_timed_"+rnum+"  size=7  value=";
			  if(rrobj.getQc_2_timed()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timed();
			  }
			  str_HTML +=">";
		  str_HTML += "</span>";
		  
		  str_HTML += "&nbsp;&nbsp;&nbsp;&nbsp;";
		  str_HTML += "<input type=\"checkbox\" name=\"qici_suoyou_"+rnum+"\" id=\"qici_suoyou_"+rnum+"\" value=\"1\"  onclick=\"f_qici_suoyou("+rnum+");\"" ;
		  if(rrobj.getQici_suoyou()==1)
		  {
			  str_HTML += " checked=checked ";
		  } 
		  str_HTML += "  disabled=\"disabled\" style=border:0px;background:#ccc;  >&nbsp;&nbsp;所有期次";
		  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
	
	////////--------------//显示阅读有效期---------------////////////////
	
	
	
		str_HTML += "<tr>";
	   str_HTML += "<td align=right nowrap>阅读有效期：</td>";
	  str_HTML += "<td>";
	/*
		  str_HTML += "<select name=yuedu_yxqi_"+rnum+"  id=yuedu_yxqi_"+rnum+" onchange=f_yuedu_yxqi("+rnum+");>";
		  for(int j2 =1;j2<ReadRight.FANWEI_TYPE.length;j2++)
			{
			  str_HTML += "<option value="+j2;
				if(rrobj.getYuedu_yxqi()==j2)
				{
					 str_HTML += " selected ";
				}
				 str_HTML += ">"+ReadRight.FANWEI_TYPE[j2];
				 str_HTML += "</option>";
			}
		str_HTML += "</select>";		
		 */
		 
		str_HTML += "<span id=span_1_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==2 )
		{
			str_HTML +=" style=display:none";
		}
		str_HTML +=">";
		
			str_HTML += "<input type=text name=yd_timec_"+rnum+" id=yd_timec_"+rnum+"  size=7  disabled=\"disabled\" value=";
			if(rrobj.getYd_timec()!=null)
			{
				str_HTML += rrobj.getYd_timecToString(); 
			}
			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; disabled=\"disabled\" style=cursor:pointer  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timec_"+rnum+"');\" />";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_timed_"+rnum+" id=yd_timed_"+rnum+"  size=7  disabled=\"disabled\" value=";
			if(rrobj.getYd_timed()!=null)
			{
				str_HTML += rrobj.getYd_timedToString(); 
			}
			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; disabled=\"disabled\" style=cursor:pointer  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timed_"+rnum+"');\" />";
		str_HTML += "</span>";
	
		str_HTML += "<span id=span_2_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==1 || rrobj.getYuedu_yxqi()==0)
		{
			str_HTML += " style=display:none";
		}
		str_HTML +=">";
			str_HTML += "<input type=text name=yd_2_timec_"+rnum+" id=yd_2_timec_"+rnum+"  size=7  value=";
			if(rrobj.getYd_2_timec()!=null)
			{
				str_HTML +=rrobj.getYd_2_timec();
				
			}
			str_HTML += ">";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_2_timed_"+rnum+" id=yd_2_timed_"+rnum+"  size=7 value=";
			if(rrobj.getYd_2_timed()!=null)
			{
				str_HTML +=rrobj.getYd_2_timed();
			}
			str_HTML += ">";
		str_HTML += "</span>"; 
		//设为永久
		  
		  str_HTML += "&nbsp;&nbsp;&nbsp;&nbsp;";
		  str_HTML += "<input type=\"checkbox\" name=\"yd_sheweiyoujiu_"+rnum+"\" id=\"yd_sheweiyoujiu_"+rnum+"\" value=\"1\"  onclick=\"f_yd_sheweiyoujiu("+rnum+");\"" ;
		  if(rrobj.getYd_sheweiyoujiu()==1)
		  {
			  str_HTML += " checked=checked ";
		  } 
		  str_HTML += "  disabled=\"disabled\" style=border:0px;background:#ccc;  >&nbsp;&nbsp;设为永久";
	  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
		
	 
		 str_HTML += "</table>"; 
		 
		 str_HTML +="</td>";
		 str_HTML +="</tr>";
	} 
	out.print(str_HTML);
	
	

%>


<tr>

  
   <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "生效条件")%>:</td>
    <td><%=Tactics.CONDITION_TYPE[tobj.getCondition()] %>&nbsp;<%if(tobj.getCondition()==1 && tobj.getMembertype()>0){out.print("会员类型:&nbsp;"+tea.entity.admin.mov.MemberType.find(tobj.getMembertype()).getMembername());} %></td>
  </tr>

  <tr>
  	<td align=right nowrap>生效IP范围:</td>
  	<td><%=tobj.getIp() %></td>
  </tr>
  <tr>
  	<td align="right" nowrap>公布状态:</td>
  	<td><%if(tobj.getPublish()==1){out.print(Tactics.PUBLISH_TYPE[tobj.getPublish()]);}else if(tobj.getPublish()==0){out.print("<font color=Red>"+Tactics.PUBLISH_TYPE[tobj.getPublish()]+"</font>");}%></td>
  </tr>
   
  <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "备注说明")%>:</td>
    <td><%=tobj.getRemarks() %></td>
  </tr>
  
    <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "创建人")%>:</td>
    <td><%=tobj.getCreatemember() %></td>
  </tr>
    <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "创建时间")%>:</td>
    <td><%=tobj.getCreatetimeToString() %></td>
  </tr>
    <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "公布人")%>:</td>
    <td><%=tobj.getPublishmember() %></td>
  </tr>
    <tr>
    <td align="right" nowrap><%=r.getString(teasession._nLanguage, "公布时间")%>:</td>
    <td><%=tobj.getPublishtimeToString() %></td>
  </tr>
  
</table>

<br> 
<input type=button value="返回" onClick="javascript:history.back()">
</body>
</html>
