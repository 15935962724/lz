<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
DbAdapter db=new DbAdapter();
String time=null;/*交费时间*/
String timey=null;/*权限截止时间*/
float money=0;/*交费金额*/
StringBuffer sql=new StringBuffer();
if(AdminUsrRole.isMemeber(teasession._rv._strR,"22")){/*AdminUsrRole.isMemeber(teasession._rv._strR,"22")方法是判断用户是不是供应商*/
  sql.append("select max(times) from auditingmember where role=22 and member=").append(db.cite(teasession._rv._strR));
  try{db.executeQuery(sql.toString());
  if(db.next()){
    time=db.getString(1).toString();
  }
  sql=new StringBuffer();
  sql.append("select moneys ,timey from auditingmember where role=22 and  member=").append(db.cite(teasession._rv._strR));
  db.executeQuery(sql.toString());
  if(db.next()){
    money=db.getFloat(1);
    timey=db.getString(2);
  }
}finally{
      db.close();
  }

}
if(time!=null){
  time=time.substring(0,10);
  timey=timey.substring(0,10);
  out.println("<p>您上次的交费时间为"+time+"</span>所交金额为"+money+"元");
  out.println("<p>您的权将限截止至"+timey);
  }
%>
