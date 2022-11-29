<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="java.sql.*" %><%@page import="java.text.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="java.io.*" %><%@page import="java.net.*" %><%@page import="tea.db.*" %><%!

private void del(File f,Writer out)throws IOException
{
  if(f.isDirectory())
  {
    out.write("<script>ps(\"正在删除 "+f+"...\");</script>");
    out.flush();
    File fs[]=f.listFiles();
    for(int i=0;i<fs.length;i++)
    {
      del(fs[i],out);
    }
  }
  f.delete();
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" rel="stylesheet" href="/tea/community.css">
<script type="text/javascript" src="/tea/tea.js"></script>
</head>
<body>
<%

if("POST".equals(request.getMethod()))
{
  String act=request.getParameter("act");
  String user="webmaster";
  String pwd=request.getParameter("pwd");
  if(!Profile.isPassword(user,pwd))
  {
    out.print("<script>alert('口令不正确');</script>");
  }else
  {
    out.print("<table id='tablecenter'><tr><td><span id='p'></span></td></tr></table><script>function ps(info){ p.innerHTML=info; }</script>");
    if("db".equals(act))
    {
      DbAdapter db=new DbAdapter();
      DbAdapter db2=new DbAdapter();
      try
      {
        boolean ex=db.getInt("SELECT COUNT(example) FROM Example")>0;//有模板
        DatabaseMetaData dm=db._con.getMetaData();
        String schema=null;
        switch(ConnectionPool._nType)
        {
          case 1:
          schema="dbo";
          break;
          case 2:
          schema=dm.getUserName();
          break;
        }
        ResultSet rs=dm.getTables(null,schema,null,new String[]{"TABLE"});
        //db.executeQuery("SELECT name FROM sysobjects WHERE xtype='U' AND name NOT IN('ip','card','spell','License','example') ORDER BY name");
        while(rs.next())
        {
          String name=rs.getString(3);
          String tc=name.toUpperCase();
          if(tc.equals("IP")||tc.equals("CARD")||tc.equals("SPELL")||tc.equals("LICENSE")||tc.equals("EXAMPLE"))
            continue;
          if(ex&&(tc.equals("SECTION")||tc.equals("LISTING")))
          {
            db2.executeUpdate("DELETE FROM "+name+" WHERE node!=0");
          }else if(ex&&(tc.equals("SECTIONLAYER")||tc.equals("LISTINGLAYER")||tc.equals("PICKFROM")||tc.equals("PICKNODE")||tc.equals("PICKNEWS")||tc.equals("PICKMANUAL")||tc.equals("LISTINGDETAIL")))
          {
            //db2.executeUpdate("DELETE FROM "+name+" WHERE node=0");
          }else
          {
            db2.executeUpdate("TRUNCATE TABLE "+name);
          }
          System.out.print(name+"\n");
          out.print("<script>ps('清空 "+name+"');</script>");
          out.flush();
        }
        rs.close();
      }finally
      {
        db.close();
        db2.close();
      }
      String newpwd=request.getParameter("newpwd");
      Profile.create(user,newpwd,"Home","webmaster@redcome.com","");
      int newid=Community.create("Home",1,0,"webmaster",1,"Home","","","","","","","","","","",false,false,false,"","","","","","","");
      Organizer.create("Home",user);
      //int newid=Node.create(0,0,"Home",new tea.entity.RV("webmaster"),0,false,0L,0,1,null,null,new Date(),1,0,0,0,null,null,1,"HOME","","","","",0,"","","","","","","");
      DNS.find("%").set("Home",0,null,newid,false,"");
    }
    else
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if("res".equals(act))
    {
      File fs[]=new File(application.getRealPath("/res/")).listFiles();
      for(int i=0;i<fs.length;i++)
      {
        String name=fs[i].getName();
        if("null".equals(name))continue;
        DbAdapter db=new DbAdapter();
        try
        {
          db.executeQuery("SELECT community FROM Community WHERE community="+DbAdapter.cite(name));
          if(!db.next())
          {
            del(fs[i],out);
          }
        }finally
        {
          db.close();
        }
      }
    }else
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if("clear".equals(act))
    {
      boolean record=request.getParameter("record")!=null;;
      int rows=0,datas=0,indexs=0,unuseds=0;
      DecimalFormat df=new DecimalFormat("#,###");
      DbAdapter db=new DbAdapter();
      DbAdapter db2=new DbAdapter();
      try
      {
        boolean flag=request.getParameter("word")!=null;
        int node=0;
        while(flag)
        {
          flag=false;
          out.print("<script>ps('清理WORD "+node+"');</script>");
          out.flush();
          db.executeQuery("SELECT node,language,content FROM NodeLayer WHERE node>"+node+" AND "+db.length("content")+">1024 ORDER BY node",0,100);
          while(db.next())
          {
            flag=true;
            node=db.getInt(1);
            int language=db.getInt(2);
            String html=db.getText(3);
            int len=html.length();
            html=html.replaceAll("<SPAN lang=EN-US><o:p></o:p></SPAN>","");
            html=html.replaceAll("<SPAN lang=EN-US>(\\d+)</SPAN>","$1");
            html=html.replaceAll("<SPAN( lang=EN-US)? style=\"mso-hansi-font-family: 宋体; mso-bidi-font-family: 宋体\">","<SPAN>");
            html=html.replaceAll("<SPAN style=\"mso-spacerun: yes\">&nbsp;&nbsp;&nbsp; </SPAN>","　　");
            //word2007
            html=html.replaceAll("<span lang=\"EN-US\"><o:p></o:p></span>","");
            if(len>html.length())
            {
              db2.executeUpdate("UPDATE NodeLayer SET content="+DbAdapter.cite(html)+" WHERE node="+node+" AND language="+language);
            }
          }
        }
        //

        //
ArrayList al=new ArrayList();
al.add("DELETE FROM Community WHERE community NOT IN (SELECT community FROM Node WHERE father=0);             ");
al.add("DELETE FROM CommunityLayer WHERE community NOT IN (SELECT community FROM Community);                            ");
al.add("DELETE FROM Node WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM Node WHERE father!=0 AND father NOT IN (SELECT node FROM Node);                         ");
al.add("DELETE FROM Node WHERE node NOT IN (SELECT node FROM NodeLayer );                         ");
al.add("DELETE FROM NodeLayer WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Subscriber WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM DNS WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM Communityinfo WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM NodeAccessManage WHERE community NOT IN (SELECT community FROM Community);                         ");

//--删除 节点不存在的 列举
al.add("DELETE FROM Listing WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM ListingLayer WHERE listing NOT IN (SELECT listing FROM Listing);                         ");
al.add("DELETE FROM PickFrom WHERE listing NOT IN (SELECT listing FROM Listing);                         ");
al.add("DELETE FROM PickNode WHERE listing NOT IN (SELECT listing FROM Listing);                         ");
al.add("DELETE FROM PickManual WHERE listing NOT IN (SELECT listing FROM Listing);                         ");
al.add("DELETE FROM listinghide WHERE node NOT IN (SELECT node FROM Node ) OR listing NOT IN (SELECT listing FROM Listing ) OR hiden=3;");
al.add("DELETE FROM ListingDetail WHERE Listing NOT IN (SELECT listing FROM Listing ) OR ( Istype=0 AND DATALENGTH(BeforeItem)=0 AND DATALENGTH(AfterItem)=0 AND Quantity=0);                         ");
al.add("DELETE FROM Listed WHERE listing NOT IN (SELECT listing FROM Listing ) OR node NOT IN (SELECT node FROM Node );                         ");

//--删除 节点不存在的 段落
al.add("DELETE FROM Section WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM SectionLayer WHERE section NOT IN (SELECT section FROM Section );                         ");
al.add("DELETE FROM sectionhide WHERE node NOT IN (SELECT node FROM Node ) OR section NOT IN (SELECT section FROM Section ) OR hiden=3;");

//--广告
al.add("DELETE FROM Aded WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM AdedLayer WHERE aded NOT IN (SELECT aded FROM Aded );                         ");
al.add("DELETE FROM Ading WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM AdingLayer WHERE ading NOT IN (SELECT ading FROM Ading );                         ");

//--CssJs
al.add("DELETE FROM CssJs WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM CssJsHide WHERE node NOT IN (SELECT node FROM Node ) OR cssjs NOT IN (SELECT cssjs FROM CssJs ) OR hiden=3;");

//--类
al.add("DELETE FROM Category WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM PageLayer WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM PollLayer WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM PollChoice WHERE poll NOT IN (SELECT id FROM PollLayer );                         ");
al.add("DELETE FROM PollResult WHERE poll NOT IN (SELECT id FROM PollLayer );                         ");
al.add("DELETE FROM stock WHERE node NOT IN (SELECT node FROM Node ) OR node IS NULL;        ");
al.add("DELETE FROM Company WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Expert WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Financing WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Goods WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Event WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Report WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Application WHERE node NOT IN (SELECT node FROM Node WHERE type=42);                         ");
al.add("DELETE FROM Picture WHERE node NOT IN (SELECT node FROM Node WHERE type=40);                         ");
al.add("DELETE FROM NewsPaper WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM NightShop WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Enterprise WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Job WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Investor WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Resume WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM LFinancing WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM LInvestor WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Perform WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Sound WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM BBS WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM BBSReply WHERE node NOT IN (SELECT node FROM BBS );                         ");
al.add("DELETE FROM Register WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM ERegister WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Gazetteer WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM EGazetteer WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Court WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Download WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM DownloadAddress WHERE node NOT IN (SELECT node FROM Download );                         ");
al.add("DELETE FROM Score WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Service WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM SOrder WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Admin WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Waiter WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Client WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Express WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Indict WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Sale WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM MessageBoard WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Contribute WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Environmental WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM GreenManufacture WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM EarthKavass WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM AmityLink WHERE node NOT IN (SELECT node FROM Node );                         ");

//--删除 节点不存在的 访问记录
al.add("DELETE FROM NodeAccess WHERE node NOT IN (SELECT node FROM Node ) OR access_time<'2005-9-30';                     ");
al.add("DELETE FROM ViewCounter WHERE node NOT IN (SELECT node FROM Node );                                         ");
//--访问量
al.add("DELETE FROM NodeAccessReferer where community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM NodeAccessWhere where community NOT IN (SELECT community FROM Community);                         ");

al.add("DELETE NodeAccessReferer WHERE ( sum=1 AND DATEDIFF(dd,time,GETDATE())>10 ) OR (sum=2 AND DATEDIFF(dd,time,GETDATE())>20 ) OR (sum=3 AND DATEDIFF(dd,time,GETDATE())>30 ) OR (sum=4 AND DATEDIFF(dd,time,GETDATE())>40 );                         ");
al.add("DELETE NodeAccessWhere WHERE (sum=1 AND DATEDIFF(dd,time,GETDATE())>10 ) OR (sum=2 AND DATEDIFF(dd,time,GETDATE())>20 ) OR (sum=3 AND DATEDIFF(dd,time,GETDATE())>30 ) OR (sum=4 AND DATEDIFF(dd,time,GETDATE())>40 );                         ");

al.add("DELETE FROM NodeAccessMonth where community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM NodeAccessHour where community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM NodeAccessDay where community NOT IN (SELECT community FROM Community);                         ");

//--其它
al.add("DELETE FROM AccessMember WHERE node NOT IN (SELECT node FROM Node );                         ");
al.add("DELETE FROM Log WHERE rmember NOT IN (SELECT member FROM Profile ) OR vmember NOT IN (SELECT member FROM Profile );                         ");
al.add("DELETE FROM ProfileLayer WHERE member NOT IN (SELECT member FROM Profile );                         ");
al.add("DELETE FROM AdminUsrRole WHERE member NOT IN (SELECT member FROM Profile );                         ");
//--后台菜单
al.add("DELETE FROM AdminFunction WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM AdminFunctionLayer WHERE adminfunction NOT IN (SELECT id FROM AdminFunction );                         ");

al.add("DELETE FROM AdminRole WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM AdminRoleFunction WHERE adminrole NOT IN (SELECT id FROM AdminRole) OR adminfunction NOT IN (SELECT id FROM AdminFunction);                         ");
al.add("DELETE FROM AdminUnit WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM AdminUsrRole WHERE member NOT IN (SELECT member FROM Profile);                         ");
//--如果部门被删除,则将些部门下的会员改为无部门.
al.add("UPDATE AdminUsrRole SET unit=0 WHERE unit!=0 AND unit NOT IN (SELECT id FROM AdminUnit);                         ");
al.add("DELETE FROM AdminZone WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM Area WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM Attribute WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM AttributeLayer WHERE attribute NOT IN (SELECT attribute FROM Attribute );                         ");
//--商品
al.add("DELETE FROM Buy WHERE node NOT IN (SELECT node FROM Node);                         ");
al.add("DELETE FROM Brand WHERE community NOT IN (SELECT community FROM Community); ");
al.add("DELETE FROM BrandLayer WHERE brand NOT IN (SELECT brand FROM Brand);                         ");
//--搜索
al.add("DELETE FROM LuceneList WHERE community NOT IN (SELECT community FROM Community);                         ");
al.add("DELETE FROM Lucene WHERE lucenelist NOT IN (SELECT lucenelist FROM LuceneList);                         ");
//--内部邮件
int del=0;
for(int i=0;i<al.size();i++)
{
  try
  {
    del+=db.executeUpdate((String)al.get(i));
  }catch(Exception ex)
  {}
  out.print("<script>ps('已清理记录数:"+del+"');</script>");
  out.flush();
}
        //
        out.print("<table id='tablecenter'><tr><td>表名</td><td align='right'>行数</td><td align='right'>数据空间KB</td><td align='right'>索引空间KB</td><td align='right'>剩余空间KB</td></tr>");
        db.executeQuery("SELECT name FROM sysobjects WHERE type='U' ORDER BY name");//AND name NOT IN('ip','card','spell','License','example')
        while(db.next())
        {
          String name=db.getString(1);
          db2.executeQuery("sp_spaceused "+name);
          if(db2.next())
          {
            name=db2.getString(1);
            int row=db2.getInt(2);
            String tmp=db2.getString(3);
            int reserved=Integer.parseInt(tmp.substring(0,tmp.length()-3));
            tmp=db2.getString(4);
            int data=Integer.parseInt(tmp.substring(0,tmp.length()-3));
            tmp=db2.getString(5);
            int index_size=Integer.parseInt(tmp.substring(0,tmp.length()-3));
            tmp=db2.getString(6);
            int unused=Integer.parseInt(tmp.substring(0,tmp.length()-3));
            if(row<1)
            {
              if(record)
              {
                db2.executeUpdate("DROP TABLE "+name);
              }else
              {
                db2.executeUpdate("TRUNCATE TABLE "+name);
              }
            }else
            {
              out.print("<tr><td>"+name);
              out.print("<td align='right'>"+df.format(row));
              //out.print("<td align='right'>"+reserved);
              out.print("<td align='right'>"+df.format(data));
              out.print("<td align='right'>"+df.format(index_size));
              out.print("<td align='right'>"+df.format(unused));
            }
            rows+=row;
            datas+=data;
            indexs+=index_size;
            unuseds+=unused;
          }
        }
      }finally
      {
        db.close();
        db2.close();
      }
      out.print("<tr><td>");
      out.print("<td align='right'>"+df.format(rows));
      //out.print("<td align='right'>");
      out.print("<td align='right'>"+df.format(datas));
      out.print("<td align='right'>"+df.format(indexs));
      out.print("<td align='right'>"+df.format(unuseds));
      out.print("</table>");
    }
    out.print("<script>ps('OK');</script>");
    return;
  }
}
%>

<h1>EDN数据清理</h1>
<form name="form1" action="?" method="post" onSubmit="returm submitEqual(this.newpwd,this.cnp,'两次密码不相同.')">
<input type="hidden" name="act" value="db"/>
<table id="tablecenter">
  <tr>
    <td nowrap>本系统超级管理员密码:</td>
    <td><input type="password" name="pwd" /></td>
    <td rowspan="3">此功能旨在：把所有EDN数据表中的数据全部清空，然后在用户表中创建一个webmaster，社区表中创建一个默认HOME社区，此功能只能在新安装的EDN上使用，清空后将得到一个空的EDN数据库，再进行全新网站的搭建。</td>
  </tr>
  <tr>
    <td nowrap>初始化后密码重设为:</td>
    <td><input type="password" name="newpwd" /></td>
    </tr>
  <tr>
    <td>确认密码:</td>
    <td><input type="password" name="cnp" /></td>
    </tr>
</table>
<input type="submit" value="提交" />
</form>


<h1>清理没有社区的RES目录</h1>
<form name="form2" action="?" method="post" >
<input type="hidden" name="act" value="res"/>
<table id="tablecenter">
  <tr>
    <td nowrap>本系统超级管理员密码:</td>
    <td><input type="password" name="pwd" /></td>
    <td>此功能旨在：把没有社区的RES资源文件清理掉，以方便使用中的系统备份，当不再使用的社区被删除后可使用此功能清理掉该社区的相关文件，以减少系统空间占用。</td>
  </tr>
</table>
<input type="submit" value="提交" />
</form>




<h1>删除无关链数据</h1>
<form name="form3" action="?" method="post" >
<input type="hidden" name="act" value="clear"/>
<table id="tablecenter">
  <tr>
    <td nowrap>本系统超级管理员密码:</td>
    <td><input type="password" name="pwd" /></td>
    <td rowspan="2">此功能旨在：清理数据库中没有关联的数据，比如没有社区的节点信息，没有上级节点的子节点信息等，当一个社区手工删除后，一个栏目手工删除后，为了清理库中没有删除的相应子节点，可以使用该功能。下面的清理word标签 ，是指查询库中所有节点内容，并把其中的WORD标签清除，删除没有记录的表，是指把没有任何记录的表清理掉，这个功能不只有程序员用，他人勿用。</td>
  </tr>
  <tr>
    <td nowrap>选项:</td>
    <td nowrap>
      <input type="checkbox" name="word" />清理Word标签
      <input type="checkbox" name="record" />删除没有记录的表    </td>
    </tr>
</table>
<input type="submit" value="提交" />
注:连"中心机库"不能使用此功能...
</form>


</body>
</html>
