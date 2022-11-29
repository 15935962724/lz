package tea.ui.node.type.chat;

import java.io.IOException;
import java.util.Enumeration;
import java.util.StringTokenizer;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.Chat;
import tea.entity.node.Node;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ChatMembers extends TeaServlet
{

   public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/chat/ChatMembers.jsp?node=" + teasession._nNode);
                Form form = new Form("foChatMembers");
                DropDown dropdown = new DropDown("Member");
                dropdown.addOption("", super.r.getString(teasession._nLanguage, "AllMembers"));
                RV rv;
                for (Enumeration enumeration = Chat.findMember(teasession._nNode); enumeration.hasMoreElements(); dropdown.addOption(rv._strR, rv._strV))
                {
                    rv = (RV) enumeration.nextElement();
                }

                form.add(dropdown);
                DropDown dropdown1 = new DropDown("Action");
                for (int i = 2; i < Chat.CHAT_ACTION.length; i++)
                {
                    dropdown1.addOption(Integer.toString(i), super.r.getString(teasession._nLanguage, Chat.CHAT_ACTION[i]));
                }

                form.add(dropdown1);
                Form form1 = new Form("foInvite", "POST", "ChatMembers");
                form1.setOnSubmit("this.Members.value=this.Buffer.value;this.Buffer.value='';return(true);");
                form1.add(new HiddenField("Node", teasession._nNode));
                form1.add(new HiddenField("Members"));
                form1.add(new TextField("Buffer", "", 10));
                boolean flag = false;
                DropDown dropdown2 = new DropDown("CGroup");
                dropdown2.addOption("", "----------");
                Enumeration enumeration2 = CGroup.find(teasession._rv._strR,"",0,200);
                while ( enumeration2.hasMoreElements())
                {
                    String s4 = (String) enumeration2.nextElement();
                    dropdown2.addOption(s4, s4);
                    flag = true;
                }

                if (flag)
                {
                    form1.add(dropdown2);
                }
                form1.add(new Button(super.r.getString(teasession._nLanguage, "Invite")));
                outText(response, teasession._nLanguage, form.toString() + form1.toString());
            } else
            {
                Node node = Node.find(teasession._nNode);
                String s = RequestHelper.format(super.r.getString(teasession._nLanguage, "InfInviteSubject"), node.getSubject(teasession._nLanguage));
                String s1 = RequestHelper.format(super.r.getString(teasession._nLanguage, "InfInviteContent"), new Anchor("ChatFrameSet?node=" + teasession._nNode, super.r.getString(teasession._nLanguage, "ClickHere")));
                String s2 = Integer.toString(teasession._nNode);
                StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Members"), ", ");
                while ( stringtokenizer.hasMoreTokens())
                {
                	String str=stringtokenizer.nextToken();
                    RV rv1 = new RV(str,node.getCommunity());
                    Meeting.create(teasession._rv, rv1, 0, 0, s2, null, null, 0, null, null, null);
                    Message.create(teasession._strCommunity, teasession._rv._strV, str, teasession._nLanguage, s, s1);
                }

                String s3 = request.getParameter("CGroup");
                if (s3 != null && s3.length() != 0)
                {
                    //Message.create(teasession._strCommunity,teasession._rv, null, 0, 0, 0, 0, teasession._nLanguage, s3, null, null, null, null, null, null, "", "", null, null, 0, 0);
//返回值不正确...暂时注释了...
//                    Enumeration enumeration1 = Contact.find(Integer.parseInt(s3),teasession._rv._strR);
//                    while ( enumeration1.hasMoreElements() )
//                    {
//                        Meeting.create(teasession._rv, (RV) enumeration1.nextElement(), 0, 0, s2, null, null, 0, null, null, null);
//                    }
                }
                response.sendError(204);
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
        return ;
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/chat/ChatMembers");
    }
}
