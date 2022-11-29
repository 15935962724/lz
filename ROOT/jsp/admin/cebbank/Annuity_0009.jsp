



<DIV id=neibiao><SPAN id=biaol></SPAN><SPAN id=neibiaozi><%=r.getString(teasession._nLanguage,"1186473958921")%></SPAN>
<SPAN id=biaor></SPAN></DIV>

<%--
<%=Annuity.Annuity_0008(code,user,corp_no,teasession._strCommunity)%>
<input type=submit value=GO onclick="return f_0008_submit();">
--%>

<table style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=0 border=0>
<TBODY>
<TR class=shuohang>
<td noWrap><%=r.getString(teasession._nLanguage,"1186468848421")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186474081546")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186474149718")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186474213968")%></td>
<td noWrap><%=r.getString(teasession._nLanguage,"1186474261265")%></td>
</tr>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  String cn=(String)v.get("corp_no");
    //当前创建者所在的集团 或 下拉菜单中所在的集团,都不显示.
    if(!code.equals(cn)&&!cn.equals(corp_no))
    {
%>
<tr>
<td><%=Annuity.d(v.get("corp_name"))%></td>
<td><%=Annuity.d(v.get("plan_num"))%></td>
<td><%=Annuity.d(v.get("fund_num"))%></td>
<td><%=Annuity.d(v.get("assets"))%></td>
<td><%=Annuity.d(v.get("person_num"))%></td>
</tr>
<% }
}%>
</TBODY>
</TABLE>

<input id="xia_z" type=image src="/res/fulijihua/u/0802/080239018.gif" name=export value=<%=r.getString(teasession._nLanguage,"1186542136171")%> onclick="form1.action='/servlet/ExportAnnuity'">
