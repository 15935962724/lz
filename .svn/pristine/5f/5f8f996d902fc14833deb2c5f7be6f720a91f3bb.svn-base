<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.site.*" %><%
org.tempuri.SSOServiceTestCase stc=new org.tempuri.SSOServiceTestCase("");

String userID=request.getParameter("UserID").toLowerCase();
String userOrderID=request.getParameter("UserOrderID");
String OUdn=request.getParameter("OUdn");
String OUID=request.getParameter("OUID");
String token=request.getParameter("Token");


//String value=stc.test1SSOServiceSoapSSOLogin("testCRM1","testCRM1","tongshen.com");
//out.println(value);

String value=stc.test3SSOServiceSoapValidToken(token,"");
if("0".equals(value))
{
  session.setAttribute("tea.RV", new tea.entity.RV(userID,OUdn));
  response.sendRedirect("/jsp/admin/Frame.jsp?node=1");
}else
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("验证失败:"+value,"UTF-8"));
}
//http://127.0.0.1/jsp/user/Login.jsp?UserID=ADMIN&UserOrderID=12&OUdn=tongshen.com&OUID=10&Token=*******


//同步企业信息
String result[]=null;
do
{
  System.out.println("已存在:"+Nethdou.getLast());
  value=stc.test4SSOServiceSoapSyncInfo("NETHD",Nethdou.getLast(),2,"");
  System.out.println(value);
  if(value.length()>0)
  {
    if(value.startsWith("-1#"))
    {
      System.out.println("出错");
    }else
    {
      result=value.split("&");
      for(int index=0;index<result.length;index++)
      {
        String field []=result[index].split("#");
        System.out.println("标志:"+field[6]);
        try
        {
          Nethdou obj=Nethdou.find(field[1]);
          if(!obj.isExists())//("+".equals(field[5]))
          {
            Nethdou.create(Integer.parseInt(field[0]),field[1],Integer.parseInt(field[2]),field[3],field[4],field[5],field.length==8?field[7]:null);
          }else
          {
            if("-".equals(field[6]))
            {
              obj.delete();
            }else
            //if("M".equals(field[6]))
            {
              obj.set(Integer.parseInt(field[0]),Integer.parseInt(field[2]),field[3],field[4],field[5],field.length==8?field[7]:null);
            }
          }
        }catch(Exception e)
        {
          e.printStackTrace();
        }
      }
    }
  }
}while(result!=null&&result.length==10);


//同步会员信息
result=null;
do
{//
java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
System.out.println("最后一次更新:"+Nethduser.getLast());
value=stc.test4SSOServiceSoapSyncInfo("NETHD",Nethduser.getLast(),1,"");


//value="TESTCRM1#14#tongshen.com###testCRM1######GD##020-98765433#M#1947-6-16 0:00:00###2006-5-9 15:47:21#-$USER01#19#tongshen.com#广州市#440100#张三###00004#13309876789#zhansan@test.com#GZ#会计#020-98767896#M#1992-4-4 0:00:00#普通#无#2006-5-15 9:57:09#+$USER02#20#tongshen.com#广州市#440100#王五###00005#13898766432#wangwu@test.com#GZ#出纳#020-87365522#M#1983-6-6 0:00:00#普通#无#2006-5-15 10:11:40#+";

System.out.println(value);
if(value.length()>0)
{
  value=new String(value.getBytes("UTF-8"),"ISO-8859-1");
  if(value.startsWith("-1#"))
  {
    System.out.println("出错");
  }else
  {
    result=value.split("&");
    for(int index=0;index<result.length;index++)
    {
      String field []=result[index].split("#");
      try
      {
        field[1]=field[1].toLowerCase();
        field[3]=field[3].toLowerCase();
        String member=field[1]+"."+field[3];
        if(!Profile.isExisted(field[1],field[3]))//"+".equals(field[19])||
        {
          Profile p=Profile.create(field[1],field[3],String.valueOf(System.currentTimeMillis()));
          p.setAge("M".equals(field[15])?1:0);
          p.setFirstName(field[7],1);
          p.setLastName(field[8],1);
          p.setMobile(field[10]);
          p.setEmail(field[11],1);
          p.setAddress(field[12],1);
          p.setTelephone(field[14],1);

          if(field[16].length()>0)
          try
          {
            p.setBirth(sdf.parse(field[16]),1);
          }catch(java.text.ParseException e)
          {
            e.printStackTrace();
          }

          if(field[20].length()>0)
          try
          {
            p.setTime(sdf.parse(field[20]));
          }catch(java.text.ParseException e)
          {
            e.printStackTrace();
          }
          else
          p.setTime(new java.util.Date());

//          Subscriber.create("Home",new tea.entity.RV(field[1],field[3]));

          //      Profile.create(field[0],"","M".equals(field[14])?1:0,0,1,field[6],field[7],field[10],"",field[11],"","","","",field[13],"","",field[9]);
          Nethduser.create(Integer.parseInt(field[0]),(field[1]),field[2],field[3],field[4],field[5],field[6],field[9],field[13],field[17],field[18],field[19],field.length==23?field[22]:null);
        }else
        {
          Nethduser obj=Nethduser.find(field[2]);
          if("-".equals(field[21]))
          {
            obj.delete();
          }else
          //          if("M".equals(field[5]))
          {
            Profile p=Profile.find(field[1],field[3]);
            p.setAge("M".equals(field[15])?1:0);
            p.setFirstName(field[7],1);
            p.setLastName(field[8],1);
            p.setMobile(field[10]);
            p.setEmail(field[11],1);
            p.setAddress(field[12],1);
            p.setTelephone(field[14],1);

            if(field[16].length()>0)
            try
            {
              p.setBirth(sdf.parse(field[16]),1);
            }catch(java.text.ParseException e)
            {
              e.printStackTrace();
            }

            if(field[20].length()>0)
            try
            {
              p.setTime(sdf.parse(field[20]));
            }catch(java.text.ParseException e)
            {
              e.printStackTrace();
            }
            else
            p.setTime(new java.util.Date());

            obj.set(Integer.parseInt(field[0]),(field[1]),field[3],field[4],field[5],field[6],field[9],field[13],field[17],field[18],field[19],field.length==23?field[22]:null);
          }
        }
      }catch(Exception e)
      {
        e.printStackTrace();
      }
    }
  }
}
System.out.println("result!=null&&result.length==10: \t"+(result!=null&&result.length==10));
}while(result!=null&&result.length==10);


%>

