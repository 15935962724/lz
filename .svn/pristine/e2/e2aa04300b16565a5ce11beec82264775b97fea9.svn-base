package tea.ui.node.type.bid;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.BidPrice;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.CurrencySelection;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditBidPrice extends TeaServlet
{

    public EditBidPrice()
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
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>1)
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/bid/EditBidPrice.jsp" + qs);

//                String s = request.getParameter("Currency");
//                boolean flag = s == null;
//                int j = 0;
//                BigDecimal bigdecimal2 = new BigDecimal(0.0D);
//                BigDecimal bigdecimal4 = new BigDecimal(0.0D);
//                BigDecimal bigdecimal6 = new BigDecimal(0.0D);
//                BigDecimal bigdecimal8 = new BigDecimal(0.0D);
//                BigDecimal bigdecimal10 = new BigDecimal(0.0D);
//                if (!flag)
//                {
//                    j = Integer.parseInt(s);
//                    BidPrice bidprice1 = BidPrice.find(teasession._nNode, j);
//                    bigdecimal2 = bidprice1.getSupply();
//                    bigdecimal4 = bidprice1.getList();
//                    bigdecimal6 = bidprice1.getAsk();
//                    BigDecimal bigdecimal9 = bidprice1.getReserve();
//                    bigdecimal10 = bidprice1.getIncrement();
//                }
//                Form form = new Form("foEdit", "POST", "EditBidPrice");
//                form.setOnSubmit("return(submitFloat(this.Supply,'" + super.r.getString(teasession._nLanguage, "InvalidSupply") + "')" + "&&submitFloat(this.List,'" + super.r.getString(teasession._nLanguage, "InvalidList") + "')" + "&&submitFloat(this.Ask,'" + super.r.getString(teasession._nLanguage, "InvalidAsk") + "')" + "&&submitFloat(this.Reserve,'" + super.r.getString(teasession._nLanguage, "InvalidReserve") + "')" + "&&submitFloat(this.Increment,'" +
//                                 super.r.getString(teasession._nLanguage, "InvalidIncrement") + "')" + ");");
//                form.add(new HiddenField("Node", teasession._nNode));
//                if (flag)
//                {
//                    form.add(new HiddenField("New", "ON"));
//                }
//                Table table = new Table();
//                table.add(new CurrencySelection(teasession._nLanguage, j, !flag));
//                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Supply") + ":"), true));
//                row.add(new Cell(new TextField("Supply", bigdecimal2, 4)));
//                table.add(row);
//                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "List") + ":"), true));
//                row1.add(new Cell(new TextField("List", bigdecimal4, 4)));
//                table.add(row1);
//                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Ask") + ":"), true));
//                row2.add(new Cell(new TextField("Ask", bigdecimal6, 4)));
//                table.add(row2);
//                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Reserve") + ":"), true));
//                row3.add(new Cell(new TextField("Reserve", bigdecimal6, 4)));
//                table.add(row3);
//                Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Increment") + ":"), true));
//                row4.add(new Cell(new TextField("Increment", bigdecimal10, 4)));
//                table.add(row4);
//                form.add(table);
//                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
//                PrintWriter printwriter = response.getWriter();
//                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
//                printwriter.print(form);
//                printwriter.print(new Script("document.foEdit.List.focus();"));
//                printwriter.print(new Languages(teasession._nLanguage, request));
//                printwriter.close();
            } else
            {
                int i = Integer.parseInt(request.getParameter("Currency"));
                BigDecimal bigdecimal = null;
                try
                {
                    bigdecimal = new BigDecimal(request.getParameter("Supply"));
                } catch (Exception _ex)
                {}
                BigDecimal bigdecimal1 = null;
                try
                {
                    bigdecimal1 = new BigDecimal(request.getParameter("List"));
                } catch (Exception _ex)
                {}
                BigDecimal bigdecimal3 = null;
                try
                {
                    bigdecimal3 = new BigDecimal(request.getParameter("Ask"));
                } catch (Exception _ex)
                {}
                BigDecimal bigdecimal5 = null;
                try
                {
                    bigdecimal5 = new BigDecimal(request.getParameter("Reserve"));
                } catch (Exception _ex)
                {}
                BigDecimal bigdecimal7 = null;
                try
                {
                    bigdecimal7 = new BigDecimal(request.getParameter("Increment"));
                } catch (Exception _ex)
                {}
                if (bigdecimal == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSupply"));
                    return;
                }
                if (bigdecimal1 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidList"));
                    return;
                }
                if (bigdecimal3 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidAsk"));
                    return;
                }
                if (bigdecimal5 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidReserve"));
                    return;
                }
                if (bigdecimal7 == null)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidIncrement"));
                    return;
                }
                if (request.getParameter("New") != null)
                {
                    BidPrice.create(teasession._nNode, i, bigdecimal, bigdecimal1, bigdecimal3, bigdecimal5, bigdecimal7);
                } else
                {
                    BidPrice bidprice = BidPrice.find(teasession._nNode, i);
                    bidprice.set(bigdecimal, bigdecimal1, bigdecimal3, bigdecimal5, bigdecimal7);
                }
                response.sendRedirect("BidPrices?node=" + teasession._nNode);
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/bid/EditBidPrice");
    }
}
