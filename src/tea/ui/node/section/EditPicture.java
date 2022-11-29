package tea.ui.node.section;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.ui.*;
import tea.db.*;
import java.util.*;

public class EditPicture extends TeaServlet
{
	private static int index = 0;
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		ServletContext application = getServletContext();

		try //单传
		{
			Http h = new Http(request,response);
			String community = h.community;

			StringBuilder nu = new StringBuilder("/jsp/section/InsertPicture.jsp?community=");
			nu.append(community);
			if(h.member < 1)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + h.node + "&nu=" + java.net.URLEncoder.encode(nu.toString(),"UTF-8"));
				return;
			}

			if(request.getMethod().equals("POST"))
			{

				if(h.get("bg") != null)
				{
					nu.append("&bg=ON");
				}
				String changepic = h.get("changepic");
				String delete = h.get("delete");
				if(delete != null) //删除
				{
					File file = new File(application.getRealPath(changepic));
					file.delete();
				} else //创建/编辑
				{
					String sfname = h.get("pictureName");
					boolean flag = h.get("flag") != null;

					//sfname = "";/////////////////////////////////////////////////////////////////////shanshanshanshanshanshanshanshanshanshanshanshanshan
					//changepic = "";///////////////

					int i = sfname.lastIndexOf(".");
					String ex;
					if(i != -1)
					{
						ex = sfname.substring(i).toLowerCase();
						if(ex.equals("jsp"))
						{
							ex = "jsp.html";
						}
					} else
					{
						ex = ".gif";
					}

					String file = h.get("picture");
					File f1 = new File(application.getRealPath(file));
					if(changepic.length() > 0)
					{
						file = "/res/" + h.community + "/" + changepic.substring(0,4) + "/" + changepic + ex;
						ArrayList al = Attch.find(" AND deleted=0 AND path=" + DbAdapter.cite(file),0,1);
						if(al.size() > 0)
						{
							Attch t = (Attch) al.get(0);
							t.delete();
						}
						File f2 = new File(application.getRealPath(file));
						f2.delete();
						if(f1.renameTo(f2))
							f1 = f2;
						//
						Attch a = Attch.find(h.getInt("picture.attch"));
						a.set("path",file);
					}

					//添加水印/////////////////
					if(flag)
					{
						Watermark.mark(community,f1);
					}
					nu.append("&path=" + file);

//					PrintWriter out = response.getWriter();
//					response.setCharacterEncoding("utf-8");
//					out.print("<script>alert('success!');window.location.href='"+nu.toString()+"';</script>");
//					out.flush();
//					out.close();
					//return;
				}

			}
			response.sendRedirect(nu.toString());
		} catch(Exception ex)
		{
			response.sendError(400,ex.toString());
			ex.printStackTrace();
		}
	}


}
/*************
 * 参数说明:
 * bg:         是否显示图片管理
 * Node:       节点号，根据节点号就可以确认把图片保存在那个社区的文件夹下。
 * Picture:    图片数据,<input type=file name=Picture>
 * PictureName:图片的名称,根据名称确认扩展名
 * *********************************/
