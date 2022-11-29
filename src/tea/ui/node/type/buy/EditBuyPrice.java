package tea.ui.node.type.buy;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditBuyPrice extends TeaServlet
{

    public EditBuyPrice()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
            } else
            {
                AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv.toString());
                if (!node.isCreator(teasession._rv) && !obj_am.isProvider(34))
                {
                    response.sendError(403);
                    return;
                }
            }
            String s = request.getParameter("Currency");
            String s1 = request.getParameter("ConvertCurrency");
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/buy/EditBuyPrice.jsp?" + request.getQueryString());
                /*
                                 boolean flag = s == null;
                                 int j = 0;
                                 BigDecimal bigdecimal = new BigDecimal(0.0D);
                                 BigDecimal bigdecimal2 = new BigDecimal(0.0D);
                                 BigDecimal bigdecimal4 = new BigDecimal(0.0D);
                                 int l = 0;
                                 BigDecimal bigdecimal7 = new BigDecimal(0.0D);
                                 int j1 = 0;
                                 if (!flag)
                                 {
                    j = Integer.parseInt(s);
                    BuyPrice buyprice1 = BuyPrice.find(teasession._nNode, j);
                    bigdecimal = buyprice1.getSupply();
                    bigdecimal2 = buyprice1.getList();
                    bigdecimal4 = buyprice1.getPrice();
                    l = buyprice1.getOptions();
                    bigdecimal7 = buyprice1.getPoint();
                    j1 = buyprice1.getConvertCurrency();
                                 }
                                 Form form = new Form("foEdit", "POST", "EditBuyPrice");
                                 form.setOnSubmit("return(submitFloat(this.Supply,'" + super.r.getString(teasession._nLanguage, "InvalidSupply") + "')" + "&&submitFloat(this.Price,'" + super.r.getString(teasession._nLanguage, "InvalidPrice") + "')" + ");");
                                 form.add(new HiddenField("Node", Integer.toString(teasession._nNode)));
                                 if (flag)
                                 {
                    form.add(new HiddenField("New", "ON"));
                                 }
                                 Table table = new Table();
                                 table.add(new CurrencySelection(teasession._nLanguage, j, !flag));
                                 Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Supply") + ":"), true));
                                 row.add(new Cell(new TextField("Supply", bigdecimal.toString(), 6)));
                                 table.add(row);
                                 Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "List") + ":"), true));
                                 row1.add(new Cell(new TextField("List", bigdecimal2.toString(), 6)));
                                 table.add(row1);
                                 Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "OurPrice") + ":"), true));
                                 row2.add(new Cell(new TextField("Price", bigdecimal4.toString(), 6)));
                                 table.add(row2);
                                 Row row3 = new Row(new Cell(new Text(" <br><br><br> ")));
                                 table.add(row3);
                                 Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Point") + ":"), true));
                                 Cell cell = new Cell();
                                 cell.add(new TextField("Point", bigdecimal7.toString(), 6));
                                 cell.add(new Radio("Options", 0, l == 0));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "BaseOnRelation")));
                                 cell.add(new Radio("Options", 1, l == 1));
                                 cell.add(new Text(super.r.getString(teasession._nLanguage, "BaseOnAmount")));
                                 row4.add(cell);
                                 table.add(row4);
                                 table.add(new ConvertCurrencySelection(teasession._nLanguage, j1, false));
                                 form.add(table);
                                 form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                 PrintWriter printwriter = response.getWriter();
                                 printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                 printwriter.print(form);
                                 printwriter.print(new Script("document.foEdit.Price.focus();"));
                                 printwriter.print(new Languages(teasession._nLanguage, request));
                                 printwriter.close();*/
                return;
            }
            int commodity = Integer.parseInt(request.getParameter("commodity"));
            int i = Integer.parseInt(s);
            int k = Integer.parseInt(s1);
            BigDecimal bigdecimal1 = null;
            try
            {
                bigdecimal1 = new BigDecimal(request.getParameter("Supply"));
            } catch (Exception _ex)
            {}
            BigDecimal bigdecimal3 = null;
            try
            {
                bigdecimal3 = new BigDecimal(request.getParameter("List"));
            } catch (Exception _ex)
            {}
            BigDecimal bigdecimal5 = null;
            try
            {
                bigdecimal5 = new BigDecimal(request.getParameter("Price"));
            } catch (Exception _ex)
            {}
            BigDecimal price1 = new BigDecimal(request.getParameter("Price1"));
            BigDecimal price2 = new BigDecimal(request.getParameter("Price2"));
            BigDecimal price3 = new BigDecimal(request.getParameter("Price3"));
            BigDecimal bigdecimal6 = null;
            try
            {
                bigdecimal6 = new BigDecimal(request.getParameter("Point"));
            } catch (Exception _ex)
            {}
            if (bigdecimal1 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSupply"));
                return;
            }
            if (bigdecimal3 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidList"));
                return;
            }
            if (bigdecimal5 == null)
            {
                outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidPrice"));
                return;
            }
            if (bigdecimal6 == null)
            {
                bigdecimal6 = new BigDecimal(0.0D);
            }
            int i1 = 0;
            i1 = Integer.parseInt(request.getParameter("Options"));
            if (request.getParameter("New") != null)
            {
                BuyPrice.create(commodity, i, bigdecimal1, bigdecimal3, bigdecimal5, price1, price2, price3, i1, bigdecimal6, k);
            } else
            {
                BuyPrice buyprice = BuyPrice.find(commodity, i);
                buyprice.set(bigdecimal1, bigdecimal3, bigdecimal5, price1, price2, price3, i1, bigdecimal6, k);
            }
            String nexturl = teasession.getParameter("nexturl");
            response.sendRedirect("/jsp/type/buy/BuyPrices.jsp?commodity=" + commodity + "&Node=" + teasession._nNode + (nexturl != null ? "&nexturl=" + nexturl : ""));
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/buy/EditBuyPrice");
    }
}
