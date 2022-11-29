<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
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

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("community="+community);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));


int workproject=0;
String _strWorkproject=request.getParameter("workproject");


if(_strWorkproject!=null&&_strWorkproject.length()>0)
{
  workproject=Integer.parseInt(_strWorkproject);
  sql.append(" AND workproject=").append(workproject);
  param.append("&workproject=").append(workproject);
}

String worklinkman=request.getParameter("worklinkman");
if(worklinkman!=null&&worklinkman.length()>0)
{
  sql.append(" AND worklinkman=").append(DbAdapter.cite(worklinkman));
  param.append("&worklinkman=").append(worklinkman);
}

int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
  sql.append(" AND worktype=").append(worktype);
  param.append("&worktype=").append(worktype);
}


DbAdapter db = new DbAdapter();
try {

  String time_s=request.getParameter("time_s");
  if(time_s!=null&&(time_s=time_s.trim()).length()>0)
  {
    try
    {
      java.util.Date time=Worklog.sdf.parse(time_s);
      sql.append(" AND time >=").append(db.cite(time));
      param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }
  String time_e=request.getParameter("time_e");
  if(time_e!=null&&(time_e=time_e.trim()).length()>0)
  {
    try
    {
      java.util.Date time=Worklog.sdf.parse(time_e);
      sql.append(" AND time <").append(db.cite(time));
      param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }
}
catch (Exception ex) {
  ex.printStackTrace();
}
finally{
  db.close();
}
String content=request.getParameter("content");
if(content!=null&&(content=content.trim()).length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}

String member = null;
sql.append(" and workproject="+workproject);

if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
{
  member = teasession.getParameter("member");
  sql.append(" and  member=").append(DbAdapter.cite(member));
  param.append("&member=").append(member);
}



int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Worklog.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);
sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
            <script type="">
            function fload()
            {
              var tr_today=document.all('tr_today');
              if(tr_today==null)
              {
                //document.getElementById('tr_today_select').style.display='none';
              }else
              {
                if(!tr_today.length)
                {
                  tr_today.parentElement.moveRow(tr_today.rowIndex,1);
                }else
                {
                  for(var i=0;i<tr_today.length;i++)
                  {
                    var obj=tr_today[i];
                    obj.parentElement.moveRow(obj.rowIndex,1);
                  }
                }
              }
            }
            function submitCheck()
            {
              if(form2.worklog.checked)
              return true;
              for(var i=0;i<form2.worklog.length;i++)
              {
                if(form2.worklog[i].checked)
                return true;
              }
              alert('无效选择');
              return false;
            }
            </script>
            </head>
            <body onload="fload();">
            <form name=form2 METHOD=get action="/jsp/admin/workreport/SendWorklog.jsp" >
              <input type=hidden name="community" value="<%=community%>"/>
              <input type=hidden name="nexturl" value="<%=nexturl%>"/>
              <input type=hidden name="action" value="exportworklogs"/>


              <h2>工作日志<%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--><input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorklog.jsp?community=<%=community%>&worklog=0&workproject=<%=workproject%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','VWproject2');"></h2>
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr id="tableonetr">
                  <!--td nowrap width="1"></td-->
                  <td nowrap><%out.print(r.getString(teasession._nLanguage,"时间/填写人"));%></td><!--时间-->
                  <td nowrap><%out.print(r.getString(teasession._nLanguage,"Text"));%></td><!--内容-->
                </tr>
                <%
                StringBuffer html=new StringBuffer();
                // String date_cu=Worklog.sdf.format(new java.util.Date());
                //    java.util.Enumeration enumer= Worklog.findByWorkproject(pos,20,workproject);
                java.util.Enumeration enumer= Worklog.find(teasession._strCommunity,sql.toString(),pos,20);
                if(enumer.hasMoreElements()){
                  for(int index=1;enumer.hasMoreElements();index++)
                  {
                    int worklog=((Integer)enumer.nextElement()).intValue();
                    Worklog obj=Worklog.find(worklog);
                    html.append("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
                     //html.append("<td nowrap>&nbsp;"+index+"</td>");
                    html.append("<td nowrap>"+obj.getTimeToString()+"<br>"+ obj.getMember() +"</td>");

                    html.append("<td>");
                    String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
                    if(log_content.length()>25){
                      html.append(log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));//&#39;
                      if(obj.getRevertmember()!=null){
                        Profile pro1 = Profile.find(obj.getRevertmember());
                      html.append("/"+pro1.getName(teasession._nLanguage));}
                      String accessories = obj.getAccessories();
                      //System.out.println("195 w_5 : "+accessories+" : "+accessories.length());
                      if(accessories!=null&&accessories.length()!=0)
                      {
                        String url = obj.getPath();
                        accessories.indexOf(".");
                        if(accessories.indexOf(".")!=-1)
                        {
                          String picType = accessories.substring(accessories.lastIndexOf("."));
                          String picImg = "<img src=/tea/image/other/download.gif>";
                          if(picType.equals(".jpg")||picType.equals(".gif")||picType.equals(".bmp")||picType.equals(".JPG")||picType.equals(".GIF")||picType.equals(".BMP"))
                          {
                            picImg="<img height=20 width=20 src="+url+">";
                             html.append("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a>");
                          }
                          else
                          {
                             html.append("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"</a>");
                          }
                        }
                        else
                        {
                          html.append("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"</a>");
                        }
                        //int width  = 0 ; int height = 0 ;

                        //  javax.swing.ImageIcon imageicom = new javax.swing.ImageIcon("C:\\Documents and Settings\\Administrator\\My Documents\\My Pictures\\images.jpg");
                        //  width = imageicom.getIconWidth() ; height = imageicom .getIconHeight() ;

                       //
                        //System.out.println("<hr><a href= /jsp/include/DownFile.jsp?uri="+ url +"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a>");
                      }
                    }
                    else
                    html.append(log_content);
                    html.append(" <input type=button value="+r.getString(teasession._nLanguage,"回馈")+" onClick=\"window.open('/jsp/admin/workreport/Worklogs_7revert.jsp?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&worklog="+worklog+"','_blank');\"></td></tr>");
                    html.append("</td></tr>");

                  }
                  out.print(html.toString());
                }
                else{
//                  out.print("<font color=red>暂无记录</font>");
                  out.print("<tr><td colspan=10 align=center><font color=red>暂无记录</font></td></tr>");
                }
                %>
                <%if(count>20){%>
                <tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,20)%></td></tr>
                <%}%>
              </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<%--   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
            </body>
</html>


