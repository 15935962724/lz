

<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186466367875")%> ( <%=al.size()%> )</SPAN>
<SPAN id=biaor></SPAN><span id="biaor_text"><%=Annuity.Annuity_1007(session,plan_code)%></span>
<span id="biaor_text">
<input type="submit" value="GO"  onclick="form1.action='?'"/></span>
</DIV>


<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466576328")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186466756468")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186467153578")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186467226281")%></td>
  <td nowrap><%=r.getString(teasession._nLanguage,"1186467307234")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  plan_code=(String)v.get("plan_code");
  String plan_name=(String)v.get("plan_name");
%>
<tr>
<td><%=Annuity.d(v.get("corp_name"))%></td>
<td><%=plan_code%></td>
<td><%=plan_name%></td>
<td><%=Annuity.d(v.get("account_balance"))%></td>
<td><%=Annuity.d(v.get("corp_balance"))%></td>
<td><%=Annuity.d(v.get("person_balance"))%></td>
</tr>
<%}%>
</TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity';">
