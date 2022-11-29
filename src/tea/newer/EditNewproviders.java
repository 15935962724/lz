package tea.newer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

/**
 * Servlet implementation class EditNewproviders
 */
public class EditNewproviders extends TeaServlet {
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try{
        	int nid=0;
        	String s=teasession.getParameter("nid");
        	if(teasession.getParameter("nid")!=null){
        		nid=Integer.parseInt(teasession.getParameter("nid"));
        	}
        	String act=teasession.getParameter("act");
        	String nexturl="";
        	if(teasession.getParameter("nexturl")!=null){
        		nexturl=teasession.getParameter("nexturl");
        	}
        	if("delete".equals(act)){
        		Newproviders np=Newproviders.finds(nid);
        		np.delete();
            	response.sendRedirect(nexturl);
        	}else if("add".equals(act)||"edit".equals(act)){
        		String nname=teasession.getParameter("nname");
        		Newproviders np=new Newproviders(nid,nname);
        		np.set();
            	response.sendRedirect(nexturl);
        	}else if("changeprovide".equals(act)){
        		String nname=teasession.getParameter("nname");
        		List list=Newproviders.findList(" AND nname like "+DbAdapter.cite("%"+nname.trim()+"%"), 0, 10);
        		out.print("<div id=xilidiv2>");
        	    out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable2\" onMouseOut=\"\" onMouseOver=\"\" >" );
        		Iterator it=list.iterator();
        		while(it.hasNext()){
        			Newproviders np=(Newproviders) it.next();
        			out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=\"setprovide('"+np.getNname()+"')\">");
    		        out.print("<td>");
    		        out.print(np.getNname());
    		        out.print("</td>");
    		        out.print("</tr>");
        		}
        		out.print("</table></div>");
        		return;
        	}
        }catch(Exception ex){
        	response.sendError(400,ex.getMessage());
        	ex.printStackTrace();
        }finally{
        	out.close();
        }
	}

}
