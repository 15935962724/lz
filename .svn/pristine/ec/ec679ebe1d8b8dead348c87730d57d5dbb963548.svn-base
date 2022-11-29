package tea.ui.node.listing;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPickNode extends TeaServlet
{

    public EditPickNode()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            PickNode obj = null;
            int listing = Integer.parseInt(request.getParameter("listing"));
            int picknode = Integer.parseInt(request.getParameter("picknode"));
            boolean _nNew = picknode == 0;
            if(!_nNew)
            {
                obj = PickNode.find(picknode);
                listing = obj.listing;
            }
            int realnode = Listing.find(listing).getNode();
            if(realnode > 0 && !Node.find(realnode).isCreator(teasession._rv) && AccessMember.find(realnode,teasession._rv).getPurview() < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            int type = Integer.parseInt(teasession.getParameter("type"));
            int bbstype = 0; //Integer.parseInt(teasession.getParameter("bbstype"));//列帖子 精华帖子
            if(teasession.getParameter("bbstype") != null && teasession.getParameter("bbstype").length() > 0)
            {
                bbstype = Integer.parseInt(teasession.getParameter("bbstype"));
            }
            String act = request.getParameter("act");
            if("delete".equals(act))
            {
                obj.delete();
            } else
            {

                int l = Integer.parseInt(request.getParameter("NodeStyle"));

                int j2 = Integer.parseInt(request.getParameter("CreatorStyle"));
                String s4 = request.getParameter("RCreator");
                if(s4 == null) // ��ǰ��Ա
                {
                    s4 = "";
                }
                if((j2 == 1 || j2 == 3) && !Profile.isExisted(s4))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidRCreator"));
                    return;
                }
                String s5 = request.getParameter("VCreator");
                if((j2 == 2 || j2 == 3) && !Profile.isExisted(s5))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidVCreator"));
                    return;
                }
                int i3 = Integer.parseInt(request.getParameter("StartStyle"));
                int k3 = 0;
                try
                {
                    k3 = Integer.parseInt(request.getParameter("StartTerm"));
                } catch(Exception exception1)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidStartTerm"));
                    return;
                }
                int i4 = Integer.parseInt(request.getParameter("StopStyle"));
                int j4 = 0;
                try
                {
                    j4 = Integer.parseInt(request.getParameter("StopTerm"));
                } catch(Exception exception2)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidStopTerm"));
                    return;
                }
                String parameter = request.getParameter("parameter");
                if(_nNew)
                {
                    picknode = PickNode.create(listing,l,type,j2,s4,s5,i3,k3,i4,j4,parameter);
                    obj = PickNode.find(picknode);
                } else
                {
                    obj.set(l,type,j2,s4,s5,i3,k3,i4,j4,parameter);
                }
                obj.set("bbstype",String.valueOf(obj.bbstype = bbstype));
                ListingCache.expire(listing);
                // 255->�������� 0->�ļ��� 1->���
                if(request.getParameter("GoNext") != null && type != 255) // ��һ��
                {
                    if(type >= 65535)
                    {
                        type = TypeAlias.find(type).getType();
                    }
                    String qs;
                    if(_nNew) // ����
                    {
                        qs = "?Listing=" + listing + "&node=" + teasession._nNode + "&PickNode=" + picknode + "&Type=" + type;
                    } else
                    {
                        qs = "?Listing=" + listing + "&node=" + teasession._nNode + "&PickNode=" + picknode + "&Type=" + type + "&edit=ON";
                    }
                    if(type >= 1024)
                    {
                        response.sendRedirect("/jsp/type/dynamicvalue/DynamicValueDetail.jsp" + qs);
                    } else
                    {
                        response.sendRedirect("/jsp/type/" + Node.NODE_TYPE[type].toLowerCase() + "/" + Node.NODE_TYPE[type] + "Detail.jsp" + qs);
                    }
                    return;
                }
            }
            response.sendRedirect("/jsp/listing/Picks.jsp?node=" + teasession._nNode + "&listing=" + listing);

        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

}
