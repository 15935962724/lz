<%
//如果新闻资讯中"名称"为空,就把对应的节点"主题"复制到"名称"中
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
tea.db.DbAdapter dbadapter2=new tea.db.DbAdapter();
dbadapter.executeQuery("SELECT node FROM Report WHERE name is null");
int node;
while(dbadapter.next())
{
  node=dbadapter.getInt(1);
  dbadapter2.executeUpdate("UPDATE Report SET name=(SELECT subject FROM NodeLayer WHERE NodeLayer.node="+node+" AND NodeLayer.language=1 ) WHERE Report.node="+node);
}
dbadapter.close();
dbadapter2.close();
%>
转换完成

