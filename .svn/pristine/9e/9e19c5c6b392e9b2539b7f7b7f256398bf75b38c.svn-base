<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%

try
{
  int node=Integer.parseInt(request.getParameter("node"));
  int language=Integer.parseInt(request.getParameter("language"));

  Golf obj=Golf.find(node,language);
  tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Golf");

  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr bgcolor="#CCCCCC">
      <td nowrap="nowrap"> </td>
      <td nowrap="nowrap"><%=r.getString(language, "Member")%></td>
      <td nowrap="nowrap"><%=r.getString(language, "MemberGuest")%></td>
      <td nowrap="nowrap"><%=r.getString(language, "GroupGuest")%></td>
      <td nowrap="nowrap"><%=r.getString(language, "Visiter")%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language, "GreenFee(9holes)")%><%=r.getString(language, "Weekday")%></td>
      <td nowrap="nowrap"><%=obj.getMeGreen9W()%></td>
      <td nowrap="nowrap"><%=obj.getMgGreen9W()%></td>
      <td nowrap="nowrap"><%=obj.getGgGreen9W()%></td>
      <td nowrap="nowrap"><%=obj.getViGreen9W()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language , "Holiday")%></td>
      <td nowrap="nowrap"><%=obj.getMeGreen9H()%></td>
      <td nowrap="nowrap"><%=obj.getMgGreen9H()%></td>
      <td nowrap="nowrap"><%=obj.getGgGreen9H()%></td>
      <td nowrap="nowrap"><%=obj.getViGreen9H()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language, "GreenFee(18holes)")%><%=r.getString(language, "Weekday")%></td>
      <td nowrap="nowrap"><%=obj.getMeGreen18W()%></td>
      <td nowrap="nowrap"><%=obj.getMgGreen18W()%></td>
      <td nowrap="nowrap"><%=obj.getGgGreen18W()%></td>
      <td nowrap="nowrap"><%=obj.getViGreen18W()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"Holiday")%></td>
      <td nowrap="nowrap"><%=obj.getMeGreen18H()%></td>
      <td nowrap="nowrap"><%=obj.getMgGreen18H()%></td>
      <td nowrap="nowrap"><%=obj.getGgGreen18H()%></td>
      <td nowrap="nowrap"><%=obj.getViGreen18H()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"CellationChargeFee")%></td>
      <td nowrap="nowrap"><%=obj.getMeExeunt()%></td>
      <td nowrap="nowrap"><%=obj.getMgExeunt()%></td>
      <td nowrap="nowrap"><%=obj.getGgExeunt()%></td>
      <td nowrap="nowrap"><%=obj.getViExeunt()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language , "CaddieFee(9holes)")%></td>
      <td nowrap="nowrap"><%=obj.getMeCaddie9()%></td>
      <td nowrap="nowrap"><%=obj.getMgCaddie9()%></td>
      <td nowrap="nowrap"><%=obj.getGgCaddie9()%></td>
      <td nowrap="nowrap"><%=obj.getViCaddie9()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"Bogey")%></td>
      <td nowrap="nowrap"><%=obj.getMeCaddie9B()%></td>
      <td nowrap="nowrap"><%=obj.getMgCaddie9B()%></td>
      <td nowrap="nowrap"><%=obj.getGgCaddie9B()%></td>
      <td nowrap="nowrap"><%=obj.getViCaddie9B()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"CaddieFee(18holes)")%></td>
      <td nowrap="nowrap"><%=obj.getMeCaddie18()%></td>
      <td nowrap="nowrap"><%=obj.getMgCaddie18()%></td>
      <td nowrap="nowrap"><%=obj.getGgCaddie18()%></td>
      <td nowrap="nowrap"><%=obj.getViCaddie18()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"Bogey")%></td>
      <td nowrap="nowrap"><%=obj.getMeCaddie18B()%></td>
      <td nowrap="nowrap"><%=obj.getMgCaddie18B()%></td>
      <td nowrap="nowrap"><%=obj.getGgCaddie18B()%></td>
      <td nowrap="nowrap"><%=obj.getViCaddie18B()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"ReservedCaddieFee")%></td>
      <td nowrap="nowrap"><%=obj.getMeReserved()%></td>
      <td nowrap="nowrap"><%=obj.getMgReserved()%></td>
      <td nowrap="nowrap"><%=obj.getGgReserved()%></td>
      <td nowrap="nowrap"><%=obj.getViReserved()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"BuggyFee(9holes)")%></td>
      <td nowrap="nowrap"><%=obj.getMeBuggy9()%></td>
      <td nowrap="nowrap"><%=obj.getMgBuggy9()%></td>
      <td nowrap="nowrap"><%=obj.getGgBuggy9()%></td>
      <td nowrap="nowrap"><%=obj.getViBuggy9()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"BuggyFee(18holes)")%></td>
      <td nowrap="nowrap"><%=obj.getMeBuggy18()%></td>
      <td nowrap="nowrap"><%=obj.getMgBuggy18()%></td>
      <td nowrap="nowrap"><%=obj.getGgBuggy18()%></td>
      <td nowrap="nowrap"><%=obj.getViBuggy18()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"DrivingRangeBall")%></td>
      <td nowrap="nowrap"><%=obj.getMeDriving()%></td>
      <td nowrap="nowrap"><%=obj.getMgDriving()%></td>
      <td nowrap="nowrap"><%=obj.getGgDriving()%></td>
      <td nowrap="nowrap"><%=obj.getViDriving()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"ClubRental-perClub")%></td>
      <td nowrap="nowrap"><%=obj.getMeClub()%></td>
      <td nowrap="nowrap"><%=obj.getMgClub()%></td>
      <td nowrap="nowrap"><%=obj.getGgClub()%></td>
      <td nowrap="nowrap"><%=obj.getViClub()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"CommonClubs")%></td>
      <td nowrap="nowrap"><%=obj.getMeCommon()%></td>
      <td nowrap="nowrap"><%=obj.getMgCommon()%></td>
      <td nowrap="nowrap"><%=obj.getGgCommon()%></td>
      <td nowrap="nowrap"><%=obj.getViCommon()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"Pro.rentalClubs")%></td>
      <td nowrap="nowrap"><%=obj.getMePro()%></td>
      <td nowrap="nowrap"><%=obj.getMgPro()%></td>
      <td nowrap="nowrap"><%=obj.getGgPro()%></td>
      <td nowrap="nowrap"><%=obj.getViPro()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"SpikedShoes")%></td>
      <td nowrap="nowrap"><%=obj.getMeSpiked()%></td>
      <td nowrap="nowrap"><%=obj.getMgSpiked()%></td>
      <td nowrap="nowrap"><%=obj.getGgSpiked()%></td>
      <td nowrap="nowrap"><%=obj.getViSpiked()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"UmbrellaRental")%></td>
      <td nowrap="nowrap"><%=obj.getMeUmbrella()%></td>
      <td nowrap="nowrap"><%=obj.getMgUmbrella()%></td>
      <td nowrap="nowrap"><%=obj.getGgUmbrella()%></td>
      <td nowrap="nowrap"><%=obj.getViUmbrella()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"FacilitiesFee")%></td>
      <td nowrap="nowrap"><%=obj.getMeFacilities()%></td>
      <td nowrap="nowrap"><%=obj.getMgFacilities()%></td>
      <td nowrap="nowrap"><%=obj.getGgFacilities()%></td>
      <td nowrap="nowrap"><%=obj.getViFacilities()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"NondesignatedGreenFee")%><%=r.getString(language, "Weekday")%></td>
      <td nowrap="nowrap"><%=obj.getMeNonDesignatedW()%></td>
      <td nowrap="nowrap"><%=obj.getMgNonDesignatedW()%></td>
      <td nowrap="nowrap"><%=obj.getGgNonDesignatedW()%></td>
      <td nowrap="nowrap"><%=obj.getViNonDesignatedW()%></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td nowrap="nowrap"><%=r.getString(language,"Holiday")%></td>
      <td nowrap="nowrap"><%=obj.getMeNonDesignatedH()%></td>
      <td nowrap="nowrap"><%=obj.getMgNonDesignatedH()%></td>
      <td nowrap="nowrap"><%=obj.getGgNonDesignatedH()%></td>
      <td nowrap="nowrap"><%=obj.getViNonDesignatedH()%></td>
    </tr>
  </table>
  <%
}catch(Exception ex)
{
  System.out.println("COURT："+request.getServerName()+request.getRequestURI()+"?"+request.getQueryString());
}
%>
