<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@page import ="tea.entity.admin.*" %>
<%@page import ="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");

%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%!
public String cellToString(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    str=null;
  }
  return str;
}
public java.util.Date cellToDate(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    str=null;
  }
  java.util.Date d=null;
  try
  {
    d=Entity.sdf2.parse(str);
  }catch(Exception ex)
  {
    try
    {
      d=Entity.sdf.parse(str);
    }catch(Exception ex2)
    {
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
      try
      {
        d=sdf.parse(str);
      }catch(Exception ex3)
      {
        sdf = new java.text.SimpleDateFormat("MM/dd/yyyy");
        try
        {
          d=sdf.parse(str);
        }catch(Exception ex4)
        {

        }
      }
    }
  }
  return d;
}
%>
<%
StringBuffer sp = new StringBuffer();
byte by[]=teasession.getBytesParameter("file");
if(by!=null)
{
  ByteArrayInputStream bais=new ByteArrayInputStream(by);
  try
  {
    Workbook wb=Workbook.getWorkbook(bais);
    Sheet s=wb.getSheet(0);
    if(teasession.getParameter("import")!=null)
    {
      out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span>");
      out.flush();
      if("jituanyonghu".equals(act))//导入集团用户
      {
        for(int i=1;i<s.getRows();i++)
        {

          String member=null; //用户名
          String paw=null; //密码
          String membername=null; //姓名
          String sheng=null; //
          String shi=null; //
          String jibie=null; //
          String times=null; //个人照片地址

          for(int j=0;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 0://姓名
              member=cellToString(s.getCell(j,i));
              break;
              case 1://性别
              paw=cellToString(s.getCell(j,i));
              break;
              case 2://身份证
              membername=cellToString(s.getCell(j,i));
              break;
              case 3://身份证号
              sheng=cellToString(s.getCell(j,i));
              break;
              case 4://出生年月
              shi=cellToString(s.getCell(j,i));
              break;
              case 5://照片名称
              jibie=cellToString(s.getCell(j,i));
              break;
              case 6://照片地址
              times=cellToString(s.getCell(j,i));
              break;
            }

          }
          //省
          int shengint = 0;
          if(sheng!=null && sheng.length()>0)
          {
            java.util.Enumeration e = Provinces.find(" AND type= 0");
            while(e.hasMoreElements())
            {
              int pid =((Integer)e.nextElement()).intValue();
              Provinces pobj = Provinces.find(pid);
              if(pobj.getProvincity().equals(sheng))
              {
                shengint = pid;
              }
            }
          }
           int shiint = 0;
           if(shi!=null && shi.length()>0)
           {
             java.util.Enumeration e = Provinces.find(" AND type!= 0");
             while(e.hasMoreElements())
             {
               int pid =((Integer)e.nextElement()).intValue();
               Provinces pobj = Provinces.find(pid);
               if(pobj.getProvincity().equals(shi))
               {
                 shiint = pid;
               }
             }
           }


          String times2=null;
          if(times!=null && times.length()>0)
          {
            times2 = times.replaceAll("/","-");
          }
           System.out.println(member);
           //继续写

           int jibie_s = 0;
           if(jibie.equals("1"))
           {
             jibie_s= 366;
           }
           if(jibie.equals("2"))
           {
             jibie_s= 367;
           }

           if(jibie.equals("3"))
           {
             jibie_s= 368;
           }

           if(Doctoradmin.isProfile("orthonline",member))//如果添加的用户在用户表中有
           {
             Profile pobj = Profile.find(member);
             int sex= 0;
             if(pobj.isSex())
             {
               sex=1;
             }
             pobj.set(member,"jibie_s",paw,pobj.getMobile(),sex,pobj.getCard(),pobj.getCardType(),membername,pobj.getEmail(),teasession._nLanguage,null);
           }else{
             Profile.create(member,teasession._nLanguage,null,paw,null,membername,0,"orthonline",0,null,0);
           }
            AdminUsrRole.create("orthonline",member,"/" + jibie_s + "/",null,0,null,null);
         Doctoradmin.create(member,jibie_s,shengint,shiint,0,"orthonline");

          if(i%5==0)
          {
            out.print("<script>c.innerHTML="+(i+1)+"</script>");
            out.flush();
          }

        }
      }
//        FileWriter fw = new FileWriter("c:/十三局member.txt",true);
//            fw.write(sp.toString());
//            fw.close();
      out.print("<script>window.open('/jsp/info/Succeed.jsp?nexturl='+encodeURIComponent(\""+nexturl+"\"),'_parent');</script>");
    }else
    {
      out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");

                    for(int i=0;i<s.getRows()&&i<21;i++)
                    {
                      out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
                      for(int j=0;j<s.getColumns();j++)
                      {
                        String str=s.getCell(j,i).getContents();
                        out.print("<td>"+("null".equals(str)?"&nbsp;":str));
                      }
                      out.print("</tr>");
                      if(i==20)
                      {
                        out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
                      }
                    }
                    out.print("</table>");
                  }
                  wb.close();
                }catch(Exception ex)
                {
                  out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
                  out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
                  out.print("<tr><td>1.文件格式错误</td></tr>");
                  out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
                  out.print("<tr><td>&nbsp;</td></tr>");
                  out.print("<tr><td>描述:</td></tr>");
                  out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
                  out.print("</table>");
                  ex.printStackTrace();
                  //		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
                  return;
                }finally
                {
                  bais.close();
                }
              }
              %>

</body>
</HTML>

