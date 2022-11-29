<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.html.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<BODY onkeydown="if (event.keyCode==116||(event.ctrlKey && event.keyCode==82)){event.keyCode=0;event.returnValue=false;}" onKeyUp="if (event.keyCode==116||(event.ctrlKey && event.keyCode==82)){location.reload();}">
<DIV ID=Body>
  <DIV ID="Header"></DIV>
  <DIV ID="AdLeft"></DIV>
  <DIV ID="AdRight"></DIV>
  <DIV ID="Content">
    <DIV ID="Content1"></DIV>
    <DIV ID="Content3"></DIV>
    <DIV ID=Content2>
      <style type="text/css">
<!--

#turnto {font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 10;text-align: center}

#head_table{font-size: 9pt; line-height: 15pt;color: #990000; position: relative; left: 0; top: 0;background-color: #BFEBFF;}
#searchcellhead{ vertical-align:left;border: 0 solid #C0C0C0;}
#stocktable{  font-size: 9pt; line-height: 15pt;color: #000000;border: 1 solid #C0C0C0; padding-left: 2; padding-right: 1; padding-top: 1; padding-bottom: 1;}

#searchcell{text-align: left; width:100;border: 1 solid #C0C0C0;}

#table_page{ width:1200; font-size: 9pt; line-height: 12pt;color: #000000;border: 1 solid #C0C0C0;heiht:20;text-align: center}
#row_page{ width:1200; font-size: 9pt; line-height: 15pt;color: #000000;border: 1 solid #C0C0C0;text-align: center}


-->

</style>
      <table width=1200 border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width=40></td>
          <td><%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.resource.Resource r=new tea.resource.Resource();
        Text text = new Text();
        Table table_h = new Table();
        table_h.setId("table_page");
        table_h.setWidth("80%");
        Row row_h = new Row();
        Row row_h1 = new Row();

        row_h.setId("row_page");
        Table table1 = new Table();
        table1.setId("stocktable");
        text.add(new JavaScript("function MM_jumpMenu(targ,selObj,restore){ eval(targ+\".location='\"+selObj.options[selObj.selectedIndex].value+\"'\");  if (restore) selObj.selectedIndex=0;}"));
        try
        {
            // TeaSession teasession = new TeaSession(httpservletrequest);
            HttpSession httpsession = teasession.getSession(); // httpservletrequest.getSession(true);
            Row row11 = new Row();
            row11.setId("head_table");
            row11.add(new Cell(r.getString(teasession._nLanguage, "xm"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xb"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "csny"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xl"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xw"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "zw"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "cjgzsj"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xdw"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xbw"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "xgw"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "phone"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "mobile"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "email"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "sqrq"), "searchcellhead"));
            row11.add(new Cell(r.getString(teasession._nLanguage, "jianli"), "searchcellhead"));

            table1.add(row11);
            Vector v_stock = null;
            int c_stock = 0;
            if (teasession.getParameter("Page") == null || httpsession.getAttribute("tea.stock" ) == null)
            {
                v_stock = tea.entity.node.Application.find();
                c_stock = tea.entity.node.Application.count_s();

                httpsession.setAttribute("tea.app", v_stock);
                httpsession.setAttribute("tea.c_app", (new Integer(c_stock)));
            } else
            {
                c_stock = ((Integer) httpsession.getAttribute("tea.c_app")).intValue();
                v_stock = (Vector) httpsession.getAttribute("tea.app");
            }
            //	Enumeration ggg=v_stock.elements();
            //int kkk=ddd.length();
            int Page = 0;
            if (teasession.getParameter("Page") != null)
            {
                Page = Integer.parseInt(teasession.getParameter("Page")) - 1;
            }
            Form form = new Form("foNew", "POST", "");
            DropDown1 dropdown = new DropDown1("media");
            for (int ii = 0; ii <= c_stock / 10 + 1; ii++)
            {
                dropdown.addOption(request.getRequestURI()+"?Page=" + ii+"&"+request.getQueryString(),
                                   (new Integer(ii)).toString());
            }

            form.add(dropdown);

            row_h.add(new Cell(r.getString(teasession._nLanguage, "all") + "(" + c_stock + ")" +                               r.getString(teasession._nLanguage, "Records"), "searchcellhead"));
            row_h.add(new Cell(r.getString(teasession._nLanguage, "all") + "(" + c_stock / 10 + ")" +                               r.getString(teasession._nLanguage, "Pages"), "searchcellhead"));
            row_h.add(new Cell(r.getString(teasession._nLanguage, "The") + "(" + (Page == 0 ? 1 : Page) + ")" +                               r.getString(teasession._nLanguage, "Pages"), "searchcellhead"));
            row_h.add(new Cell(r.getString(teasession._nLanguage, "Turn&nbsp;to"), "searchcellhead"));
            Cell cellto = new Cell(form);
            cellto.setId("turnto");
            row_h.add(cellto);
            row_h.add(new Cell(r.getString(teasession._nLanguage, "page"), "searchcellhead"));
            table_h.add(row_h);
            text.add(table_h);

            for (int k3 = Page * 10; k3 < Page * 10 + 10; k3++)
            {
                int id = ((Integer) v_stock.elementAt(k3)).intValue();
                // int id = ((Integer)enumeration.nextElement()).intValue();
                //System.out.println(id);
               tea.db. DbAdapter dbadapter = new  tea.db.DbAdapter();
                try
                {

                    dbadapter.executeQuery("SELECT xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,email,sqrq FROM Application where node =" +id);
                    // System.out.println("SELECT xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,email,sqrq FROM Application where node ="+id);

                    if (dbadapter.next())
                    {
                        Row row12 = new Row();
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 1))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 2))), "searchcell"));
                        String date11 = ((new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(3)));
                        row12.add(new Cell(new Text(date11), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 4))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 5))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 6))), "searchcell"));
                        String date12 = ((new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(7)));
                        row12.add(new Cell(new Text(date12), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 8))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 9))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 10))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 11))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 12))), "searchcell"));
                        row12.add(new Cell(new Text((dbadapter.getVarchar(1, 1, 13))), "searchcell"));
                        String date13 = ((new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(14)));
                        row12.add(new Cell(new Text(date13), "searchcell"));
                        Cell cellj = new Cell();
                        cellj.add(new Button(1, "CB", "CBEditNode", r.getString(1, "jianli"), "window.open('" + teasession.getRequest().getContextPath() + "/tea/app/" + id + ".doc', '_blank');"));
                        row12.add(cellj);
                        table1.add(row12);
                    }
                } catch (Exception exception)
                {
                    exception.printStackTrace();
                } finally
                {
                    dbadapter.close();
                }
            }
        } catch (Exception exception)
        {
        }
        // text.add(new Text(stockid));
        text.add(table1);
        text.add(new Button(1, "CB", "CBPlay", r.getString(1, "appout"), "window.open('/servlet/AppOut','_self');"));
        text.add(table_h);
        out.print(text);
%>
            <div align=right><a href="javascript:history.back()"><img SRC="/tea/image/section/4426.jpg" width="40" height="23" alt="返回" border="0"></a></div></td>
          <td width=20></td>
      </table>
    </DIV>
  </DIV>
  <DIV ID="Footer"></DIV>
</DIV>
</BODY>
</html>

