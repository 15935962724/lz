package tea.ui.node.type.messageboard;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;
import tea.entity.member.*;
import tea.entity.site.*;
import tea.service.*;
import tea.entity.RV;

public class EditMessageBoard extends tea.ui.TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);

            if((node.getOptions1() & 1) == 0)
            {
            	System.out.println("true"+teasession._nNode);
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(73))
                {
                    response.sendError(403);
                    return;
                }
            } else if(teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }
            HttpSession session = request.getSession();
            String text = teasession.getParameter("content");
            String act = request.getParameter("act");
            String nu = teasession.getParameter("nexturl");
            if(nu == null)
            {
                nu = "/servlet/MessageBoard?node=" + teasession._nNode;
            }

            if("editreply".equals(act))
            {
                if(Integer.parseInt(request.getParameter("TextOrHtml")) == 0)
                {
                    text = text.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;");
                }
                boolean hidden = "true".equals(request.getParameter("hidden"));
                // boolean send = "true".equals(request.getParameter("send"));

                String send = request.getParameter("send");

                if(send != null)
                {
                    Profile profile1 = Profile.find(node.getCreator()._strR);
                    String s11 = profile1.getMember();
                    Message.create(teasession._strCommunity,teasession._rv._strV,s11,teasession._nLanguage,"回复:" + node.getSubject(teasession._nLanguage),"<font color=red>您的回复是：</font>" + text + "<hr>" + node.getText(teasession._nLanguage));
                    
                }
                MessageBoard mb=MessageBoard.find(teasession._nNode, teasession._nLanguage);
                Community c=Community.find(teasession._strCommunity);
                Email.create(teasession._strCommunity, null, mb.getEmail(), c.getName(teasession._nLanguage)+":关于"+node.getSubject(teasession._nLanguage)+"的回复",text );
                MessageBoardReply.create(teasession._nNode,teasession._nLanguage,teasession._rv._strV,text,hidden);
            } else if("deletereply".equals(act))
            {
                String mbrs[] = request.getParameterValues("messageboardreply");
                if(mbrs != null)
                {
                    for(int i = 0;i < mbrs.length;i++)
                    {
                        int messageboardreply = Integer.parseInt(mbrs[i]);
                        MessageBoardReply obj = MessageBoardReply.find(messageboardreply);
                        obj.delete();
                    }
                }
            } else if("edit".equals(act))
            {
                out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
                Http h = new Http(request,response);
                String info = h.get("info");
                String subject = h.get("subject");

                String ip = request.getRemoteAddr();
                String scontent=h.get("scontent");
//                if(MessageBoard.isADD(ip,subject))
//                {
//                	if(scontent!=null&&scontent.trim().length()>0){
//                		out.print("<script>mt.show('"+scontent+"');</script>");
//                	}else{
//                		out.print("<script>mt.show('不能重复添加主题！');</script>");
//                	}
//                    return;
//                }

                String sv = (String) session.getAttribute("sms.vertify");
                String vertify = h.get("vertify");
                String vcontent =h.get("vertifyContent");
                if(vertify == null || !vertify.trim().equalsIgnoreCase(sv))
                {
                	if(vcontent!=null&&vcontent.trim().length()>0){
                		out.print("<script>mt.show('"+vcontent+"');</script>");
                	}else{
                		out.print("<script>mt.show('“验证码”错误，请重新输入！');</script>");
                	}
                    return;
                }
                session.removeAttribute("vertify");
                String address = h.get("address");
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = node.getOptions1();
                    int defautllangauge = node.getDefaultLanguage();
                    Category obj = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,obj.getCategory(),(options1 & 2) != 0,node.getOptions(),options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,null,"",text,null,"",0,null,"","","","",null,null);
                    node=Node.find(teasession._nNode);
                } else
                {
                    node.set(teasession._nLanguage,subject,text);
                }
                node.set("description", teasession._nLanguage, address);
                int hint = h.getInt("hint");
                String phone = h.get("phone");
                String mobile = h.get("mobile");
                String email = h.get("email");
                String name = h.get("name");
                int age = h.getInt("age");
                int sex = h.getInt("sex");
                MessageBoard obj = MessageBoard.find(teasession._nNode,teasession._nLanguage);
                obj.set(hint,phone,mobile,email,name,ip,age,sex);
                delete(node);
                node.finished(teasession._nNode);
                String nexturl = h.get("nexturl","location.reload()");
                out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
                return;
            } else
            {
                /*
                   CommunityOption co = CommunityOption.find(teasession._strCommunity);
                   String mb = co.get("msgboptions");
                   if(mb != null && mb.indexOf("/1/") != -1)
                   {
                       String v = (String) session.getAttribute("sms.vertify");
                       session.removeAttribute("sms.vertify");
                       if(v == null || !v.equals(teasession.getParameter("vertify")))
                       {
                           response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"验正证错误!!!"),"UTF-8"));
                           return;
                       }
                   }
                 */
                //验证码
                String ip = request.getRemoteAddr();
                String subject = teasession.getParameter("subject");

                // 同一个IP 和标题的不能添加
                if(MessageBoard.isADD(ip,subject))
                {
                    out.print("<script>alert('不能重复添加主题');window.location.href='/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "';</script> ");
                    return;
                }

                String vertify_alter = "验证码错误，请重新输入";
                if((teasession.getParameter("vertify_alter") != null) && (teasession.getParameter("vertify_alter").length() > 0))
                {
                    vertify_alter = teasession.getParameter("vertify_alter");
                }
                String sv = (String) session.getAttribute("sms.vertify");
                String vertify = request.getParameter("vertify");
                if(vertify != null)
                {
                    if(!vertify.trim().equalsIgnoreCase(sv))
                    {
                        session.removeAttribute("vertify"); //退出session
                        out.print("<script>alert('" + vertify_alter + "');window.location.href='/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "';</script>");
                        return;
                    }
                } else
                {
                    out.print("<script>alert('" + vertify_alter + "');window.location.href='/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "';</script> ");
                    return;
                }

                if(subject == null || subject.length() < 1)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidSubject"),"UTF-8"));
                    return;
                }
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = node.getOptions1();
                    int defautllangauge = node.getDefaultLanguage();
                    Category obj = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,obj.getCategory(),(options1 & 2) != 0,node.getOptions(),options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,null,"",text,null,"",0,null,"","","","",null,null);
                } else
                {
                    node.set(teasession._nLanguage,subject,text);
                }
                int hint = 0;
                String tmp = request.getParameter("hint");
                if(tmp != null)
                {
                    hint = Integer.parseInt(tmp);
                }
                String phone = request.getParameter("phone");
                String mobile = request.getParameter("mobile");
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                int sex = 0;
                if(request.getParameter("sex") != null)
                {
                    sex = Integer.parseInt(request.getParameter("sex"));
                }
                int age = 18;
                if(request.getParameter("age") != null)
                {
                    age = Integer.parseInt(request.getParameter("age").trim());
                }
                MessageBoard obj = MessageBoard.find(teasession._nNode,teasession._nLanguage);
                obj.set(hint,phone,mobile,email,name,ip,age,sex);
                delete(node);

                node.finished(teasession._nNode);

                boolean flag3 = teasession.getParameter("MsgOSendEmail") != null; // ????E-MAIL????
                if(flag3)
                {
                    Profile profile1 = Profile.find(node.getCreator()._strR);
                    String s11 = profile1.getEmail();
                    String cc = request.getParameter("cc");
                    String bcc = request.getParameter("bcc");
                    SendEmaily se = new SendEmaily(teasession._strCommunity);
                    se.sendEmail(email,s11,subject,text);
                }
                nu = "/servlet/MessageBoard?node=" + teasession._nNode;
            }

            if(nu.startsWith("javascript:"))
            {
                out.write("<script>" + nu.substring(11) + "</script>");
            } else
            {
                response.sendRedirect(nu);
            }
        } catch(Exception ex)
        {
            response.sendError(400,ex.toString());
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
