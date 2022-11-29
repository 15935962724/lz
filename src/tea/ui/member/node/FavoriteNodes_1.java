package tea.ui.member.node;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Favorite;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class FavoriteNodes_1 extends TeaServlet {

	public FavoriteNodes_1() {
	}

	public void service(HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException,
			IOException {
		httpservletresponse.sendRedirect(httpservletrequest.getContextPath()
				+ "/jsp/node/FavoriteNodes_1.jsp");
		/*
		 * try { TeaSession teasession = new TeaSession(httpservletrequest);
		 * 
		 * if (teasession._rv == null) { outLogin(httpservletrequest,
		 * httpservletresponse, teasession); return; } Text text = new
		 * Text(hrefGlance(teasession._rv, httpservletrequest.getContextPath()) +
		 * ">" + new Anchor("Nodes", super.r.getString(teasession._nLanguage,
		 * "Nodes")) + ">" + super.r.getString(teasession._nLanguage,
		 * "FavoriteNodes")); text.setId("PathDiv"); String s =
		 * httpservletrequest.getParameter("Pos"); int i = s == null ? 0 :
		 * Integer.parseInt(s); int j = Favorite.countNodes(teasession._rv);
		 * Table table = new Table(); table.setCaption(j + " " +
		 * super.r.getString(teasession._nLanguage, "FavoriteNodes")); Row row;
		 * for (Enumeration enumeration = Favorite.findNodes(teasession._rv, i,
		 * 25); enumeration.hasMoreElements(); table.add(row)) { int k =
		 * ((Integer) enumeration.nextElement()).intValue(); row = new Row(new
		 * Cell(Node.find(k).getAncestor(teasession._nLanguage))); row.add(new
		 * Cell(new Button(1, "CB", "CBDelete",
		 * super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" +
		 * super.r.getString(teasession._nLanguage, "ConfirmDelete") +
		 * "')){window.open('DeleteFavorite?Node=" + k + "', '_self');}"))); }
		 * 
		 * PrintWriter printwriter = beginOut(httpservletresponse, teasession);
		 * printwriter.print(text); printwriter.print(table);
		 * printwriter.print(new FPNL(teasession._nLanguage,
		 * "FavoritesNodes?Pos=", i, j)); printwriter.print(new
		 * Languages(teasession._nLanguage, httpservletrequest));
		 * endOut(printwriter, teasession); } catch (Exception exception) {
		 * httpservletresponse.sendError(400, exception.toString());
		 * exception.printStackTrace(); }
		 */
	}

	public void init(ServletConfig servletconfig) throws ServletException {
		super.init(servletconfig);
		super.r.add("tea/ui/member/node/Nodes").add(
				"tea/ui/member/node/FavoriteNodes");
	}
}
