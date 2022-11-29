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


int sid = 0;
if(teasession.getParameter("sid")!=null && teasession.getParameter("sid").length()>0)
{
	sid  = Integer.parseInt(teasession.getParameter("sid"));
}

Subscribe sobj = Subscribe.find(sid);




%>
<html>
<head>
<title>查看套餐</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >


<h1>查看套餐</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name=form1 method=POST action="/servlet/EditSubscribe" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "套餐名称")%>:</td>
    <td><%if(sobj.getSubject()!=null)out.print(sobj.getSubject()); %></td>
  </tr>
<%
	String str_HTML = "";
	Enumeration e = ReadRight.find(" and node ="+sobj.getNode()+" and father ="+sid+"  and type ="+DbAdapter.cite("Subscribe"),0,Integer.MAX_VALUE);
	while(e.hasMoreElements())
	{
		int rrid = ((Integer)e.nextElement()).intValue();
		
		ReadRight rrobj = ReadRight.find(rrid);
		int rnum = rrobj.getRnum();

	
		
		 str_HTML+="<tr id= SignItem"+rnum+">";
			if(rnum==1)
			{
				 str_HTML+="<td align=\"right\">阅读权限:</td>";
			}else
			{
				str_HTML+="<td>&nbsp;</td>";
			}
		
		 str_HTML+="<td>";
		
		 str_HTML += "<table>";
		str_HTML += "<tr>";
		   str_HTML += "<td align=\"right\">版面："+rnum+"</td>";
		  str_HTML += "<td><input type=checkbox  name=suoyou_"+rnum+" value=0 id=suoyou_"+rnum+" onclick=f_suoyou('"+rnum+"'); ";
		
		  if(rrobj.getSuoyou()==0)
		  {
			  str_HTML +="  checked=true ";
		   }
		  str_HTML +=" disabled=\"disabled\" style=border:0px;background:#ccc;";
		  str_HTML += ">&nbsp;所有版面</td>";
		str_HTML += "</tr>";
	
	////////--------------隐藏的版面信息---------------////////////////
		str_HTML += "<tr id=sybanci_"+rnum+"   ";
		if(rrobj.getSuoyou()==0)
		{
			str_HTML +=" style=display:none ";
		}
	  
		str_HTML += ">";
			str_HTML += "<td>&nbsp;</td>";
			str_HTML += "<td>";
			if(rrobj.getSuoyou()==1){
				ReadRight rrobj_2 = ReadRight.find(ReadRight.getRRid(sobj.getNode(),sid,"Subscribe",rnum));
				
				//Enumeration e = Pageinform.find(teasession._strCommunity," and node = "+teasession._nNode,0,Integer.MAX_VALUE);
				int pfid = Pageinform.getPfid(sobj.getNode(),teasession._strCommunity);
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
					sb.append("<input type=checkbox name=banci_"+rnum+" id = banci_"+rnum+" value=");
					sb.append(i);
					if(rrobj.getBanci()!=null && rrobj_2.getBanci().length()>0&& rrobj_2.getBanci().indexOf("/"+String.valueOf(i)+"/")!=-1)
					{
						sb.append(" checked = true ");
					}
					sb.append("  disabled=\"disabled\" style=border:0px;background:#ccc; >"+pname+"&nbsp;&nbsp;");
				}
			
				
				
					str_HTML += sb.toString();
			}
			str_HTML += "</td>"; 
		str_HTML += "</tr>";
		
	 ////////--------------//显示期次范围---------------////////////////
		str_HTML += "<tr>";
	   str_HTML += "<td align=right>期次范围：</td>";
	  str_HTML += "<td>";
	  
		  str_HTML += "<select name=qici_fanwei_"+rnum+"  id=qici_fanwei_"+rnum+" disabled=\"disabled\" >";

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
		  
		  
		  str_HTML += "<span id=span_1_qc_time_"+rnum+"";
		  if(rrobj.getQici_fanwei()==2)
		  {
			  str_HTML +=" style=display:none ";
		  }
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text name=qc_timec_"+rnum+" id=qc_timec_"+rnum+" disabled=\"disabled\"  size=7   value=";
			  if(rrobj.getQc_timec()!=null)
			  {
				  str_HTML += rrobj.getQc_timecToString();
			  }
			 if(rrobj.getQici_suoyou()==1)
			 {
				 out.print(" disabled=true ");
			 }
			  
			  str_HTML +=">";
			  
			  str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer id=qc_img_timec_"+rnum+" disabled=\"disabled\"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timec_"+rnum+"');\"" ;
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
			  
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_timed_"+rnum+" id=qc_timed_"+rnum+"  size=7  disabled=\"disabled\"  value=";
			  if(rrobj.getQc_timed()!=null)
			  {
				  str_HTML += rrobj.getQc_timedToString();
			  }
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
			  
			  
			  str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer id=qc_img_timed_"+rnum+" disabled=\"disabled\"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timed_"+rnum+"');\" ";
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
		  str_HTML += "</span>";
				
		  
		  str_HTML += "<span id=span_2_qc_time_"+rnum+" ";
		  if(rrobj.getQici_fanwei()==1 || rrobj.getQici_fanwei()==0)
		  {
			  str_HTML +="style=display:none";
		  } 
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text  name=qc_2_timec_"+rnum+" id=qc_2_timec_"+rnum+" disabled=\"disabled\"   size=7  value=";
			  if(rrobj.getQc_2_timec()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timec();
			  }
			  str_HTML +=">";
			  
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_2_timed_"+rnum+" id=qc_2_timed_"+rnum+" disabled=\"disabled\"   size=7  value=";
			  if(rrobj.getQc_2_timed()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timed();
			  }
			  str_HTML +=">";
		  str_HTML += "</span>";
		
		  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
	
	////////--------------//显示阅读有效期---------------////////////////
	
	
	
		str_HTML += "<tr>";
	   str_HTML += "<td align=right>阅读有效期：</td>";
	  str_HTML += "<td>";
	
		  str_HTML += "<select name=yuedu_yxqi_"+rnum+" disabled=\"disabled\"   id=yuedu_yxqi_"+rnum+" onchange=f_yuedu_yxqi("+rnum+");>";
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
		 
		 
		str_HTML += "<span id=span_1_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==2 )
		{
			str_HTML +=" style=display:none";
		}
		str_HTML +=">";
		
			str_HTML += "<input type=text name=yd_timec_"+rnum+" id=yd_timec_"+rnum+"  size=7  disabled=\"disabled\"   value=";
			if(rrobj.getYd_timec()!=null)
			{
				str_HTML += rrobj.getYd_timecToString(); 
			}
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 

			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer disabled=\"disabled\"   id=\"yd_img_timec_"+rnum+"\"  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timec_"+rnum+"');\" ";
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			str_HTML += ">";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_timed_"+rnum+" id=yd_timed_"+rnum+"  size=7  disabled=\"disabled\"   value=";
			if(rrobj.getYd_timed()!=null)
			{
				str_HTML += rrobj.getYd_timedToString(); 
			}
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			
			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer disabled=\"disabled\"   id=\"yd_img_timed_"+rnum+"\"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timed_"+rnum+"');\" ";
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			str_HTML += ">"; 
		str_HTML += "</span>";
	
		str_HTML += "<span id=span_2_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==1 || rrobj.getYuedu_yxqi()==0)
		{
			str_HTML += " style=display:none";
		}
		str_HTML +=">";
			str_HTML += "<input type=text name=yd_2_timec_"+rnum+" id=yd_2_timec_"+rnum+" disabled=\"disabled\"   size=7  value=";
			if(rrobj.getYd_2_timec()!=null)
			{
				str_HTML +=rrobj.getYd_2_timec();
				
			}
			str_HTML += ">";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_2_timed_"+rnum+" id=yd_2_timed_"+rnum+" disabled=\"disabled\"   size=7 value=";
			if(rrobj.getYd_2_timed()!=null)
			{
				str_HTML +=rrobj.getYd_2_timed();
			}
			str_HTML += ">";
		str_HTML += "</span>"; 
	
		
	  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
		
	 
		 str_HTML += "</table>"; 
		 
		 str_HTML +="</td>";
		 str_HTML +="</tr>";
	} 
	out.print(str_HTML);

%>
   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "绑定会员类型")%>:</td>
    <td><%  
    tea.entity.admin.mov.MemberType  myobj = tea.entity.admin.mov.MemberType.find(sobj.getMembertype());
    out.print(myobj.getMembername());
    %>&nbsp;</td> 
  </tr>


   <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "人民币价格")%>:</td>
    <td><%=sobj.getMarketprice() %>&nbsp;元</td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "美元价格")%>:</td>
    <td><%=sobj.getPromotionsprice() %>&nbsp;元</td>
  </tr>

   
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "备注说明")%>:</td>
    <td><%=sobj.getRemarks() %></td>
  </tr>
  
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "创建人")%>:</td>
    <td><%=sobj.getCreatemember() %></td>
  </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "创建时间")%>:</td>
    <td><%=sobj.getCreatetimeToString() %></td>
  </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "公布人")%>:</td>
    <td><%=sobj.getPublishmember() %></td>
  </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "公布时间")%>:</td>
    <td><%=sobj.getPublishtimeToString() %></td>
  </tr>
  
</table>

<br> 
<input type=button value="返回" onClick="javascript:history.back()">
</body>
</html>
