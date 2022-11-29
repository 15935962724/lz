<%@page contentType="text/html;charset=utf-8"%>
<%!

public void insert_class(int paren,int node_paren) throws java.lang.Exception
{
  java.sql.Connection conn=java.sql.DriverManager.getConnection("jdbc:odbc:mdb");
  java.sql.Statement statement=conn.createStatement();
  java.sql.ResultSet rs=statement.executeQuery("SELECT ClassID,ClassName,Child,OrderID FROM PE_Class WHERE ParentID="+paren);
  while(rs.next())
  {
    int classid=rs.getInt(1);
    String classname=rs.getString(2);
    int child=rs.getInt(3);
    int orderid=rs.getInt(4);

    String community="cvs";
    int newnode=tea.entity.node.Node.create(node_paren,orderid,community,new tea.entity.RV("webmaster",community),child==0?1:0,0,false,1325400128L,0,1,null,null,1,classname,"","",null,"",0,null,"","","","",null,new java.util.Date(),0,0,0,0,"","");
    tea.db.DbAdapter db=new tea.db.DbAdapter();
    try
    {
      db.executeUpdate("UPDATE Node SET id="+classid+",finished=1 WHERE node="+newnode);
    }finally
    {
      db.close();
    }
    if(child==0)
    {
      tea.entity.node.Category c=tea.entity.node.Category.find(newnode);
      c.set(39,0,0);
    }
    System.out.println(classid+":"+newnode);
    insert_class(classid,newnode);
  }
  rs.close();
  statement.close();
  conn.close();
}

%>
<%
/*
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//insert_class(0,43322);/////插入分类

//插入文章
  java.sql.Connection conn=java.sql.DriverManager.getConnection("jdbc:odbc:mdb");
  java.sql.Statement statement=conn.createStatement();
  java.sql.ResultSet rs=statement.executeQuery("SELECT ArticleID,ClassID,Title,Author,Keyword,Hits,UpdateTime,DATALENGTH(Content),Content FROM PE_Article WHERE ArticleID>1202");
  while(rs.next())
  {
    System.out.println("开始读access...articleid");
    int articleid=rs.getInt(1);
    System.out.println("开始读access...classid");
    int classid=rs.getInt(2);
    System.out.println("开始读access..title");
    String title=rs.getString(3);
    System.out.println("开始读access...author");
    String author=rs.getString(4);
    System.out.println("开始读access...keyword");
    String keyword=rs.getString(5).replaceAll("[|]"," ");
    System.out.println("开始H读access...hits");
    int hits=rs.getInt(6);
    System.out.println("开始读access...updatetime");
    java.util.Date updatetime=new java.util.Date(rs.getTimestamp(7).getTime());
    System.out.println("开始读access...content");
    int content=rs.getInt(8);
    System.out.println("获得对应的父亲节点..."+content);

    int node_paren;
    tea.db.DbAdapter db=new tea.db.DbAdapter();
    try
    {
      node_paren= db.getInt("SELECT node FROM Node WHERE id="+classid);
    }finally
    {
      db.close();
    }
    System.out.println("开始创建节点..."+node_paren);
    String community="csv";
    int newnode=tea.entity.node.Node.create(node_paren,0,community,new tea.entity.RV("webmaster",community),39,0,false,1325400128L,0,1,null,null,1,title,keyword,content,null,"",0,null,"","","","",null,updatetime,0,0,0,0,"","");
    System.out.println("开始写入对应的_AID..."+articleid);
    db=new tea.db.DbAdapter();
    try
    {
      db.executeUpdate("UPDATE Node SET id="+articleid+",finished=1,click="+hits+" WHERE node="+newnode);
    }finally
    {
      db.close();
    }
    System.out.println("开始创建新闻..."+newnode);
    tea.entity.node.Report.create(newnode,10,687,0,"","","",author,"",updatetime);
    System.out.println(articleid+":"+newnode+"=======================================");

  }
  rs.close();
  statement.close();
  conn.close();
*/

//修改图片
int count=0;
System.out.println("[InstallDir_ChannelDir]UploadFiles/");
tea.db.DbAdapter db=new tea.db.DbAdapter();
tea.db.DbAdapter db2=new tea.db.DbAdapter();
db.executeQuery("SELECT nl.node,nl.language,nl.content FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.id IS NOT NULL AND n.type=39");
while(db.next())
{
  int node=db.getInt(1);
  int language=db.getInt(2);
  String content=db.getString(3);
  int i=content.indexOf("[InstallDir_ChannelDir]UploadFiles/");
  if(i!=-1)
  {
    System.out.println("已找到:"+node);
    int len=content.length();
    content=content.replaceAll("\\[InstallDir_ChannelDir\\]UploadFiles/","/res/csv/u/");
    if(len!=content.length())
    {
      db2.executeUpdate("UPDATE NodeLayer SET content="+db2.cite(content)+" WHERE node="+node+" AND language="+language);
      System.out.println("已替换:"+node);
      count++;
    }
  }else
  {
    System.out.println(node);
  }
}
db.close();
db2.close();
System.out.println("完成:"+count);

%>
/*
JdbcDriver=sun.jdbc.odbc.JdbcOdbcDriver
Url=jdbc:odbc:demo
*/src="/Article/UploadFiles

