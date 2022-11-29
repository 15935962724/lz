package tea.ui.node.type.poll;

import java.io.IOException;
import tea.entity.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.Break;
//import tea.http.MultipartRequest;
//import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import java.io.File;
import java.io.PrintWriter;

public class VotePoll extends TeaServlet
{

    public VotePoll()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            TeaSession teasession = new TeaSession(request);
            out.write("<script>var mt=parent.mt;</script>");

            String _nPoll[] = request.getParameterValues("Poll");
            if(_nPoll == null)
            {
                response.sendRedirect("Node?node=" + teasession._nNode);
                return;
            }
            String nexturl = teasession.getParameter("nexturl");
            if(nexturl == null)
            {
                nexturl = "/html/poll/" + teasession._nNode + "-" + teasession._nLanguage + ".htm";
            }
            int pollpos = 0;
            if(request.getParameter("pollpos") != null && request.getParameter("pollpos").length() > 0)
            {
                pollpos = Integer.parseInt(request.getParameter("pollpos"));
            }
            //单个投票
            String textsinglepollButton = request.getParameter("textsinglepollButton");

            HttpSession session = request.getSession();
            Node node = Node.find(teasession._nNode);
            int j = node.getOptions1();
            String sepoll = (String) session.getAttribute("tea.Poll");

            RV rv = teasession._rv;
            if(textsinglepollButton != null && textsinglepollButton.length() > 0 && (j & 0x8000000) == 0)
            {
                String se = teasession._nNode + "." + textsinglepollButton;

                if((j & 0x10000000) != 0) //记名投票
                {
                    boolean f = false;
                    if(teasession._rv != null)
                    {
                        for(int i = 0;i < _nPoll.length;i++)
                        {
                            f = PollResult.isVoted(teasession._nNode,teasession._rv,Integer.parseInt(_nPoll[i]),Integer.parseInt(textsinglepollButton));
                            if(f)
                            {
                                break;
                            }
                        }
                    }

                    if(teasession._rv == null) //会员没有登陆
                    {
                        out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + teasession._nNode + "');</script>");
                        return;
                    } else
                    if((j & 0x8000000) == 0 && f) //不准许会员多次投票 && 这不是会员第一次投票
                    {
                        out.print("<script>mt.show('你已经投票了，不准许会员多次投票。');</script>");
                        return;
                    }
                } else if(se.equals(sepoll))
                {
                    out.print("<script>mt.show('你已经投票了，不能连续投票。');</script>");
                    return;
                }
            } else
            {
                if((j & 0x10000000) != 0) //记名投票
                {
                    if(teasession._rv == null) //会员没有登陆
                    {
                        out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + teasession._nNode + "');</script>");
                        return;
                    } else
                    if((j & 0x8000000) == 0 && PollResult.isVoted(teasession._nNode,teasession._rv)) //不准许会员多次投票 && 这不是会员第一次投票
                    {
                        out.print("<script>mt.show('你已经投票了，不准许会员多次投票。');</script>");
                        return;
                    }
                } else if(rv == null)
                {
                    rv = new RV(session.getId(),node.getCommunity());
                }
                if(sepoll != null && sepoll.indexOf("/" + teasession._nNode + "." + pollpos + "/") != -1 && (j & 0x8000000) == 0)
                {
                    out.print("<script>mt.show('你已经投票了，不能连续投票。');</script>");
                    return;
                }
            }
            if(sepoll == null)
            {
                sepoll = "/";
            }
            if(textsinglepollButton != null && textsinglepollButton.length() > 0) //单个投票按钮
            {
                session.setAttribute("tea.Poll",teasession._nNode + "." + textsinglepollButton);
            } else
            {
                session.setAttribute("tea.Poll",sepoll + teasession._nNode + "." + pollpos + "/");
            }
            int point = 0;
            int point2 = 0;
            for(int i = 0;i < _nPoll.length;i++)
            {
                // Poll obj = Poll.find(Integer.parseInt(_nPoll[i]));

                String answers[] = request.getParameterValues("Answer" + _nPoll[i]);
//                String s = teasession.getParameter("Remark");
                byte abyte0[] = teasession.getBytesParameter("Voice");

                // int spaces = obj.getSpaces();

                //记名投票 &&
//                        if((j & 0x10000000) == 0 && (s == null || s.length() == 0) && abyte0 == null)
//                        {
//                            AnonPollResult.vote(teasession._nNode, i);
//                        } else
//            {
//                            if(teasession._rv == null)
//                            {
//                                outLogin(request, response, teasession, "VotePoll?node=" + teasession._nNode + "&Answer=" + i);
//                                return;
//                            }


                boolean f = false;
                if(answers != null)
                {
                    for(int index = 0;index < answers.length;index++)
                    {
                        int poll = Integer.parseInt(_nPoll[i]);
                        Poll poll_obj = Poll.find(poll);
                        String content = null;
                        int answer = 0;
                        switch(poll_obj.getType())
                        {
                        case 0:
                        case 1:
                            answer = Integer.parseInt(answers[index]);
                            break;
                        case 2:
                        case 3:
                            content = answers[index];
                            break;
                        }
                        PollResult.create(teasession._nNode,poll,rv,answer,teasession._nLanguage,content,abyte0);

                        //给选项表添加排序字段
                        PollChoice pcobj = PollChoice.find(answer);
                        int si = pcobj.getSorting() + 1;
                        pcobj.setSorting(si);

                        //判断是否多选
                        if(poll_obj.getType() == 0) //单选
                        {
                            if(poll_obj.getCorrect() == answer)
                            {
                                point += poll_obj.getPoint();
                            }
                        }
                        if(poll_obj.getType() == 1) //多选
                        {
                            if(poll_obj.getCorrect_ch() != null && poll_obj.getCorrect_ch().length() > 0 && poll_obj.getCorrect_ch().indexOf("/" + answer + "/") != -1)
                            {
                                point2 = poll_obj.getPoint();
                                f = true;
                            } else
                            {
                                point2 = 0;
                                f = false;
                            }
                        }
                    }
                } else if(textsinglepollButton != null && textsinglepollButton.length() > 0)
                {
                    int poll = Integer.parseInt(_nPoll[i]);
                    Poll poll_obj = Poll.find(poll);
                    String content = null;
                    PollResult.create(teasession._nNode,poll,rv,Integer.parseInt(textsinglepollButton),teasession._nLanguage,content,abyte0);

                    if(poll_obj.getCorrect() == Integer.parseInt(textsinglepollButton))
                    {
                        point += poll_obj.getPoint();
                    }

                    PollChoice pcobj = PollChoice.find(Integer.parseInt(textsinglepollButton));
                    int si = pcobj.getSorting() + 1;
                    pcobj.setSorting(si);

                }

                if(f)
                {
                    point = point + point2;
                }
            }
            delete(node);
            if((j & 0x20000000) != 0) //记分投票
            {
                PollPoint.create(teasession._nNode,rv,point);
                out.print("<script>mt.show('您的投票已成功提交，本次得分是：" + point + "',1,'" + nexturl + "');</script>");
            } else
            {
                out.print("<script>mt.show('您的投票已成功提交，谢谢您的参与！',1,'" + nexturl + "');</script>");
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/type/poll/VotePoll");
    }
}
