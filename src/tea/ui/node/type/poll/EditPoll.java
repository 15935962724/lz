package tea.ui.node.type.poll;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.*;
import tea.entity.node.AccessMember;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.node.*;
import tea.entity.node.PollChoice;
import tea.ui.*;
import tea.db.*;
import java.io.*;
import java.util.Enumeration;

public class EditPoll extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" +teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            out.write("<script>var mt=parent.mt;</script>");
            Node node = Node.find(h.node);
            String act = h.get("act");
            String nexturl = h.get("nexturl");
            if(!node.isCreator(teasession._rv) && AccessMember.find(h.node,teasession._rv._strV).getPurview() < 2)
            {
                out.write("<script>mt.show('抱歉，您无权限执行本操作！');</script>");
                return;
            }
            if("Question".equals(act))
            {
                Poll poll = Poll.find(Integer.parseInt(h.get("Poll")));
                if(h.get("delete") != null)
                {
                    poll.delete();
                } else
                {
                    String picture = h.get("picture");
                    if(picture == null && h.get("clear") == null)
                    {
                        picture = poll.getPicture();
                    }
                    int top = h.getInt("top");
                    int point = h.getInt("point");
                    int type = h.getInt("type");
                    boolean need = (h.get("need") != null);
                    int sequence = h.getInt("sequence");

                    int nodeid = 0;
                    if(h.get("nodeid") != null && h.get("nodeid").length() > 0)
                    {
                        nodeid = Integer.parseInt(h.get("nodeid"));
                    }
                    String question = (h.get("question"));
                    poll.set(h.node,h.language,question,type,need,sequence,picture,top,point,nodeid);
                }
                out.write("<script>parent.location='/jsp/type/poll/EditPollQuestion.jsp?node=" + h.node + "';</script>");
                return;
            } else
            if("Choice".equals(act))
            {
                int _nPoll = Integer.parseInt(h.get("Poll"));
                Poll poobj = Poll.find(_nPoll);
                String bigpath = h.get("bigpic");
                String smallpath = h.get("smallpic");
                String pollinfo = h.get("content");

                String memberinfo = null;
                if(h.get("memberinfo") != null && h.get("memberinfo").length() > 0)
                {
                    memberinfo = h.get("memberinfo");
                }
                String firstname = null;
                if(h.get("firstname") != null && h.get("firstname").length() > 0)
                {
                    firstname = h.get("firstname");
                }
                String title = null;
                if(h.get("title") != null && h.get("title").length() > 0)
                {
                    title = h.get("title");
                }
                String linkman = null;
                if(h.get("linkman") != null && h.get("linkman").length() > 0)
                {
                    linkman = h.get("linkman");
                }
                tea.entity.node.PollChoice pollc = PollChoice.find(Integer.parseInt(h.get("PollChoice")));
                int sequence = 0;
                if(h.get("sequence") != null && h.get("sequence").length() > 0)
                {
                    sequence = Integer.parseInt(h.get("sequence"));
                }
                if(h.get("delete") != null)
                {
                    pollc.delete();
                } else
                {
                    pollc.set(_nPoll,h.get("Choice"),pollinfo,memberinfo,firstname,title,bigpath,smallpath,linkman,sequence);
                    if(smallpath != null)
                    {
                        pollc.setSmallPicture(smallpath);
                    }
                    if(bigpath != null)
                    {
                        pollc.setBigPicture(bigpath);
                    }
                }

                String correct = h.get("correct");
                Poll poll = Poll.find(pollc.getPoll());
                if(correct != null && correct.length() > 0)
                {
                    if(poobj.getType() == 0) //单选
                    {
                        poll.setCorrect(pollc.getId());
                    } else if(poobj.getType() == 1) //多选
                    {
                        String str = "/";
                        if(poll.getCorrect_ch() != null && poll.getCorrect_ch().length() > 0)
                        {
                            str = poll.getCorrect_ch();
                        }
                        if(poll.getCorrect_ch() != null && poll.getCorrect_ch().indexOf("/" + pollc.getId() + "/") == -1)
                        {
                            poll.setCorrect_ck(str + pollc.getId() + "/");
                        }

                    }
                } else if(pollc.isID() && correct == null) //修改的是时候
                {
                    if(poobj.getType() == 0) //单选
                    {
                        poll.setCorrect(0);
                    } else if(poobj.getType() == 1) //多选
                    {
                        if(poll.getCorrect_ch() != null && poll.getCorrect_ch().length() > 0)
                        {
                            poll.setCorrect_ck(poll.getCorrect_ch().replaceAll("/" + pollc.getId(),""));
                        }
                    }
                }
                out.write("<script>parent.location='/jsp/type/poll/EditPollChoice.jsp?node=" + h.node + "&Poll=" + _nPoll + "';</script>");
                return;
            } else if("edit".equals(act))
            {
                String subject = h.get("subject");
                int i = node.getOptions1();
                i &= 0x83ffffff;
                if(h.get("PollOShowTime") != null)
                {
                    i |= 0x40000000;
                }
                if(h.get("PollOHideResult") != null)
                {
                    i |= 0x20000000;
                }
                if(h.get("PollOUnanonymous") != null)
                {
                    i |= 0x10000000;
                }
                if(h.get("PollOMultiple") != null)
                {
                    i |= 0x8000000;
                }
                if(h.get("result") != null)
                {
                    i |= 0x4000000;
                }
                //简介图片
                String picture = h.get("picture");
                if(h.get("clearpicture") != null)
                {
                    picture = "";
                }
                //月份图片
                String filename = h.get("filename");
                if(h.get("clearfilename") != null)
                {
                    filename = "";
                }
                //相关图片
                String repic = h.get("repic");
                if(h.get("clearrepic") != null)
                {
                    repic = "";
                }
                //截止时间
                Date stoptime = null;
                if(h.get("stoptime") != null && h.get("stoptime").length() > 0)
                {
                    stoptime = Entity.sdf.parse(h.get("stoptime"));
                }

                String content = h.get("content");

                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(h.node); //3
                    h.node = Node.create(h.node,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(i & 2) != 0,node.getOptions(),i,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,"","","",null,"",0,null,"","","","",null,null);
                    node = Node.find(h.node);
                } else
                {
                    node.setSubject(subject,h.language);
                    node.setOptions1(i);
                }

                if(picture != null)
                {
                    node.setPicture(picture,h.language);
                }
                if(filename != null)
                {
                    node.setFileName(filename,h.language);
                }
                if(repic != null)
                {
                    node.setRepic(repic,h.language);
                }
                node.setStopTime(stoptime);
                node.set(h.language,node.getSubject(h.language),content);
                //投票范围
                Poll2 p2 = Poll2.find(h.node);
                p2.role = h.get("role","|");
                p2.member = "|" + h.get("member").replace('；','|');
                p2.set();

                delete(node);

                if(h.get("GoBack") != null)
                {
                    nexturl = "/jsp/general/EditNode.jsp?node=" + h.node;
                } else if(h.get("next") != null)
                {
                    if(PollVote.count(" AND node=" + h.node) > 0)
                    {
                        //out.print("<script>mt.show('存在投票数据！不可编辑投票选项，请先清空投票结果后再执行操作！')</script>");
                        //return;
                    }
                    nexturl = "/jsp/type/poll/EditPollQuestion.jsp?node=" + h.node;
                } else if(h.get("GoFinish") != null)
                {
                    if(nexturl == null)
                        nexturl = "/servlet/Node?node=" + h.node + "&edit=ON";
                }
                node.finished(h.node);
                out.write("<script>parent.location='" + nexturl + "';</script>");
            } else
            {
                if("del".equals(act))
                {
                    node.delete(h.language);
                } else if("clear".equals(act))
                {
                    Enumeration e = Poll.find(" AND node=" + h.node);
                    while(e.hasMoreElements())
                    {
                        int pid = ((Integer) e.nextElement()).intValue();
                        Enumeration ec = PollChoice.findByPoll(pid);
                        while(ec.hasMoreElements())
                        {
                            int pcid = ((Integer) ec.nextElement()).intValue();
                            PollChoice.find(pcid).setSorting(0);
                        }
                    }
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate("DELETE FROM PollVoteList WHERE pollvote IN(SELECT pollvote FROM PollVote WHERE node=" + h.node + ")");
                        db.executeUpdate("DELETE FROM PollVote WHERE node=" + h.node);
                    } finally
                    {
                        db.close();
                    }
                } else if("hidden".equals(act))
                {
                    node.setHidden(!node.isHidden());
                }
                out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "')</script>");
                out.close();
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/poll/EditPoll");
    }
}
