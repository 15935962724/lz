<%
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
  dbadapter.executeQuery("SELECT DISTINCT Node.node,Node.type FROM Node,NodeLayer WHERE DATALENGTH(NodeLayer.text)=0 AND(type=53 OR type=54 OR type=51 OR type=30)");
  int node;
  while (dbadapter.next()) {
    tea.db.DbAdapter dbadapter2 = new tea.db.DbAdapter();
    try {
      StringBuffer sb = new StringBuffer("UPDATE NodeLayer SET text=(");
      node = dbadapter.getInt(1);
      switch (dbadapter.getInt(2)) {
      case 51:
        sb.append("SELECT CONVERT(varchar(8000),fundinfo) FROM Investor WHERE node=" + node);
        break;
      case 30:
        sb.append("SELECT CONVERT(varchar(8000),synopsis) FROM Financing WHERE node=" + node);
        break;
      case 54:
        sb.append("SELECT CONVERT(varchar(8000),fundinfo) FROM LInvestor WHERE node=" + node);
        break;
      case 53:
        sb.append("SELECT CONVERT(varchar(8000),synopsis) FROM LFinancing WHERE node=" + node);
        break;
      }
      sb.append(") WHERE node=" + node);
      dbadapter2.executeUpdate(sb.toString());
    }
    catch (Exception e) {
      e.printStackTrace();
    }finally {
        dbadapter2.close();
      }
    }
    dbadapter.close();
%>
完成

