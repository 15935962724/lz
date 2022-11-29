<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*"%><%@ page import="tea.entity.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.ui.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession.getParameter("community");
if(request.getMethod().equals("POST"))
{
  Node obj=Node.find(teasession._nNode);
  if(obj.getType()>1)
  {
    teasession._nNode=obj.getFather();
    obj=Node.find(teasession._nNode);
  }
  int type=obj.getType();
  if(obj.getType()==1)
  {
    Category c=Category.find(teasession._nNode);
    type=c.getCategory();
  }
  StringBuffer sb=new StringBuffer();
  if(teasession.getParameter("wordsubmit")!=null)
  {
    byte by[]=teasession.getBytesParameter("word");
    if(by==null)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效","UTF-8"));
      return;
    }
    java.io.ByteArrayInputStream bis=new java.io.ByteArrayInputStream(by);
    /*
    org.apache.poi.hdf.extractor.WordDocument wd = new org.apache.poi.hdf.extractor.WordDocument(bis);
    java.io.StringWriter docTextWriter = new java.io.StringWriter();
    wd.writeAllText(new java.io.PrintWriter(docTextWriter));
    docTextWriter.close();

    String  bodyText = docTextWriter.toString();
    // bodyText = new WordExtractor().extractText(is);
    */
    // FileInputStream in = new FileInputStream ("c:\\a.doc");
    String content;
    try
    {
      org.apache.poi.hwpf.extractor.WordExtractor extractor = new  org.apache.poi.hwpf.extractor.WordExtractor(bis);
      content = extractor.getText();
    }catch(java.io.IOException e)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效,不是Word文件.","UTF-8"));
      return;
    }
    System.out.println(content);
    String cs[]=content.split("<EDN>");
    for(int index=0;index<cs.length;index++)
    {
      cs[index]=cs[index].trim();
      if(cs[index].length()>0)
      {
    	  
        String subject="< No Subject >";
        java.util.Date time=new java.util.Date();
        int i=cs[index].indexOf("\r\n");
        if(i!=-1)
        {
          subject=cs[index].substring(0,i);
          int time_end=cs[index].indexOf("\r\n",i+2);
          if(time_end!=-1)
          {
            time=Node.sdf.parse(cs[index].substring(i+2,time_end));
            cs[index]=cs[index].substring(time_end+2);
          }
        }
        
        
        
        int newnode=Node.create(teasession._nNode,0,community,teasession._rv,type,false,obj.getOptions(),obj.getOptions1(),obj.getDefaultLanguage(),null,null,time,0,0,0,0,"",null,teasession._nLanguage,subject,"",cs[index],null,"",0,null,"","","","",null,null);
        obj.finished(newnode);
        
      }
    }
  }else
  if(teasession.getParameter("excelsubmit")!=null)
  {
    byte by[]=teasession.getBytesParameter("excel");
    if(by==null)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效","UTF-8"));
      return;
    }
    java.io.ByteArrayInputStream bis=new java.io.ByteArrayInputStream(by);
    jxl.Workbook wb=jxl.Workbook.getWorkbook(bis);
    jxl.Sheet st=wb.getSheet(0);
    String subject=null,content=null;
    java.util.Date time=null;
    java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");
    System.out.println("行数:"+st.getRows());
    for(int row=1;row<st.getRows();row++)
    {
      subject=st.getCell(0,row).getContents();
      if(subject.length()<1)
      {
//        subject="< No Subject >";
         continue ;
      }
      System.out.println("主题:"+subject);
      jxl.Cell c=st.getCell(1,row);
      if(c.getType()==jxl.CellType.DATE)
      {
        time=sdf.parse(c.getContents());
      }else
      {
        time=new java.util.Date();
      }
      System.out.println("时间:"+time);
      content=st.getCell(2,row).getContents();
      System.out.println("内容:"+content);
     // int newnode=Node.create(teasession._nNode,0,community,teasession._rv,type,false,obj.getOptions(),obj.getOptions1(),obj.getDefaultLanguage(),null,null,time,0,0,0,0,0,"",teasession._nLanguage,subject,"",content,null,"",0,null,"","","","",null,null);
      
      int newnode = Node.create(teasession._nNode, 0, community, teasession._rv, type, false, obj.getOptions(), obj.getOptions1(), obj.getDefaultLanguage(), null, null, new java.util.Date(), obj.getStyle(), obj.getRoot(), obj.getKstyle(), obj.getKroot(), "", null, teasession._nLanguage, subject, null, content, null, "", 0, null, "", "", "", "", null, null);
      obj.finished(newnode);

      switch(type)
      {
        case 39://新闻讯资
        {
          String logograph=st.getCell(3,row).getContents();
          //Report.create(newnode,teasession._nLanguage,0,0,"","",logograph,time);
          Report.create(newnode, 0, 0,  new java.util.Date(), teasession._nLanguage, null, null, null, null, logograph, null, 0);
          
        }
        break;
        case 44://报纸文章
        {
          String subtitle=st.getCell(3,row).getContents();
          String edition="";
          String column="";
          String author="";
          String editor="";
          NewsPaper np_obj=NewsPaper.find(newnode,teasession._nLanguage);
          np_obj.set(subtitle,0,edition,column,time,author,editor);
        }
        break;
      }
    }
    wb.close();
    bis.close();
  }

//  response.sendRedirect("/servlet/Node?node="+teasession._nNode);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}





Resource r = new Resource();


%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="document.form1.word.focus();">
<h1>抽取内容</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="<%=request.getRequestURI()%>" method="POST" enctype="multipart/form-data" name="form1" onsubmit="" >
  <input type="hidden" name="Node" value="<%=teasession._nNode%>">
  <input type="hidden" name="community" value="<%=community%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>Word文件:</td>
      <td colspan="20"><input type="file" name=word  size=70 maxlength=255>
      </td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" name="wordsubmit" value="提交" onclick="return submitText(form1.word, '<%=r.getString(teasession._nLanguage, "InvalidFile")%>');"/>
      </td>
    </tr>
  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>Excel文件:</td>
      <td colspan="20"><input type="file" name=excel  size=70 maxlength=255>
      </td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" name="excelsubmit" value="提交" onclick="return submitText(form1.excel, '<%=r.getString(teasession._nLanguage, "InvalidFile")%>');"/>
      </td>
    </tr>
  </table>

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<br/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td>注:</td></tr>
    <tr><td >1.Word文件格式: 第一行:主题, 第二行:时间(yyyy-MM-dd), 第三行:内容  分隔附:&lt;EDN&gt;</td></tr>
    <tr><td >2.Excel文件格式: 第一列:主题, 第二列:时间(yyyy-MM-dd), 第三列:内容<br>
        1)新闻讯资: 第四列:导语<br>
        2)报纸文章: 第四列:副标题<br>
      </td>
    </tr>
  </table>
</body>
</html>
