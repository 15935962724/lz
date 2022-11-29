package tea.ui.node.type.dynamicvalue;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.site.*;
import java.sql.SQLException;

public class EditDynamicValue extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        try
        {
            boolean newnode = false;
            Node node = Node.find(teasession._nNode);
            int type = node.getType();
            if(type == 1)
            {
                Category cat = Category.find(teasession._nNode);
                type = cat.getCategory();
                newnode = true;
            }
            boolean editcebbank = teasession.getParameter("EditCebbankDynamicValue") != null; // 光大合同
            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode,teasession._rv._strV).isProvider(type) && !editcebbank)
                {
                    response.sendError(403);
                    return;
                }
            } else if(teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }

            String subject = teasession.getParameter("subject");
            String text = teasession.getParameter("text");
            String keywords = teasession.getParameter("keywords");
            Date date4 = Node.sdf.parse(teasession.getParameter("IssueYear") + "-" + teasession.getParameter("IssueMonth") + "-" + teasession.getParameter("IssueDay"));
            if(newnode)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                int options1 = node.getOptions1();
                teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,type,(options1 & 2) != 0,node.getOptions(),options1,node.getDefaultLanguage(),null,null,date4,0,0,0,0,null,teasession._nLanguage,subject,keywords,"",text,null,"",0,null,"","","","",null,"");
                node.finished(teasession._nNode);
                if(editcebbank) // 光大合同
                {
                    Profile p = Profile.find(teasession._rv._strV);
                    try
                    {
                        Cebbank.create(teasession._nNode,p.getAdminUnit());
                    } catch(Exception ex1)
                    {
                    }
                }
                node = Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage,subject,text);
                node.setTime(date4);
            }
            if(type > 65534)
            {
                type = TypeAlias.find(type).getType();
            }
            delete(node);
            // if (editcebbank) //光大合同
            {
                node.setHidden(teasession.getParameter("GoSave") != null);
            }
            String tmp;
            //绑定的是那个节点/////
            int bindnode = 0;
            tmp = teasession.getParameter("dynamictype" + teasession.getParameter("binding"));
            if(tmp != null && tmp.length() > 0)
            {
                bindnode = Integer.parseInt(tmp);
            }
            Enumeration e = DynamicType.findByDynamic(type);
            while(e.hasMoreElements())
            {
                int id = ((Integer) e.nextElement()).intValue();
                DynamicType dt = DynamicType.find(id);
                DynamicValue dv = DynamicValue.find(teasession._nNode,teasession._nLanguage,id);
                int defv = dt.getDefaultvalue();
                String value = null;
                if("file".equals(dt.getType()) || "img".equals(dt.getType()))
                {
                    byte by[] = teasession.getBytesParameter("dynamictype" + id);
                    if(by != null)
                    {
                        String name = teasession.getParameter("dynamictype" + id + "Name");
                        value = super.write(node.getCommunity(),"dynamic",by,name);
                    } else if(teasession.getParameter("dynamictype_checkbox" + id) == null)
                    {
                        value = dv.getValue();
                    }
                } else
                {
                    value = teasession.getParameter("dynamictype" + id);
                    if(bindnode > 0 && (defv == 8 || defv == 9)) //更改被绑定的值
                    {
                        DynamicValue dv_b = DynamicValue.find(bindnode,teasession._nLanguage,dt.getBinding());
                        try
                        {
                            int vc = Integer.parseInt(value); //绑定的值
                            tmp = dv.getValue();
                            if(tmp != null && tmp.length() > 0) //计算:和上次的差异
                            {
                                vc = vc - Integer.parseInt(tmp);
                            }
                            int vb = Integer.parseInt(dv_b.getValue()); //被绑定的值
                            switch(defv)
                            {
                            case 8: //+
                                vb = vb + vc;
                                break;
                            case 9: //-
                                vb = vb - vc;
                                break;
                            }
                            dv_b.set(String.valueOf(vb));
                        } catch(NumberFormatException ex2)
                        {
                        }
                    }
                }
                dv.set(value);
            }

            String nexturl = teasession.getParameter("nexturl");
            Category cat2 = Category.find(node.getFather());

            if(teasession.getParameter("GoBack") != null)
            {
                nexturl = ("EditNode?node=" + teasession._nNode);
            } else if(nexturl == null)
            {
                nexturl = "Node?node=" + teasession._nNode;
            }
            if(cat2.getClewtype() == 1)
            {
                java.io.PrintWriter out = response.getWriter();
                out.println("<script>alert('" + cat2.getClewcontent() + "');window.location.href='" + nexturl + "';</script>");
                // out.println("<script language = javascript>alert('抱歉!您非本系统用户!');");

                out.flush();
                out.close();
                return;
            }

            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
