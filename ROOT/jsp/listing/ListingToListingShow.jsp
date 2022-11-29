<%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
tea.db.DbAdapter dbadapter2=new tea.db.DbAdapter();
dbadapter.executeQuery("SELECT DISTINCT(listing),style,node,root FROM Listing");
while(dbadapter.next())
{
  int listing=dbadapter.getInt(1);
  int style=dbadapter.getInt(2);
  int node=dbadapter.getInt(3);
  tea.entity.node.Node obj=tea.entity.node.Node.find(node);
  tea.entity.site.Community community=tea.entity.site.Community.find(node);
  switch(style)
  {
    case 0://本节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+",255,0,0,"+node+")");
    break;
    case 1://本树, 本类型节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+obj.getType()+","+obj.getTypeAlias()+",1,"+node+")");
    break;
    case 2://本树, 所有节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+255+","+0+",1,"+node+")");
    break;
    case 3://本社区, 本类型节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+obj.getType()+","+obj.getTypeAlias()+",1,"+community.getNode()+")");
    break;
    case 4://本社区, 所有节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+255+","+0+",1,"+community.getNode()+")");
    break;
    case 5://所有社区, 本类型节点
    //dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+255+","+0+",1,"+community.getNode()+")");
    break;
    case 7://同根, 本类型节点
    dbadapter2.executeUpdate("INSERT INTO ListingShow(listing,type,typealias,style,root) VALUES("+listing+","+obj.getType()+","+obj.getTypeAlias()+",1,"+dbadapter.getInt(4)+")");
    break;
  }
}
dbadapter2.close();
dbadapter.close();
%>

