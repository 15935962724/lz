<select name="class_id" >
<%
  tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
//  tea.html.DropDown select = new tea.html.DropDown("class_id", 0);
  java.util.Enumeration enumer = tea.entity.node.Classes.findByCommunity(tea.entity.node.Node.find(teasession._nNode).getCommunity(), teasession._nLanguage);
  while (enumer.hasMoreElements()) {
    int id = ((Integer) enumer.nextElement()).intValue();
    tea.entity.node.Classes obj = tea.entity.node.Classes.find(id);
    %>
    <option value="<%=id%>"><%=obj.getName()%></option>
    <%
    //select.addOption(id, obj.getName());
  }
%>

