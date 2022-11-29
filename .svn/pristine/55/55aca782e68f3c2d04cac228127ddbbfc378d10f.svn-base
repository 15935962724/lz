package tea.ui.node.access;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.entity.node.access.NodeAccessColumn;
import tea.entity.site.DNS;
import tea.ui.TeaServlet;


//bian ji yong hu quan xian
public class ColumnInterception extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String sn=request.getServerName();
        DNS obj;
        String community=null;
		try {
			obj = DNS.find(sn);
			if(!obj.isExists())
	        {
	          obj=DNS.find("%");
	        }
	        if(obj.isExists())
	        {
	          community=obj.getCommunity();
	        }
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        //TeaSession teasession = new TeaSession(request);
        
        //String uri = request.getRequestURI();
        //String source = uri.substring(1,uri.indexOf("."));
        String source = request.getParameter("source");
        String queryParam = request.getParameter("queryParam");
        //System.out.println("source::"+source);
		//System.out.println("queryParam:"+queryParam);
        try {
			ArrayList al = NodeAccessColumn.find(" AND source="+DbAdapter.cite(source)+" AND community="+DbAdapter.cite(community),0,1);
			if(al.size()>0){
				NodeAccessColumn nac = (NodeAccessColumn)al.get(0);
				RequestDispatcher   requestDispatcher=request.getRequestDispatcher("/html/"+community+"/node/"+nac.node+"-1.htm"+(queryParam!=null&&!queryParam.equals("")?"?source="+source+"&"+queryParam:"?"));
				requestDispatcher.forward(request,response);
				//response.sendRedirect("/html/"+community+"/node/"+nac.node+"-1.htm");
	            return;
			}else{
				RequestDispatcher   requestDispatcher=request.getRequestDispatcher("/jsp/info/error/404.jsp");   
				requestDispatcher.forward(request,response);
				//response.sendRedirect("/jsp/info/error/404.jsp");
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
    }

    
}
