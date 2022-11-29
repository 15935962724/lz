package tea.ui.node.talkback;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.Node;
import tea.entity.node.Talkback;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteTalkback extends TeaServlet
{

    public DeleteTalkback()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String act = request.getParameter("act");
            String value[] = request.getParameterValues("talkback");
            String nu = request.getParameter("nexturl");
            if(nu == null)
            {
                nu = "/jsp/talkback/Talkbacks.jsp?node=" + teasession._nNode;
            }
            if(value != null)
            {
            	String next_str ="操作成功";
            	//boolean f = false;
                for(int index = 0;index < value.length;index++)
                {
                    int i = Integer.parseInt(value[index]);
                    Talkback talkback = Talkback.find(i);
                    Node node = Node.find(talkback.getNode());
                    AccessMember obj_am = AccessMember.find(node._nNode,teasession._rv.toString());
                    if(!node.isCreator(teasession._rv) && !talkback.isCreator(teasession._rv) && !teasession._rv.isOrganizer(node.getCommunity()) && !teasession._rv.isWebMaster() && obj_am.getPurview() < 2)
                    {
                        response.sendError(403);
                        return;
                    }
                    if("delete".equals(act))
                    {
                        talkback.delete();
                       // next_str ="删除操作成功";

                    }else if("audit".equals(act))//审核 显示
                    {
                    	if(talkback.getHidden()==0)
                    	{
                    		// next_str ="审核操作成功";
                    		 talkback.setHidden(1);
                    		 talkback.set(teasession._rv.toString(),new Date());
                    	}else
                    	{
                    		next_str ="抱歉!您审核的评论里面有【已审核或已拒绝】的评论.\\n系统只能审核【未审核】的评论!";
                    	}
                    }else if("cancel_audit".equals(act))//还原
                    {
                    	if(talkback.getHidden()!=0)
                    	{
                    		// next_str ="还原操作成功";
                    		 talkback.setHidden(0);
                    		 talkback.set("",null);
                    	}else
                    	{
                    		next_str ="抱歉!您还原的评论里面有【未审核】的评论.\\n系统只能还原【已审核或已拒绝】的评论!";
                    	}
                    } else if("refusal".equals(act))//拒绝
                    {
                    	if(talkback.getHidden()==2)
                    	{
                    		next_str ="抱歉!您拒绝的评论里面有【拒绝】的评论.\\n系统只能拒绝【未拒绝】的评论!";
                    	}else
                    	{
                    		// next_str ="拒绝操作成功";
                    		 talkback.setHidden(2);
                    		 talkback.set(teasession._rv.toString(),new Date());
                    	}
                    }
                    else
                    {
                    	if(talkback.getHidden()==0)
                    	{
                    		talkback.setHidden(1);
                    	}else
                    	{
                    		talkback.setHidden(0);
                    	}

                    }

                    Node.find(node._nNode).setUpdatetime(new Date());
                    delete(Node.find(node._nNode));

                }
				java.io.PrintWriter out = response.getWriter();
				out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nu + "';</script> ");
				out.close();
				return;
            }


            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
