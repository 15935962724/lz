<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.html.*"
%>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.resource.Resource r=new tea.resource.Resource();
 Form form = new Form("foEdit", "POST", "/servlet/EditStocktxt");
                form.setMultiPart(true);
				form.setOnSubmit("return(submitText(this.Stocktxt, '" + r.getString(teasession._nLanguage, "InvalidStock") + "')" + ");");
                form.add(new HiddenField("Node", teasession._nNode));
                Table table = new Table();

				Row row1 =new Row();
				Cell cell1=new Cell();
				cell1.add(new tea.htmlx.FileInput(teasession._nLanguage, "Stocktxt","Stocktxt"));
                row1.add(cell1);
				table.add(row1);

				form.add(table);
                form.add(new Button("提交"));
				out.print(form.toString());
%>

