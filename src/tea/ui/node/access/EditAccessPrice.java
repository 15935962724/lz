package tea.ui.node.access;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditAccessPrice extends TeaServlet
{

    public EditAccessPrice()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() > 1)
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Currency");
            if(request.getMethod().equals("GET"))
            {
                boolean flag = s == null;
                if(flag)
                {
                    response.sendRedirect("/jsp/access/EditAccessPrice.jsp?node=" + teasession._nNode);
                } else
                {
                    response.sendRedirect("/jsp/access/EditAccessPrice.jsp?node=" + teasession._nNode + "&Currency=" + s);
                }
                /*
                                 int j = 0;
                                 BigDecimal bigdecimal1 = new BigDecimal(0.0D);
                                 if (!flag)
                                 {
                    j = Integer.parseInt(s);
                    bigdecimal1 = AccessPrice.find(teasession._nNode, j).getPrice();
                                 }
                                 Form form = new Form("foEdit", "POST", "EditAccessPrice");
                                 form.setOnSubmit("return(submitFloat(this.Price,'" + super.r.getString(teasession._nLanguage, "InvalidPrice") + "')" + ");");
                                 form.add(new HiddenField("Node", teasession._nNode));
                                 if (flag)
                                 {
                    form.add(new HiddenField("New", "ON"));
                                 }
                                 Table table = new Table();
                                 table.add(new CurrencySelection(teasession._nLanguage, j, !flag));
                                 Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Price") + ":"), true));
                                 row.add(new Cell(new TextField("Price", bigdecimal1, 4)));
                                 table.add(row);
                                 form.add(table);
                                 form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                 PrintWriter printwriter = response.getWriter();
                                 printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                 printwriter.print(form);
                                 printwriter.print(new Script("document.foEdit.Price.focus();"));
                                 printwriter.close();
                 */
            } else
            {
                int i = Integer.parseInt(s);
                BigDecimal bigdecimal = null;
                try
                {
                    bigdecimal = new BigDecimal(request.getParameter("Price"));
                } catch(Exception _ex)
                {}
                if(bigdecimal == null)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidPrice"));
                    return;
                }
                if(request.getParameter("New") != null)
                {
                    AccessPrice.create(teasession._nNode,i,bigdecimal);
                } else
                {
                    AccessPrice.find(teasession._nNode,i).set(bigdecimal);
                }
                response.sendRedirect("AccessPrices?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/access/EditAccessPrice");
    }
}
