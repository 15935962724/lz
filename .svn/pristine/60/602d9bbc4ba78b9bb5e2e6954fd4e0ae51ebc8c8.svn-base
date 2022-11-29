package tea.ui.node.type.subject;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.*;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.node.Subject;
import tea.ui.*;


public class EditSubject extends TeaServlet
{

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			Http h = new Http(request,response);
			if(h.member <= 0)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + h.node);
				return;
			}
			String act = h.get("act"),nexturl = h.get("url");
			if("edit".equals(act))
			{
				String name = h.get("name","");
				String keywords = h.get("keywords","");
				String abstracts = h.get("abstracts","");
				String unit = h.get("unit","");
				String team = h.get("team","");
				String main = h.get("content");
				String filename = h.get("attachName","|");
				String file = h.get("attach","|");
				boolean srccopy = h.get("srccopy") != null;
				if(srccopy)
				{
					main = copy(h.community,main);
				}
				boolean textorhtml = "1".equals(h.get("TextOrHtml"));
				boolean isnew = false;
				Node node = Node.find(h.node);
				if(node.getType() == 1)
				{
					int sequence = Node.getMaxSequence(h.node) + 10;
					long options = node.getOptions();
					int options1 = node.getOptions1();
					String accessmembersnode = node.getAccessmembersnode();
					String community = node.getCommunity();
					if(textorhtml)
					{
						options |= 0x40;
					}
					int language = h.language;
					Category c = Category.find(h.node);
					h.node = Node.create(h.node,sequence,community,new RV(Profile.find(h.member).getMember()),c.getCategory(),(options1 & 2) != 0,options,options1,language,new Date(),null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,name,keywords,abstracts,main,null,"",0,null,"","","",filename,file,null);
					Node n = Node.find(h.node);
					n.set("accessmembersnode",n.accessmembersnode = accessmembersnode);
					isnew = true;
					if(nexturl != null && nexturl.trim().length() > 0)
					{
						n.setSource(2);
					} else
					{
						n.setSource(1);
					}
					Category cate = Category.find(n.getFather());
					int perm = 4; //默认是审核通过
					if((cate.getPermissions() & 1) != 0)
					{
						perm = 0;
					} else
					if((cate.getPermissions() & 2) != 0)
					{
						perm = 1;
					} else
					if((cate.getPermissions() & 4) != 0)
					{
						perm = 2;
					} else
					if((cate.getPermissions() & 8) != 0)
					{
						perm = 3;
					}
					node.set("audits",String.valueOf(node.audits = perm));
					if(perm == 4)
					{
						node.setHidden(false);
					} else
					{

						node.setHidden(true);
					}

				} else
				{
					node.set(h.language,name,main);
					long options = node.getOptions();
					if(textorhtml)
					{
						options |= 0x40;
					}
					node.setOptions(options);
					node.setKeywords(keywords,h.language);
					node.set("description",h.language,abstracts);
					node.setFile(file,h.language);
					node.setFileName(filename,h.language);
					Logs.create(node.getCommunity(),new RV(Profile.find(h.member).getMember()),2,h.node,name);
				}
				Subject subject = Subject.find(h.node,h.language);
				subject.setMembers(team);
				subject.setUnit(unit);
				subject.set();
				delete(node);
				node.finished(h.node);
				if(nexturl != null && nexturl.trim().length() > 0)
				{
					response.sendRedirect(nexturl);
					return;
				} else
				{
					response.sendRedirect("/html/" + h.community + "/subjects/" + h.node + "-" + h.language + ".htm");
					return;
				}
			}
		} catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
