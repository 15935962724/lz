<%request.setCharacterEncoding("UTF-8");
if(request.getMethod().equals("POST"))
{
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
tea.db.DbAdapter dbadapter2=new tea.db.DbAdapter();
dbadapter.executeQuery("select Node.node,NodeLayer.language, NodeLayer.text from NodeLayer,Node where Node.node=NodeLayer.node AND type=39 AND community='cnoocinfo' AND NodeLayer.text like '%<img %' and datalength(NodeLayer.text)>=8000");
while(dbadapter.next())
{
  String text=dbadapter.getString(3);
  if(text!=null)
  text=  text.replaceAll("<img ","<img_abolish ");
  dbadapter2.executeUpdate("update  NodeLayer set NodeLayer.text="+dbadapter.cite(text)+" WHERE node= "+dbadapter.getInt(1)+" AND language="+dbadapter.getInt(2));
}
dbadapter.close();
dbadapter2.close();
out.println("<h1>成功</h1>");
return;
}
%>
<!---
update  NodeLayer set NodeLayer.text=REPLACE(cast(NodeLayer.text as varchar(8000)),'<img ','<img_abolish ')
where NodeLayer.text like '%<img %' and datalength(NodeLayer.text)<8000

-->
<form method="POST">
  <input type="submit" />
  </form>

