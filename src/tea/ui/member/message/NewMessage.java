package tea.ui.member.message;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.admin.*;
import tea.entity.site.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.service.Robot;
import tea.ui.*;
import java.sql.SQLException;

public class NewMessage extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/message/NewMessage").add("tea/ui/member/messagefolder/ManageMessageFolders");
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            String s = request.getRequestURI();
            boolean flag = s.endsWith("ForwardMessage");
            boolean flag1 = s.endsWith("ReplyMessage");
            boolean flag2 = s.endsWith("ForwardNode");
            boolean flag3 = s.endsWith("ReplyNode");
            boolean flag4 = s.endsWith("ForwardTalkback");
            boolean flag5 = s.endsWith("ReplyTalkback");
            boolean flag6 = s.endsWith("InviteMessage");

            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/message/NewMessage.jsp?" + request.getQueryString());
            } else
            {
                int message = 0;
                if(teasession.getParameter("message")!=null && teasession.getParameter("message").length()>0)
                {
                	message = Integer.parseInt(teasession.getParameter("message"));
                }
                Message obj = Message.find(message);
                String act = teasession.getParameter("act");
                if(act.startsWith("attach"))
                {
                    int part = Integer.parseInt(teasession.getParameter("part"));
                    if(act.equals("attach_delete"))
                    {
                        obj.deleteAttachmentPart(part);
                    } else if(act.equals("attach_upload"))
                    {
                        byte by[] = teasession.getBytesParameter("file");
                        if(by != null)
                        {
                            String path = TeaServlet.write(teasession._strCommunity,by,".gif");
                            String name = teasession.getParameter("fileName");
                            // int part=(int)(System.currentTimeMillis()/1000);
                            obj.createAttachment(part,name,path);
                        }
                    }
                    return;
                } else if(act.equals("fw")) //复制附件/// act.equals("re") ||
                {
                    message = Message.createTempMessage(teasession._strCommunity,teasession._rv._strV);
                    Message obj2 = Message.find(message);
                    Enumeration e = obj.findAttachment();
                    while(e.hasMoreElements())
                    {
                        int part = ((Integer) e.nextElement()).intValue();
                        String name = obj.getAttachmentFileName(part,teasession._nLanguage);
                        String path = obj.getAttachmentFilePath(part);
                        obj2.createAttachment(part,name,path);
                    }
                    obj = obj2;
                }else if("EditMemberMailbox".equals(act))//个人信息添加
                {
                	String name = teasession.getParameter("name");//收件人
                	String subject = teasession.getParameter("subject");//主题
                    String content = teasession.getParameter("content");//内容
                    String nexturl = teasession.getParameter("nexturl");
                    int folder= 0;

                    message=Message.create(teasession._strCommunity, teasession._rv._strR,name, teasession._nLanguage, subject, content);
                    Message obj2 = Message.find(message);
                    obj2.setFolder(1);

                    response.sendRedirect(nexturl);
                    return;
                }else if("WestracEditMemberMailbox".equals(act))
                {
                	//威斯特 站内信 添加
                	String name = teasession.getParameter("name");//收件人
                	String subject = teasession.getParameter("subject");//主题
                    String content = teasession.getParameter("content");//内容
                    String nexturl = teasession.getParameter("nexturl");



                    int folder= 0;

                    message=Message.create(teasession._strCommunity, teasession._rv._strR,name, teasession._nLanguage, subject, content);
                    Message obj2 = Message.find(message);
                    obj2.setFolder(1);

                    out.print("<script  language='javascript'>alert('添加成功');parent.ymPrompt.close();parent.window.location.reload();</script> ");
                    return;
                }

                String to = "";
                if(teasession.getParameter("tm") != null)
                {
                    to = "/" + teasession.getParameter("tm") + "/";
                } else
                {
                    to = teasession.getParameter("to");
                }
                if(to.length() > 1) //验证邮件发送人员是否合法
                {
                    String[] tm = to.split("/");
                    if(!Profile.isExisted(tm[1]))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidMemberId"),"UTF-8"));
                        return;
                    }
                }
                String email = teasession.getParameter("email");
                email = email == null ? "" : email.replaceAll("[,，；]",";");
                String tunit = teasession.getParameter("tunit"); // 部门
                String trole = teasession.getParameter("trole"); // 角色
                String tgroup = teasession.getParameter("tgroup"); // 通讯录
                String tcommunity = teasession.getParameter("tcommunity"); // 社区
                String tmp = teasession.getParameter("emailbox");
                int emailbox = tmp == null ? 0 : Integer.parseInt(tmp);
                int hint = Integer.parseInt(teasession.getParameter("hint"));
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");

                if(to.length() == 0 && email.length() == 0 && (tunit == null || tunit.length() < 3) && (trole == null || trole.length() < 3) && (tgroup == null || tgroup.length() < 3) && (tcommunity == null || tcommunity.length() < 3))
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidToMembers"));
                    return;
                }
                if(subject.length() < 1)
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSubject"));
                    return;
                }
                int status = 5;
                if(teasession.getParameter("sent") != null)
                {
                    status = 1;
                }
                if(teasession.getParameter("draft") != null)
                {
                    status = 2;
                }
                boolean feedback = teasession.getParameter("feedback") != null;
                boolean sendemail = teasession.getParameter("sendemail") != null;

                String picture = null;
                byte abyte0[] = teasession.getBytesParameter("picture");
                if(abyte0 != null)
                {
                    picture = write(teasession._strCommunity,abyte0,".gif");
                }

                String to5 = request.getServerName();
                String to6 = "";
                if(flag2)
                {
                    Node node1 = Node.find(teasession._nNode);
                    String to7 = node1.getSubject(teasession._nLanguage);
                    Text text = new Text();
                    String picture2 = node1.getPicture(teasession._nLanguage);
                    if(picture != null && picture.length() > 0)
                    {
                        text.add(new Image("http://" + to5 + picture,to7));
                    }
                    text.add(new Text(to7));
                    to6 = (new Paragraph(new Anchor("http://" + to5 + "/servlet/Node?node=" + teasession._nNode,text))).toString();
                }
                if(flag4)
                {
                    int i2 = Integer.parseInt(teasession.getParameter("Talkback"));
                    Talkback talkbachint = Talkback.find(i2);
                    String to8 = talkbachint.getSubject(teasession._nLanguage);
                    Text text1 = new Text();
                    String picture2 = talkbachint.getPicture(teasession._nLanguage);
                    if(picture != null && picture.length() > 0)
                    {
                        text1.add(new Image("http://" + to5 + picture,to8));
                    }
                    text1.add(new Text(to8));
                    to6 = (new Paragraph(new Anchor("http://" + to5 + "/servlet/Talkback?node=" + teasession._nNode + "&Talkback=" + i2,text1))).toString();
                }
                if(status == 2)
                {
                    // Message.create(teasession._strCommunity, teasession._rv._strV, 2, null, 5, teasession._nLanguage, subject, content, picture, voice, filepath, filename);
                } else
                {

                }
                obj.set(status,to,trole,tunit,hint,teasession._nLanguage,subject,content,feedback);
                String sms = teasession.getParameter("sms");
                if(sms != null)
                {
                    StringBuffer mobs = new StringBuffer();
                    Enumeration e = AdminUsrRole.find(teasession._strCommunity,to,"/",tunit);
                    while(e.hasMoreElements())
                    {
                        String member = (String) e.nextElement();
                        Profile p = Profile.find(member);
                        String mob = p.getMobile();
                        if(mob != null && mob.length() > 10)
                        {
                            mobs.append(mob).append(",");
                        }
                    }
                    SMSMessage.create(teasession._strCommunity,teasession._rv._strR,mobs.toString(),teasession._nLanguage,sms);
                }
                if(sendemail)
                {
                    Robot.activateRoboty(teasession._nNode,message);
                }
                if(emailbox > 0 && email.length() > 0)
                {
                    int ok = 0,err = 0;
                    out.print("<span id='info'></span><script>var i=document.getElementById('i');function f(s){i.innerHTML=s;}</script>");
                    out.flush();
                    EmailBox eb = EmailBox.find(emailbox);
                    ArrayList al = new ArrayList();
                    String[] arr = email.split(";");
                    for(int i = 0;i < arr.length;i++)
                    {
                        if(arr[i].length() < 1 || al.indexOf(arr[i]) != -1)
                        {
                            continue;
                        }
                        al.add(arr[i]);
                        out.print("<script>f('正在发送" + arr[i] + "...');</script>");
                        out.flush();
                        boolean rs = eb.send(arr[i],message);
                        if(rs)
                        {
                            ok++;
                        } else
                        {
                            err++;
                        }
                    }
                    out.print("<script>alert('共发送" + (ok + err) + "封邮件\\n\\n发送成功" + ok + "封!\\n发送失败" + err + "封!');history.back();</script>");
                    return;
                }
                String nexturl = request.getParameter("nexturl");
                if(nexturl == null)
                {
                    nexturl = "/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InfMessageSent"),"UTF-8");
                }
                response.sendRedirect(nexturl);
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
}
