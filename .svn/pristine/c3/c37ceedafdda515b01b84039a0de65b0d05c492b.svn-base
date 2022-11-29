package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import com.jacob.com.Dispatch;
import tea.entity.convert.*;
import tea.ui.TeaServlet;

public class Course
{
	protected static Cache c = new Cache(50);
	public int node;
	public int language;
	public String org; //培训机构
	public String address; //培训地址
	public String tel; //联系电话
	public float price; //培训费用
	public Date regstop; //报名截止时间
	public int quantity; //报名人数

	public Course(int node,int language)
	{
		this.node = node;
		this.language = language;
	}

	public static Course find(int node,int language) throws SQLException
	{
		Course t = (Course) c.get(node);
		if(t == null)
		{
			ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
			t = al.size() < 1 ? new Course(node,language) : (Course) al.get(0);
		}
		return t;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			java.sql.ResultSet rs = db.executeQuery("SELECT node,language,org,address,tel,price,regstop,quantity FROM course WHERE 1=1" + sql,pos,size);
			while(rs.next())
			{
				int i = 1;
				Course t = new Course(rs.getInt(i++),rs.getInt(i++));
				t.org = rs.getString(i++);
				t.address = rs.getString(i++);
				t.tel = rs.getString(i++);
				t.price = rs.getFloat(i++);
				t.regstop = db.getDate(i++);
				t.quantity = rs.getInt(i++);
				c.put(t.node,t);
				al.add(t);
			}
			rs.close();
		} finally
		{
			db.close();
		}
		return al;
	}

	public static int count(String sql) throws SQLException
	{
		return DbAdapter.execute("SELECT COUNT(*) FROM course WHERE 1=1" + sql);
	}

	public void set() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int i = db.executeUpdate("INSERT INTO course(node,language,org,address,tel,price,regstop,quantity)VALUES(" + node + "," + language + "," + DbAdapter.cite(org) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(tel) + "," + price + "," + DbAdapter.cite(regstop) + "," + quantity + ")");
			if(i < 1)
			{
				db.executeUpdate("UPDATE course SET org=" + DbAdapter.cite(org) + ",address=" + DbAdapter.cite(address) + ",tel=" + DbAdapter.cite(tel) + ",price=" + price + ",regstop=" + DbAdapter.cite(regstop) + ",quantity=" + quantity + " WHERE node=" + node);
			}
		} finally
		{
			db.close();
		}
		c.remove(node);
	}

	public void delete() throws SQLException
	{
		DbAdapter.execute("DELETE FROM course WHERE node=" + node);
		c.remove(node);
	}

	public void set(String f,String v) throws SQLException
	{
		DbAdapter.execute("UPDATE course SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
		c.remove(node);
	}

	//
	public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
	{
		StringBuilder htm = new StringBuilder();
		String subject = n.getSubject(h.language);
		ListingDetail detail = ListingDetail.find(listing,101,h.language);
		Iterator e = detail.keys();
		while(e.hasNext())
		{
			String name = (String) e.next(),value = null;
			int istype = detail.getIstype(name);
			if(istype == 0)
				continue;

			String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/course/" + n._nNode + "-" + h.language + ".htm";
			String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
			//int dq = detail.getQuantity(name);
			if(name.equals("subject"))
			{
				value = subject;
			} else if(name.equals("description"))
				value = n.getText(h.language).replaceAll("<[^>]+>","").replaceAll("&nbsp;| +"," ");
			else if(name.equals("content"))
				value = n.getText(h.language);
			else if(name.equals("starttime"))
				value = MT.f(n.getStartTime());
			else if(name.equals("stoptime"))
				value = MT.f(n.getStopTime());
			//else if(name.equals("picture"))
			//    value = picture == null ? null : "<img src='" + picture + "' />";
			else if(name.equals("video"))
			{
				String video = n.getVoice(h.language);
				if(video != null && video.length() > 1)
				{
					url = "/html/folder/37-1.htm?course=" + n._nNode + "&" + name + "=";
					StringBuilder sb = new StringBuilder();
					String[] arr = video.split("[|]");
					for(int i = 1;i < arr.length;i++)
					{
						Attch a = Attch.find(Integer.parseInt(arr[i]));
						int j = a.name.lastIndexOf('.');
						sb.append("<li><a href='" + url + a.attch + "' id='pic'><img src='" + a.path3 + "' /></a><span id='time'>" + MT.ss(a.numbers) + "</span><a href='" + url + a.attch + "' id='name'>" + a.name.substring(0,j) + "</a></li>");
					}
					value = sb.toString();
				}
			} else if(name.equals("paper"))
			{
				String paper = n.getFile(h.language);
				if(paper != null && paper.length() > 1)
				{
					url = "/html/folder/37-1.htm?course=" + n._nNode + "&" + name + "=";
					StringBuilder sb = new StringBuilder();
					String[] arr = paper.split("[|]");
					for(int i = 1;i < arr.length;i++)
					{
						Attch a = Attch.find(Integer.parseInt(arr[i]));
						int j = a.name.lastIndexOf('.');
						sb.append("<li><a href='" + url + a.attch + "' id='pic'><img src='" + a.path3 + "' /></a><span id='page'>" + a.numbers + "</span><a href='" + url + a.attch + "' id='name'><img src='/tea/image/netdisk/" + a.name.substring(j + 1) + ".gif' />" + a.name.substring(0,j) + "</a><span id='size'>" + f(new File(Http.REAL_PATH + a.path).length()) + "</span></li>");
					}
					value = sb.toString();
				}
			} else if(name.equals("planadd"))
			{
				url = "/Courses.do?act=planadd&node=" + n._nNode;
				Date stop = n.getStopTime();
				if(stop != null && stop.getTime() < System.currentTimeMillis())
				{
					url = "javascript:alert('已结束报名！');\" class=\"disabled";
				}
				value = "<a href=\"" + url + "\" target='_ajax'>我要报名</a>";
			} else
			{
				Course t = Course.find(n._nNode,h.language);
				try
				{
					Object tmp = Class.forName("tea.entity.node.Course").getField(name).get(t);
					if(tmp != null)
					{
						if(tmp instanceof Date)
							value = MT.f((Date) tmp);
						else
							value = tmp.toString();
					}
				} catch(Exception ex)
				{
				}
			}

			if(value == null)
				value = "";
			if(istype == 2 && value.length() < 1)
				continue;

			//限制字数
			value = detail.getOptionsToHtml(name,n,value);

			//显示连接的地方
			if(detail.getAnchor(name) != 0)
			{
				value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
			}
			htm.append(bi).append("<span id='CourseID" + name + "'>" + value + "</span>").append(ai);
		}
		return htm.toString();
	}

	public static String f(long size)
	{
		if(size > 1048576)
			return MT.f(size / 1048576F) + " MB";
		if(size > 1024)
			return MT.f(size / 1024F) + " KB";
		return "1 KB";
	}

	//
	public static Thread start() throws SQLException
	{
		if(Node.count(" AND type=101") < 1)
			return null;
		Thread t = new Thread()
		{
			public void run()
			{
				while(!isInterrupted())
				{
					try
					{
						Thread.sleep(60000);
						Iterator it = Attch.find(" AND state='paper' AND numbers=0",0,100).iterator();
						while(it.hasNext())
						{
							Attch t = (Attch) it.next();
							File f = new File(Http.REAL_PATH + t.path);
							try
							{
								String path = "/res/" + t.community + "/paper/" + (t.node / 2000) + "/";
								new File(Http.REAL_PATH + path).mkdir();
								path += t.node + "_" + t.attch + "_" + Math.random();

								Dispatch dp = Dispatch.get(Paper.P2F,"DefaultProfile").toDispatch();
								Dispatch.put(dp,"Skin",Paper.getSkin(t.community));
								Dispatch.call(Paper.P2F,"ConvertFile",f.getPath(),Http.REAL_PATH + path + ".swf");
								if(Dispatch.call(Paper.P2F,"MetadataFileCount").getInt() > 0)
								{
									File mf = new File(Http.REAL_PATH + path + ".xml");
									//t.ptext = Filex.read(mf.getPath(),"UTF-8");
									//t.ptext = t.ptext.substring(87,t.ptext.length() - 19);
									//mf.delete();
								}
								if(Dispatch.call(Paper.P2F,"ThumbnailFileCount").getInt() > 0)
								{
									t.path3 = path + "_1.jpg";
								}
								t.path2 = path + ".swf";
								t.numbers = Dispatch.call(Paper.P2F,"TotalPages").getInt();
							} catch(Exception ex)
							{
								t.numbers = -1;
								ex.printStackTrace();
							}
							t.set();
							Filex.logs("swf.txt","附件：" + t.attch + "　文件：" + f.getPath() + "　页数：" + t.length);
							TeaServlet.delete(Node.find(t.node));
						}
					} catch(InterruptedException ex)
					{
						interrupted();
					} catch(Exception ex)
					{
						ex.printStackTrace();
					}
				}
			}
		};
		t.start();
		return t;
	}
}
