package tea.ui.node.type.bbs;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.*;
import java.net.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.htmlx.TimeSelection;
import tea.entity.site.*;
import tea.entity.bbs.*;
import tea.entity.admin.*;
import java.util.regex.*;

public class EditBBSReply extends EditBBS
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        HttpSession session = request.getSession(true);
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            Http h = new Http(request);
            String nexturl = h.get("nexturl");

            TeaSession teasession = new TeaSession(request);

            Node node = Node.find(h.node);

            String act = h.get("act");
            if(act != null)
            {
                if(teasession._rv == null)
                {
                    return;
                }
                String cmember = teasession._rv._strR;
                if("del".equals(act)) //删除贴子
                {
                    BBSPoint bp = new BBSPoint(0);
                    int bbsreply = h.getInt("bbsreply");
                    boolean isD = cmember.equals(Communitybbs.find(teasession._strCommunity).getSuperhost()) //超级版主
                                  || AdminUsrRole.find(teasession._strCommunity,cmember).getBbsHost().indexOf("/" + node.getFather() + "/") != -1;
                    ProfileBBS mb = ProfileBBS.find(h.community,teasession._rv._strR);
                    if(bbsreply > 0) //删除_回复
                    {
                        BBSReply br = BBSReply.find(bbsreply);
                        bp.member = br.getMember();
                        if(isD || cmember.equals(bp.member))
                        {
                            bp.content = br.getSubject(h.language);
                            br.delete();
                            mb.set("reply",String.valueOf(mb.reply - 1));
                        }
                        out.print("<script>parent.location.reload()</script>");
                    } else //删除_主贴
                    {
                        bp.member = node.getCreator()._strR;
                        if(isD || teasession._rv.equals(node.getCreator()))
                        {
                            bp.content = node.getSubject(h.language);
                            node.delete(h.language);
                            mb.set("post",String.valueOf(mb.post - 1));
                        }
                        if(nexturl == null)
                            nexturl = "/html/"+h.community+"/category/" + node.getFather() + "-" + h.language + ".htm";
                        out.print("<script>parent.location.replace('" + nexturl + "')</script>");
                    }
                    //更新积分
                    bp.point = -BBSForum.find(node.getFather()).del;
                    bp.node = h.node;
                    bp.type = 3;
                    bp.set();
                }
                return;
            }

            boolean best = h.get("best") != null;
            boolean del = h.get("del") != null;
            boolean grant = h.get("grant") != null;
            boolean hide = h.get("hide") != null;
            boolean visible = h.get("visible") != null;
            boolean search = h.get("search") != null;
            if(visible)
            {
                int replay = Integer.parseInt(h.get("replay"));
                BBSReply br = BBSReply.find(replay);
                br.setHidden(h.get("hidden") != null);
                /*
                 * if (nexturl == null) { nexturl = request.getContextPath() + "/servlet/BBS?node=" + h.node; }
                 */
            } else if(del || grant || hide || best || search)
            {
                String replay[] = h.getValues("replay");
                if(replay != null)
                {
					BBS bbs = BBS.find(h.node,h.language);
                    if(best) //最佳答案
                    {
                        bbs.setBest(Integer.parseInt(replay[0]));
                    } else
                    {
                        for(int index = 0;index < replay.length;index++)
                        {
                            BBSReply br = BBSReply.find(Integer.parseInt(replay[index]));
                            if(del)
                            {
                                //更新积分
                                Node n = Node.find(br.getNode());
                                BBSPoint bp = new BBSPoint(0);
                                bp.member = n.getCreator()._strR;
                                bp.point = -BBSForum.find(n.getFather()).del;
                                bp.node = h.node;
                                bp.type = 3;
                                bp.set();
                                //
                                br.delete();
                            } else
                            {
                                br.setHidden(hide);
                            }

                            if(search)
                            {
                                if(br.getSearch() == 0)
                                {
                                    br.setSearch(1);
                                    br.setSearch(teasession._rv._strR,new java.util.Date());
                                } else
                                {
                                    br.setSearch(0);
                                    br.setSearch(null,null);
                                }
                            }
                        }
					}
					bbs.setLast();
					node.setUpdatetime(new Date());
					delete(node);
                }
                if(nexturl == null)
                {
                    nexturl = "/jsp/type/bbs/BBSReplyManage.jsp?node=" + h.node;
                }
                response.sendRedirect(nexturl);
                return;
            } else
            {
                Forum forum = Forum.find(node.getCommunity());
                if((Node.find(node.getFather()).getOptions1() & 1) == 0)
                {
                    if(teasession._rv == null)
                    {
                        out.print("<script>window.open('/servlet/StartLogin?node=" + h.node + "','_parent');</script>");
                        return;
                    }
                    // !创建者 && 提供者57 && 当前论坛要审核 && 当前会员审核
                    if(!node.isCreator(teasession._rv) && !AccessMember.find(h.node,teasession._rv._strV).isProvider(57) && forum.getAuditing() != null && forum.getAuditing().indexOf("/" + node._nNode + "/") != -1 && Subscriber.find(node.getCommunity(),teasession._rv).getOptions() != 2)
                    {
                        out.print("<script>alert('您无权在本论坛发贴!');</script>");
                        return;
                    }
                    // 邮箱验证
                    if(forum.getValidate() != null && forum.getValidate().indexOf("/" + node._nNode + "/") != -1)
                    {
                        ProfileBBS pb = ProfileBBS.find(teasession._strCommunity,teasession._rv._strR);
                        if(!pb.isValidate())
                        {
                            String info = r.getString(h.language,"BBSEmailNoValidate") + new tea.html.Break().toString() + new tea.html.Break().toString() + new tea.html.Button("newsend",r.getString(h.language,"NewSend"),"window.location='" + request.getContextPath() + "/servlet/EditProfileBBS?node=" + h.node + "&sendaffirmemail=ON';").toString();
                            info = URLEncoder.encode(info,"UTF-8");
                            out.print("<script>window.open('/jsp/info/Alert.jsp?info=" + info + "','_parent');</script>");
                            return;
                        }
                    }
                    if(forum.getWait() > 0)
                    {
                        if((System.currentTimeMillis() - Profile.find(teasession._rv._strR).getTime().getTime()) < forum.getWait() * 60 * 1000)
                        {
                            out.print("<script>parent.mt.show('" + forum.getWait() + r.getString(h.language,"WaitCannotAppear") + "');</script>");
                            return;
                        }
                    }
                }

                // 验证码////////已登陆使用ANONYMITY身份,或未登陆
                String member = h.get("member");
                if(teasession._rv == null || RV.ANONYMITY.toString().equals(member))
                {
                    String s = (String) session.getAttribute("sms.vertify");
                    String vertify = h.get("vertify");
                    if(s != null || vertify != null)
                    {
                        if(!s.equalsIgnoreCase(vertify))
                        {
                            out.print("<script>alert('验证码错误。');history.go(-1);</script>");
                            return;
                        }
                        session.removeAttribute("sms.vertify");
                    }
                    teasession._rv = RV.ANONYMITY;
                }
                String subject = h.get("subject");
                String text = h.get("content");
                String anchor = h.get("anchor");

                if(subject == null || text == null || text.trim().length() == 0)
                {
                    out.print("<script>parent.mt.show('您回复的贴子，需要填写内容。');</script>");
                    return;
                }
                int bbsreply = 0;
                int hint = 0;
                try
                {
                    bbsreply = Integer.parseInt(h.get("bbsreply"));
                    hint = Integer.parseInt(h.get("hint"));
                } catch(NumberFormatException ex)
                {
                    out.print("<script>parent.mt.show('参数不正确。');</script>");
                    return;
                }
                Profile p = Profile.find(teasession._rv._strR);
                //禁言
                Date gag = p.getGag();
                if(gag != null && gag.getTime() > System.currentTimeMillis())
                {
                    out.print("<script>parent.mt.show('抱歉，您被禁言了，于 " + MT.f(gag) + " 之前不能发贴！');</script>");
                    return;
                }

                BBSForum bf = BBSForum.find(node.getFather());
                //回贴校验积分
                if(bbsreply == 0)
                {
                    int min = BBSLevel.find(bf.lreply).getPoint();
                    if(min > p.getIntegral())
                    {
                        out.print("<script>parent.mt.show('您的积分不足,无权回贴!');</script>");
                        return;
                    }
                }
                Community community = Community.find(node.getCommunity());
                if(community.filtrate != null && community.filtrate.length() > 0 && Pattern.compile(community.filtrate.replace(',','|')).matcher(text).find())
                {
                    out.print("<script>parent.mt.show('内容中含有敏感字符! 请重新填写!');</script>");
                    return;
                }

                if(h.get("nonuse") != null)
                {
                    text = text.replaceAll("\r\n","<BR>");
                }
                String ip = request.getRemoteAddr();
                //
                int point = bf.reply;

                if(bbsreply == 0)
                {
                    bbsreply = BBSReply.create(h.node,teasession._rv._strR,ip,hint,(node.getOptions1() & 2) != 0,h.language,subject,text,anchor,h.getInt("reply"),h.getInt("quote"));
                    BBSReply obj = BBSReply.find(bbsreply);
                    obj.setSearch(0);
                    //更新论坛附件的ID
                    point += BBSAttach.setBbsid(true,teasession._rv._strR,bbsreply) * bf.attach;
                    //热贴
                    if(forum.getHot() == BBSReply.count(h.node,h.language))
                    {
                        point += bf.hot;
                    }
                    //回复数量+1
                    ProfileBBS bp = ProfileBBS.find(h.community,teasession._rv._strR);
                    bp.set("reply",String.valueOf(bp.reply + 1));
                } else
                {
                    BBSReply obj = BBSReply.find(bbsreply);
                    obj.set(hint,ip,teasession._rv._strR,new Date(),text,h.language);
                }
                //更新积分
                BBSPoint bp = new BBSPoint(0);
                bp.member = teasession._rv._strR;
                bp.point = point;
                bp.node = h.node;
                bp.type = 2;
                bp.set();
            }
            delete(node);
            if(nexturl == null)
            {
                nexturl = "/html/"+h.community+"/bbs/" + h.node + "-" + h.language + ".htm";
            }
            out.print("<script>window.open('" + nexturl + "','_parent');</script>");
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
