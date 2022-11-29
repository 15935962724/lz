package tea.ui.node.talkback;

import java.io.IOException;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.member.Message;
import tea.entity.node.Node;
import tea.entity.node.Report;
import tea.entity.node.Talkback;
import tea.entity.site.Community;
//import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditTalkback extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        r.add("/tea/resource/Photography");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            boolean flagl = (node.getOptions() & 0x8000) != 0; //ANONYMITY评论

            String nexturl = teasession.getParameter("nexturl");

            /*
                if(teasession._rv == null)
                {
             if(!flagl)
             {
              outLogin(request,response,teasession);
              return;
             }
             teasession._rv = RV.ANONYMITY;
                }
             */

            String act = teasession.getParameter("act");
            if("EditTalkback".equals(act)) //后台审核使用
            {
                String tmp = teasession.getParameter("hint");
                int hint = tmp == null ? 0 : Integer.parseInt(tmp);
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                int hidden = Integer.parseInt(teasession.getParameter("hidden"));

                int tkid = Integer.parseInt(teasession.getParameter("tkid"));
                Talkback tobj = Talkback.find(tkid);
                if(tkid > 0)
                {
                    tobj.set(hint,tobj.country,teasession._nLanguage,subject,content,null,null,null,null);
                    tobj.setHidden(hidden);
                    tobj.set(teasession._rv.toString(),new Date());
                }

                java.io.PrintWriter out = response.getWriter();
                out.print("<script  language='javascript'>alert('操作成功');window.location.href='" + nexturl + "';</script> ");
                out.close();
                return;

            } else if("TalkbackAdmin".equals(act))
            {
                int hint = Integer.parseInt(teasession.getParameter("hint"));
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");

                Talkback.create(teasession._nNode,teasession._rv._strR,teasession._rv._strV,hint,0,1,request.getRemoteAddr(),teasession._nLanguage,subject,content,null,null,null,null,null,null,null,null,null);
                java.io.PrintWriter out = response.getWriter();
                out.print("<script  language='javascript'>alert('评论操作成功');window.location.href='" + nexturl + "';</script> ");
                out.close();
                return;

            } else //前台评论使用
            {
                HttpSession session = request.getSession(true);
                String userR = session.getId();
                String userV = session.getId();
                String tourist = teasession.getParameter("tourist"); //是否选中游客评论
                if(tourist != null && tourist.length() > 0) //选中了直接评论
                {
                    userR = "游客";
                    userV = "游客";
                } else if(!flagl)
                { //需要登录 评论

                    if(teasession._rv == null)
                    {
                        response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                        return;
                    } else
                    {
                        userR = teasession._rv._strR;
                        userV = teasession._rv._strV;
                    }
                } else if(teasession._rv != null)
                {
                    userR = teasession._rv._strR;
                    userV = teasession._rv._strV;

                }
                //判断验证码


                String sv = (String) session.getAttribute("sms.vertify");
                String vertify = request.getParameter("vertify");
                /*if(vertify != null)
                {
                    if(!vertify.trim().equalsIgnoreCase(sv))
                    {
                        //session.removeAttribute("vertify"); //退出session
                        session.removeAttribute("sms.vertify");
                        if(teasession.getParameter("act") != null && "fa_en".equals(teasession.getParameter("act"))) //英文
                        {
                            // response.sendRedirect("/jsp/info/Alert.jsp?info=Sorry! There's an error in the verification code. Please add-up the numbers again&nexturl=" + teasession.getParameter("nexturl"));

                            java.io.PrintWriter out = response.getWriter();

                            out.print("<script  language='javascript'>alert('Sorry! There\\'s an error in the verification code. Please add-up the numbers again');window.location.href='" + teasession.getParameter("nexturl") + "';</script> ");
                            out.close();
                            return;

                        } else
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"4746026465"),"UTF-8") + "&nexturl=" + teasession.getParameter("nexturl"));
                            return;
                        }
                    }
                } else
                {
                    if(teasession.getParameter("act") != null && "fa_en".equals(teasession.getParameter("act"))) //英文
                    {
                        //response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(0,"2371417939"),"UTF-8") + "&nexturl=" + teasession.getParameter("nexturl"));
                        //	return;

                        java.io.PrintWriter out = response.getWriter();

                        out.print("<script  language='javascript'>alert('" + r.getString(0,"2371417939") + "');window.location.href='" + teasession.getParameter("nexturl") + "';</script> ");
                        out.close();
                        return;

                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"2371417939"),"UTF-8") + "&nexturl=" + teasession.getParameter("nexturl"));
                        return;
                    }

                }*/

                int talkback = 0;

                if(teasession.getParameter("talkback") != null && teasession.getParameter("talkback").length() > 0)
                {
                    talkback = Integer.parseInt(teasession.getParameter("talkback"));
                }
                if(talkback > 0)
                {
                    Talkback obj = Talkback.find(talkback);
                    if(!obj.isCreator(teasession._rv))
                    {
                        response.sendError(403);
                        return;
                    }
                }

                if(request.getMethod().equals("GET"))
                {
                    response.sendRedirect("/jsp/talkback/EditTalkback.jsp?node=" + teasession._nNode);
                    return;
                }
                int hint = 0;

                if(teasession.getParameter("hint") != null && teasession.getParameter("hint").length() > 0)
                {
                    hint = Integer.parseInt(teasession.getParameter("hint"));
                }
                String subject = teasession.getParameter("subject");
                if(subject == null || subject.length() < 1)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSubject"));
                    return;
                }
                String tmp = teasession.getParameter("country");
                int country = tmp == null || tmp.length() < 1 ? 0 : Integer.parseInt(tmp);
                String ip = request.getRemoteAddr();
                String content = teasession.getParameter("content");
                content = Report.getHtml2(content);

                if(Talkback.isADD(ip,content))
                {

                    java.io.PrintWriter out = response.getWriter();

                    out.print("<script  language='javascript'>alert('您不能重复评论');window.location.href='" + teasession.getParameter("nexturl") + "';</script> ");
                    out.close();
                    return;
                }

                ///

                Community community = Community.find(node.getCommunity());
                /*
                     if(community.filtrate!=null && community.filtrate.length()>0){
                 if(Pattern.compile(community.filtrate.replace(',','|')).matcher(content).find())
                 {
                  super.outText(teasession,response,r.getString(teasession._nLanguage,"InvalidTextIllegal"));
                  return;
                 }
                     }
                 */

                //
                String picture = teasession.getParameter("picture");
                if(teasession.getParameter("clearpicture") != null)
                {
                    picture = "";
                }
                String voice = teasession.getParameter("voice");;
                if(teasession.getParameter("clearvoice") != null)
                {
                    voice = "";
                }
                String file = null;
                String filename = teasession.getParameter("fileName");
                byte abyte2[] = teasession.getBytesParameter("file");
                if(abyte2 != null)
                {
                    file = write(teasession._strCommunity,abyte2,"." + filename.substring(filename.lastIndexOf(".") + 1));
                } else if(teasession.getParameter("clearfile") != null)
                {
                    file = "";
                }
                //
                String name = teasession.getParameter("name"); //姓名
                String address = teasession.getParameter("address"); //地址
                String zip = teasession.getParameter("zip"); //邮编
                String telephone = teasession.getParameter("telephone"); //联系电话
                String email = teasession.getParameter("email");
                int hidden = 1;
                // System.out.println((Node.find(node.getFather()).getOptions() & 0x10000000L)+"--"+Node.find(node.getFather()).getOptions());
                if((Node.find(node.getFather()).getOptions() & 0x10000000L) != 0)
                {
                    hidden = 0;
                }

                if(talkback == 0)
                {
                    Talkback.create(teasession._nNode,userR,userV,hint,country,hidden,ip,teasession._nLanguage,subject,content,name,address,zip,telephone,email,picture,voice,filename,file);
                } else
                {
                    Talkback obj = Talkback.find(talkback);
                    obj.set(hint,country,teasession._nLanguage,subject,content,picture,voice,file,filename);
                }
                ///
                String s8 = teasession.getParameter("cc");
                String s9 = teasession.getParameter("bcc");
                // s6 = "<a href='http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/servlet/Node?node=" + teasession._nNode + "'>" + s4 + "</a><br>" + s6;

                boolean flag2 = teasession.getParameter("msgOsendmessage") != null; // 发送信息
                boolean flag3 = teasession.getParameter("msgOsendemail") != null; // 同时按E-MAIL发送
                if(flag2)
                {
                    Message.create(teasession._strCommunity,teasession._rv._strV,node.getCreator()._strR,teasession._nLanguage,subject,content);
                }
                if(flag3)
                {
                    content = "&#37038;&#20214;&#26469;&#28304;:" + community.getName(teasession._nLanguage) + "<BR><BR>" + content; // 邮件来源
                    int k = Message.create(teasession._strCommunity,teasession._rv._strV,node.getCreator()._strR,teasession._nLanguage,subject,content);
                    try
                    {
                        //Robot.activateRoboty(teasession._nNode,k);
                    } catch(Exception _ex)
                    {
                    }
                }
                delete(node);
                String nu = teasession.getParameter("nexturl");
                if(nu == null)
                {
                    nu = "/jsp/talkback/Talkbacks.jsp?node=" + teasession._nNode;
                }
                if("fa".equals(teasession.getParameter("act")))
                {
                    java.io.PrintWriter out = response.getWriter();

                    out.print("<script  language='javascript'>alert('" + r.getString(teasession._nLanguage,"5958149074") + "!');window.location.href='" + nu + "';</script> ");
                    out.close();
                    return;

                } else if("fa_en".equals(teasession.getParameter("act"))) //英文
                {
                    java.io.PrintWriter out = response.getWriter();

                    out.print("<script  language='javascript'>alert('" + r.getString(0,"5958149074") + "!');window.location.href='" + nu + "';</script> ");
                    out.close();
                    return;
                }else if("GolfTalkback".equals(teasession.getParameter("act")))
                {
                	//评论球场的评论
                	java.io.PrintWriter out = response.getWriter();
                	out.print("<script src=/tea/tea.js type=text/javascript></script>");
                    out.print("<script>");

                    out.print("alert('评论信息添加成功!');");
                    out.print("parent.mt.close();");
                    out.print("parent.window.location.reload();");
                    out.print("</script>");
                    out.close();
                    return;
                }

                response.sendRedirect(nu);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的评论出错了,请重新上传&nbsp;<a href=# onClick=\"javascript:history.back()\">返回</a>.","UTF-8"));
            //response.sendError(400,exception.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/talkback/EditTalkback");
    }
}
