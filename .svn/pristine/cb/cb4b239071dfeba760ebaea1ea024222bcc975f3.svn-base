package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyInstruction;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BuyInstructions extends TeaServlet
{

    public BuyInstructions()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {

            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/profile/BuyInstructions.jsp" + qs);

            /*
                         TeaSession teasession = new TeaSession(request);
                         if(teasession._rv == null)
                         {
               response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
               return;
                         }
                         Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "BuyInstructions"));
                         text.setId("PathDiv");
                         Table table = new Table();
                         int i = BuyInstruction.count(teasession._rv._strR);
                         table.setCaption(i + " " + super.r.getString(teasession._nLanguage, "BuyInstructions"));
                         if(i != 0)
                         {
               table.setTitle(super.r.getString(teasession._nLanguage, "Currency") + "\n");
               Row row;
               for(Enumeration enumeration = BuyInstruction.find(teasession._rv._strR); enumeration.hasMoreElements(); table.add(row))
               {
                   int j = ((Integer)enumeration.nextElement()).intValue();
                   BuyInstruction buyinstruction = BuyInstruction.find(j);
                   row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[buyinstruction.getCurrency()]))));
                   row.add(new Cell(new Text("  ")));
                   row.add(new Cell(new Text(buyinstruction.getText(teasession._nLanguage))));
                   row.add(new Cell(new Text("  ")));
                   row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditBuyInstruction?BuyInstruction=" + j + "', '_self');")));
                   if(buyinstruction.isLayerExisted(teasession._nLanguage))
                       row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteBuyInstruction?BuyInstruction=" + j + "', '_self');}")));
               }

                         }
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(text);
                         printwriter.print(table);
                         printwriter.print(new Break());
                         printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditBuyInstruction', '_self');"));
                         printwriter.print(new Languages(teasession._nLanguage, request));
                         printwriter.close();
             */
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
//        super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/BuyInstructions");
    }
}
