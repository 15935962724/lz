package tea.ui.node.type.album;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.db.DbAdapter;

public class Albums extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		Http h = new Http(request);
		String act = h.get("act","");
		ServletContext application = getServletContext();
		PrintWriter out = response.getWriter();
		try
		{
			if("upload".equals(act))
			{
				int attch = h.getInt("attch");
				boolean isNew = attch < 1;
				Attch at = Attch.find(h.getInt("file.attch"));
				String par = "/res/" + h.community + "/album/" + at.attch / 10000 + "/";
				new File(application.getRealPath(par)).mkdirs();
				File fu = new File(application.getRealPath(at.path));
				//原图
				at.path = par + "S_" + at.attch + ".jpg";
				File fs = new File(application.getRealPath(at.path));
				fs.delete();
				fu.renameTo(fs);
				//水印
				Watermark wm = Watermark.find(h.community);
				//if(wm.type.indexOf("|95|") != -1)
				if(h.getBool("watermark"))
					wm.mark(h.community,fs);
				//大图
				at.path2 = par + "B_" + at.attch + ".jpg";
				File fb = new File(application.getRealPath(at.path2));
				Img img = new Img(fs);
				img.width = 950;
				img.height = 800; //原:620
				img.start(fb);
				//中图
				File fm = new File(application.getRealPath(par + "M_" + at.attch + ".jpg"));
				img = new Img(fb);
				img.width = 600;
				img.height = 600;
				img.start(fm);
				//小图
				at.path3 = par + "T_" + at.attch + ".jpg";
				File ft = new File(application.getRealPath(at.path3));
				img = new Img(fb);
				img.width = 100;
				img.height = 80;
				img.cut = true;
				img.start(ft);
				if(isNew)
					out.print("mt.add(" + at.attch + ",'" + at.path3 + "','');");
				else
					out.print("<script>parent.mt.edit(" + at.attch + ");</script>");
				at.deleted = false;
				at.set();
				return;
			}
			if(h.member < 1)
			{
				out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
				return;
			}
			try
			{
				if("sequence".equals(act))
				{
					out.print("form2.filedata.value='" + h.get("attchs") + "';");
					return;
				}
				if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null || "application/x-www-form-urlencoded".equals(request.getContentType()))
					return;
				out.print("<script>mt=parent.mt;</script>");
				if("edit".equals(act))
				{
					String subject = h.get("subject");
					String content = h.get("content");
					String picture = h.get("picture");
					String filedata = h.get("filedata");
					String keywords = h.get("keywords");
					int sequence = h.getInt("nsequence");
					Node node = Node.find(h.node);
					if(node.getType() == 1)
					{
						int options1 = node.getOptions1();
						Category cat = Category.find(h.node); //95
						h.node = Node.create(h.node,sequence,node.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,node.getOptions(),options1,node.getDefaultLanguage(),null,null,new Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,keywords,"",content,picture,"",0,null,"","","","",filedata,null);
						node = Node.find(h.node);
						node.finished(h.node);
					} else
					{
						node.set(h.language,subject,content);
						node.setKeywords(keywords,h.language);
						if(picture != null)
							node.setPicture(picture,h.language);
						node.setSequence(sequence);
						node.setFile(filedata,h.language);
					}
					//频道选项
					node.set(h.getBool("mostly"),h.getBool("mostly1"),h.getBool("mostly2"),h.get("mark","|").replace('|','/'));
					//手动列举
					String list = h.get("listing");
					String[] ls = list.split("/");
					for(int i = 1;i < ls.length;i++)
					{
						int j = Listed.count(" AND node=" + h.node + " AND listing=" + ls[i]);
						if(j < 1)
							Listed.create(h.node,Integer.parseInt(ls[i]),null);
					}
					DbAdapter.execute("DELETE FROM Listed WHERE node=" + h.node + " AND listing NOT IN(" + list.substring(1).replace('/',',') + "0)");

					Album a = Album.find(h.node);
					a.author[h.language] = h.get("author");
					a.subtitle[h.language] = h.get("subtitle");
					a.editor[h.language] = h.get("editor");
					a.source[h.language] = h.get("source");
					a.set();
					String[] arr = filedata.split("[|]");
					for(int i = 1;i < arr.length;i++)
					{
						Attch al = Attch.find(Integer.parseInt(arr[i]));
						al.name = h.get("name_" + al.attch);
						al.content = h.get("content_" + al.attch);
						al.set();
					}

					//管理活动
					int eventid = h.getInt("eventid");
					if(eventid > 0)
					{
						Event eobj = Event.find(eventid,h.language);
						eobj.setAlbum(node._nNode);
					}
					//管理会议
                    int meetingid = h.getInt("meetingid");
                    if(meetingid > 0)
                    {
                        Meeting eobj = Meeting.find(meetingid,h.language);
                        eobj.setAlbum(node._nNode);
                    }
					//管理动物
					int animalid = h.getInt("animalid");
					if(animalid > 0)
					{
						Animal am = Animal.find(animalid);
						am.set("album",String.valueOf(node._nNode));
					}
					TeaServlet.delete(node);
					out.print("<script>parent.location='" + h.get("nexturl","/html/" + h.community + "/album/" + h.node + "-" + h.language + ".htm") + "';</script>");
					return;
				} else if("del".equals(act))
				{
					Node n = Node.find(h.node);
					String file = n.getFile(h.language);
					String[] attchs = h.getValues("attchs");
					for(int i = 0;i < attchs.length;i++)
					{
						new Attch(Integer.parseInt(attchs[i])).delete();
						file = file.replaceFirst("\\|" + attchs[i] + "\\|","|");
						out.print("<script>var t=parent.$('tr_" + attchs[i] + "');t.parentNode.removeChild(t);</script>");
					}
					n.setFile(file,h.language);
					return;
				}
			} finally
			{
				Album.js(h.node);
			}
			out.print("<script>mt.show('操作执行成功！',1,'" + h.get("nexturl","") + "');</script>");
		} catch(Throwable ex)
		{
			out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
			ex.printStackTrace();
		} finally
		{
			out.close();
		}
	}

}
