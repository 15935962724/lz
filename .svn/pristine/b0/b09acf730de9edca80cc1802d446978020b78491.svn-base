
<!--企业列表信息查询-->
<div align=left style="margin:20 40;background:url(/res/ceb/u/0802/080224420.jpg) no-repeat 0 center;width:100%;height:100px;padding-left:150" >
<span style="font-size:12px;color:#666;background:url(/res/fulijihua/u/0802/080239014.gif) no-repeat left bottom;width:300;padding-bottom:10px;"}">&#24744;&#21442;&#21152;&#24180;&#37329;&#35745;&#21010;&#30340;&#20225;&#19994;&#26159;&#65306;<!--  您参加年金计划的企业是：  --></span>
<div align=left style=margin:10 20;line-height:150%>
<%
for(int i=0;i<al.size();i++)
{
  Map v=(Map)al.get(i);
  String pkc=Annuity.des((String)v.get("pk_corporation"));
%>

<a style="font-size:14px;line-height:150%;width:100%;height:30px;background:url(/res/fulijihua/u/0802/080239013.jpg) no-repeat left 15;padding-top:8px;text-align:left;padding-left:10px" href="/servlet/EditAnnuity?tn={1}&pkc=<%=pkc%>&nexturl=/jsp/admin/cebbank/Annuity.jsp%3Fcommunity%3D<%=teasession._strCommunity%>"><%=Annuity.d(v.get("name"))%></a><br>

<%
}
%>
</div>

<span style="font-size:12px;color:#666;background:url(/res/fulijihua/u/0802/080239014.gif) no-repeat left top;width:300;padding-top:10px;}">&#35831;&#28857;&#20987;&#30456;&#24212;&#20225;&#19994;&#21517;&#31216;&#36827;&#20837;&#26597;&#35810;&#35814;&#32454;&#20449;&#24687;
<!--  请点击相应企业名称进入查询详细信息。 -->
</span></div>
