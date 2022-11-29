package tea.ui.node.access;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.access.NodeAccessColumn;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


//bian ji yong hu quan xian
public class EditColumnManage extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            String action = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            // //菜单////////////////////////////////////////////////////////////////////////////////////////////////
            if("editcolumnManage".equals(action)) // 栏目节点编辑
            {
                int id = Integer.parseInt(teasession.getParameter("columnid"));
                NodeAccessColumn obj_nac = NodeAccessColumn.find(id);
                
                obj_nac.name = teasession.getParameter("name");
                obj_nac.node = Integer.parseInt(teasession.getParameter("node"));
                obj_nac.source = teasession.getParameter("source");
                obj_nac.community = teasession._strCommunity;
                obj_nac.set();
                
                //更新当前栏目节点总访问点击量
                NodeAccessColumn.updateByNode(" AND columnid="+obj_nac.columnid);
            } else if("deletecolumnManage".equals(action)) // 删除栏目节点
            {
                int columnid = Integer.parseInt(teasession.getParameter("columnid"));
                NodeAccessColumn obj_nac = NodeAccessColumn.find(columnid);
                obj_nac.delete();
            }else if("check_node".equals(action))
            {
            	int columnid = Integer.parseInt(teasession.getParameter("columnid"));
            	int node = Integer.parseInt(teasession.getParameter("node"));
            	
            	NodeAccessColumn obj_nac = NodeAccessColumn.find(columnid);
            	if(node!=obj_nac.node){
            		out.print(NodeAccessColumn.findByNode(node,teasession._strCommunity)==null);
            	}
            	return;
            }else if("check_source".equals(action))
            {
            	int columnid = Integer.parseInt(teasession.getParameter("columnid"));
            	String source = teasession.getParameter("source");
            	
            	NodeAccessColumn obj_nac = NodeAccessColumn.find(columnid);
            	if(!source.equals(obj_nac.source)){
            		out.print(NodeAccessColumn.findBySource(source,teasession._strCommunity)==null);
            	}
            	return;
            }
            
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    
}
