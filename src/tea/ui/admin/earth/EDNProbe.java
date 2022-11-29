package tea.ui.admin.earth;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.hyperic.sigar.*;
import org.hyperic.sigar.FileSystem;
import tea.db.*;
import tea.entity.*;
import tea.entity.OS;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;

//把服务器信息发给请求者////////
public class EDNProbe extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request,response);
		PrintWriter out = response.getWriter();
		try
		{
			float G = 1073741824F,M = 1048576F;
			// ///////////License///////////////////////////////////
			String context = new File(Http.REAL_PATH).getParentFile().getName();
			Date times = h.getDate("times");
			StringBuffer sql = new StringBuffer();
			if(times != null)
				sql.append(" AND time>").append(DbAdapter.cite(times));

			License l = License.getInstance();
			out.print("{license:{webname:" + Attch.cite(l.getWebName()));
			out.print(",path:" + Attch.cite(Http.REAL_PATH));
			out.print(",context:" + Attch.cite(context));
			//系统
			out.print(",os:" + Attch.cite(System.getProperty("os.name") + " " + System.getProperty("os.arch")));
			try
			{
				Sigar sigar = new Sigar();
				Mem mem = sigar.getMem();
				//内存
				out.print(",mem:'" + MT.f(mem.getFree() / G) + "G可用，共" + MT.f(mem.getTotal() / G) + "G'");
				//CPU
				CpuInfo cpu = sigar.getCpuInfoList()[0];
				out.print(",cpu:'" + cpu.getVendor() + " " + cpu.getTotalCores() + "核" + " " + MT.f(cpu.getMhz() / 1000F) + "Ghz" + "'");
				//磁盘
				StringBuilder sb = new StringBuilder();
				FileSystem[] fss = sigar.getFileSystemList();
				for(FileSystem fs : fss)
				{
					if(fs.getType() != 2)
						continue;
					FileSystemUsage fsu = sigar.getFileSystemUsage(fs.getDirName());
					String tmp = fs.getDirName();
					if(OS.isWin)
						tmp = "" + tmp.charAt(0);
					sb.append("　" + tmp + ":" + MT.f(fsu.getFree() / M) + "G可用，共" + MT.f(fsu.getTotal() / M) + "G");
				}
				out.print(",disk:'" + sb.substring(1) + "'");
			} catch(Throwable ex)
			{
				ex.printStackTrace();
			}
			// ///////////Community///////////////////////////////////
			out.print("},community:[");
			ArrayList al2 = Community.find("",0,Integer.MAX_VALUE);
			for(int i = 0;i < al2.size();i++)
			{
				Community c = (Community) al2.get(i);
				String csql = " AND community=" + DbAdapter.cite(c.community);
				if(i > 0)
					out.print(",");
				out.print("{community:" + Attch.cite(c.community));
				out.print(",name:" + Attch.cite(c.getName(1)));
				out.print(",picture:" + Attch.cite(c.getSmallMap(1)));
				out.print(",state:" + c.state);
				if(MT.f(c.webName).length() < 1)
				{
					Enumeration e = DNS.find(csql,0,1);
					if(e.hasMoreElements())
						c.webName = (String) e.nextElement();
				}
				if(c.time == null)
				{
					Enumeration e = Node.find(" AND father=0 AND community=" + DbAdapter.cite(c.community),0,1);
					if(e.hasMoreElements())
					{
						int node = ((Integer) e.nextElement()).intValue();
						c.time = Node.find(node).getTime();
						c.set("time",MT.f(c.time,1));
					}
				}
				out.print(",host:" + Attch.cite(c.webName));
				out.print(",time:" + Attch.cite(MT.f(c.time,1)));
				//
				out.print(",nodes:" + Node.count(csql));
				out.print(",member:" + Profile.count(csql));
				out.print(",staff:" + AdminUsrRole.count(c.community," AND role!='/'"));
				DbAdapter db = new DbAdapter();
				try
				{
					db.executeQuery("SELECT SUM(pv0) FROM sday WHERE 1=1" + csql);
					out.print(",stats:" + (db.next() ? db.getInt(1) : 0));

					csql += " AND time>" + DbAdapter.cite(new Date(System.currentTimeMillis() - 86400000L * 30));
					db.executeQuery("SELECT SUM(pv0) FROM sday WHERE 1=1" + csql);
					out.print(",stat30:" + (db.next() ? db.getInt(1) : 0));
				} finally
				{
					db.close();
				}
				out.print(",node30:" + Node.count(csql));
				out.print("}");
			}
			out.print("]");

			// ///////////Profile///////////////////////////////////
			if(false)
			{
				Enumeration e = Profile.find(sql.toString(),0,Integer.MAX_VALUE); // Integer.MAX_VALUE
				for(int i = 0;e.hasMoreElements();i++)
				{
					String member = (String) e.nextElement();

					Profile obj = Profile.find(member);

					System.out.println("会员:" + i + ":" + member + ":" + obj.getTimeToString());
					HashMap m2 = new HashMap();
					m2.put("profile.member",member);
					m2.put("profile.community",obj.getCommunity());
					m2.put("profile.email",obj.getEmail());
					m2.put("profile.password",obj.getPassword());
					m2.put("profile.firstname",obj.getFirstName(1));
					m2.put("profile.lastname",obj.getLastName(1));
					m2.put("profile.time",obj.getTime());
				}
			}
			out.print("}");
		} catch(Throwable ex)
		{
			ex.printStackTrace();
		} finally
		{
			out.close();
		}
	}
}
