package tea.ui.member.contact;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.*;

public class EditContact extends TeaServlet
{

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
            return;
        }
        try
        {
            String nexturl = request.getParameter("nexturl");
            String act = request.getParameter("act");
            //如果是社区公用的创建者就是:Entity.DEFAULT_MEMBER, 否则是当前会员
            String create = act.startsWith("community") ? Entity.DEFAULT_MEMBER : teasession._rv.toString();

            if ("deletegroup".equals(act) || "communitydeletegroup".equals(act))
            {
                String id[] = request.getParameterValues("id");
                for (int index = 0; index < id.length; index++)
                {
                    SMSGroup smsg = SMSGroup.find(Integer.parseInt(id[index]));
                    String member = smsg.getPhonenumber();
                    if (member.equals(create))
                    {
                        smsg.delete();
                    }
                }
            } else if ("editgroup".equals(act) || "communityeditgroup".equals(act))
            {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String discript = request.getParameter("descript");
                if (id == 0)
                {
                    SMSGroup.create(teasession._strCommunity, create, name, discript);
                } else
                {
                    SMSGroup smsg = SMSGroup.find(id);
                    String member = smsg.getPhonenumber();
                    if (member.equals(create))
                    {
                        smsg.set(name, discript);
                    }
                }
            } else if ("deletephonebook".equals(act) || "communitydeletephonebook".equals(act))
            {
                String as[] = request.getParameterValues("id");
                if (as != null)
                {
                    for (int i = 0; i < as.length; i++)
                    {
                        SMSPhoneBook smspb = SMSPhoneBook.find(Integer.parseInt(as[i]));
                        String member = smspb.getPhonenumber();
                        if (member.equals(create))
                        {
                            smspb.delete();
                        }
                    }
                }
            } else if ("editphonebook".equals(act) || "communityeditphonebook".equals(act))
            {
                String name = request.getParameter("name");
                String mobile = request.getParameter("mobile");
                String telephone = request.getParameter("telephone");
                String email = request.getParameter("email");
                int groupid = Integer.parseInt(request.getParameter("gid"));
                int id = Integer.parseInt(request.getParameter("id"));
                String memberx = request.getParameter("memberx").trim();
                if (memberx.length() > 0 && !Profile.isExisted(memberx))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMemberId"), "UTF-8"));
                    return;
                }
                if (id == 0)
                {
                    SMSPhoneBook.create(teasession._strCommunity, create, groupid, name, mobile, telephone, email, memberx);
                } else
                {
                    SMSPhoneBook obj = SMSPhoneBook.find(id);
                    String member = obj.getPhonenumber();
                    if (member.equals(create))
                    {
                        obj.set(groupid, name, mobile, telephone, email, memberx);
                    }
                }
            }
            ///////////////////////////////////////////////////
            else if ("newcontact".equals(act))
            {
                int cgroup = Integer.parseInt(request.getParameter("cgroup"));
                String member = request.getParameter("member");
                if (!Profile.isExisted(member))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidMemberId"), "UTF-8"));
                    return;
                }
                Contact obj = Contact.find(cgroup, member);
                if (!obj.isExists())
                {
                    Contact.create(cgroup, member);
                }
                PrintWriter out = response.getWriter();
                out.write("<script>window.close(); window.opener.location.reload();</script>");
                out.close();
                return;
            }else if("newcgmember".equals(act)){
				int cgroup =Integer.parseInt(request.getParameter("cgroup"));
				Contact.deleteCG(cgroup);
				String members = request.getParameter("cgmember");
				if(members!=null&&members.length()>0){
					String[] memList = members.split("/");
					for(int i = 0; i < memList.length; i ++){
                        Contact obj = Contact.find(cgroup,memList[i]);
                        if(!obj.isExists())
                        {
                            Contact.create(cgroup,memList[i]);
                        }
					}
				}
				response.sendRedirect("/jsp/user/list/SelMembers2.jsp?community="+teasession._strCommunity+"&member=form1.to&unit=form1.tunit&name=form1.name");
				return;
			}else if ("delcontact".equals(act))
            {
                int cgroup = Integer.parseInt(request.getParameter("cgroup"));
                String member = request.getParameter("member");
                Contact obj = Contact.find(cgroup, member);
                obj.delete();
            }
            response.sendRedirect(nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
