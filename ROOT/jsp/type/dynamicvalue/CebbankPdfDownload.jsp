<%//@include file="/jsp/Header.jsp"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

javax.servlet.ServletOutputStream os=null;

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

if(!node.getFileFlag())
{
  response.setContentType("text/html;charset=UTF-8");
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("&#24635;&#34892;&#27809;&#26377;&#19978;&#20256;pdf&#25991;&#20214;","UTF-8"));////总行没有上传pdf文件
  return;
}else
{
System.out.println("aa");
  String name=node.getSubject(teasession._nLanguage)+".pdf";
  name=java.net.URLEncoder.encode(name,"UTF-8"); //new String(name.getBytes("UTF-8"),"ISO-8859-1");
  response.reset();
  response.setContentType("application/pdf;charset=UTF-8");
  response.setHeader("Content-Disposition","attachment;filename="+name);
System.out.println("bb");
  //  tea.entity.node.Cebbank c=tea.entity.node.Cebbank.find(teasession._nNode);
  //  c.getPdf(response.getOutputStream(),node.getType(),teasession._nLanguage);
  /*
  com.lowagie.text.Document document = new  com.lowagie.text.Document(com.lowagie.text.PageSize.A4, 80, 50, 30, 65);

  try {

    //  设定输入pdf 文件
    com.lowagie.text.pdf.PdfWriter.getInstance(document,response.getOutputStream());
    // 设定输入流  此处可将字符串改为输入流
    //        	 InputStream   in= new FileInputStream("test.htm");
    // step 3: we parse the document
    //解析并生成 pdf

    com.lowagie.text.html.HtmlParser.parse(document, "http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/type/dynamicvalue/DynamicValueView.jsp;jsessionid="+session.getId()+"?node="+teasession._nNode);
  }
  catch(Exception e) {
    e.printStackTrace();
    response.sendRedirect("/jsp/info/Alert.jsp?info="+e.getMessage());
  }
  */
  System.out.println("cc");
  javax.servlet.ServletOutputStream sos=response.getOutputStream();
  sos.write(node.getFile(teasession._nLanguage));
  sos.close();
    System.out.println("dd");
}
if(true)
return;
%>

