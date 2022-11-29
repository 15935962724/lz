<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if(request.getMethod().equals("POST"))
{
  int count=0;
  String checkbox[]=request.getParameterValues("checkbox");
  if(checkbox!=null)
  {
    DbAdapter db=new DbAdapter();
    try
    {
      for(int i=0;i<checkbox.length;i++)
      {
        if("community".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM CommunityLayer WHERE community NOT IN (SELECT community FROM Community)");
          count+=db.executeUpdate("DELETE FROM Node WHERE community NOT IN (SELECT community FROM Community)");
        }else
        if("listing".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM ListingLayer WHERE listing NOT IN (SELECT listing FROM Listing)");
          count+=db.executeUpdate("DELETE FROM PickFrom WHERE listing NOT IN (SELECT listing FROM Listing)");
          count+=db.executeUpdate("DELETE FROM PickNode WHERE listing NOT IN (SELECT listing FROM Listing)");
          count+=db.executeUpdate("DELETE FROM PickManual WHERE listing NOT IN (SELECT listing FROM Listing)");
          count+=db.executeUpdate("DELETE FROM listinghide WHERE node NOT IN (SELECT node FROM Node ) OR listing NOT IN (SELECT listing FROM Listing ) OR hiden=3");
          count+=db.executeUpdate("DELETE FROM ListingDetail WHERE Listing NOT IN (SELECT listing FROM Listing ) OR ( Istype=0 AND DATALENGTH(BeforeItem)=0 AND DATALENGTH(AfterItem)=0 AND Quantity=0)");
          count+=db.executeUpdate("DELETE FROM Listed WHERE listing NOT IN (SELECT listing FROM Listing ) OR node NOT IN (SELECT node FROM Node )");
        }else
        if("section".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM Section WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM SectionLayer WHERE section NOT IN (SELECT section FROM Section )");
          count+=db.executeUpdate("DELETE FROM sectionhide WHERE node NOT IN (SELECT node FROM Node ) OR section NOT IN (SELECT section FROM Section ) OR hiden=3");
        }else
        if("aded".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM Aded WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM AdedLayer WHERE aded NOT IN (SELECT aded FROM Aded )");
          count+=db.executeUpdate("DELETE FROM Ading WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM AdingLayer WHERE ading NOT IN (SELECT ading FROM Ading )");
        }else
        if("cssjs".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM CssJs WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM CssJsHide WHERE node NOT IN (SELECT node FROM Node ) OR cssjs NOT IN (SELECT cssjs FROM CssJs ) OR hiden=3");
        }else
        if("node".equals(checkbox[i]))
        {
          count+=db.executeUpdate("DELETE FROM CssJs WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM CssJsHide WHERE node NOT IN (SELECT node FROM Node ) OR cssjs NOT IN (SELECT cssjs FROM CssJs ) OR hiden=3");
          count+=db.executeUpdate("DELETE FROM Ading WHERE node NOT IN (SELECT node FROM Node )");
          count+=db.executeUpdate("DELETE FROM AdingLayer WHERE ading NOT IN (SELECT ading FROM Ading )");
        }
      }
    }finally
    {
      db.close();
    }
  }
}

Resource r=new Resource();


%><html>
<head>
<link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Optimize")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="<%=request.getRequestURI()%>" method="post">
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <tr ID=tableonetr>
    </tr>
    <tr><td><input name="checkbox" type="checkbox" value="community">社区相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="listing">列举相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="section">段落相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="section">段落相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="aded">广告相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="cssjs">CssJs相关</td></tr>
     <tr><td><input name="checkbox" type="checkbox" value="node">节点相关</td></tr>
  </TABLE>

<input type="submit" value="提交">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

