<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession (request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

String url="";
String urls[]= request.getServerName().split("\\.");
for(int index=1;index<urls.length;index++)
{
  url+="."+urls[index];
}
if(request.getServerPort()!=80)
{
  url+=":"+request.getServerPort();
}
java.util.Enumeration enumer = tea.entity.node.SMSPhoneBook.findByMember(teasession._strCommunity,teasession._rv.toString());
//java.util.Enumeration enumer=tea.entity.node.SMSPhoneBook.findByMember(node.getCreator()._strV.toString());
while(enumer.hasMoreElements())
{
int id=((Integer)enumer.nextElement()).intValue();
tea.entity.node.SMSPhoneBook spk=tea.entity.node.SMSPhoneBook.find(id);

%>
<A href="http://<%=spk.getMemberx()+url%>"><%=spk.getMemberx()%></A>
<%
}
%>

