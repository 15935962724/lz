package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.lang.reflect.Field;
import tea.ui.TeaSession;

public class Stamp extends Entity
{
	//protected static Cache _cache = new Cache(50);
	public int node;
	public int language;
	public String code; //编号
	public String picture; //照片
	public String recommend; //推荐图片
	public String inumber; //发行张数
	public float denomination; //面额
	public String designer; //设计师
	public String dimension; //尺寸
	public String perforation; //齿孔
	public String part; //组成
	public String specification; //整张规格
	public String printers; //印刷商
	public String printing; //印刷工艺
	public Date rtime; //发行日期

	public Stamp(int node,int language)
	{
		this.node = node;
		this.language = language;
	}

	public static Stamp find(int node,int language) throws SQLException
	{
		Stamp t = (Stamp) _cache.get(node + ":" + language);
		if(t == null)
		{
			language = Node.getLanguage(node,language);
			ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
			t = al.size() < 1 ? new Stamp(node,language) : (Stamp) al.get(0);
		}
		return t;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			java.sql.ResultSet rs = db.executeQuery("SELECT node,language,code,picture,recommend,inumber,denomination,designer,dimension,perforation,part,specification,printers,printing,rtime FROM Stamp WHERE 1=1" + sql,pos,size);
			while(rs.next())
			{
				int i = 1;
				Stamp t = new Stamp(rs.getInt(i++),rs.getInt(i++));
				t.code = rs.getString(i++);
				t.picture = rs.getString(i++);
				t.recommend = rs.getString(i++);
				t.inumber = rs.getString(i++);
				t.denomination = rs.getFloat(i++);
				t.designer = rs.getString(i++);
				t.dimension = rs.getString(i++);
				t.perforation = rs.getString(i++);
				t.part = rs.getString(i++);
				t.specification = rs.getString(i++);
				t.printers = rs.getString(i++);
				t.printing = rs.getString(i++);
				t.rtime = db.getDate(i++);
				_cache.put(t.node + ":" + t.language,t);
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
		return DbAdapter.execute("SELECT COUNT(*) FROM Stamp WHERE 1=1" + sql);
	}

	public void set() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate(node,"UPDATE Stamp SET code=" + DbAdapter.cite(code) + ",picture=" + DbAdapter.cite(picture) + ",recommend=" + DbAdapter.cite(recommend) + ",inumber=" + DbAdapter.cite(inumber) + ",denomination=" + denomination + ",designer=" + DbAdapter.cite(designer) + ",dimension=" + DbAdapter.cite(dimension) + ",perforation=" + DbAdapter.cite(perforation) + ",part=" + DbAdapter.cite(part) + ",specification=" + DbAdapter.cite(specification) + ",printers=" + DbAdapter.cite(printers) + ",printing=" + DbAdapter.cite(printing) + ",rtime=" + DbAdapter.cite(rtime) + " WHERE node=" + node + " AND language=" + language);
			if(j < 1)
			{
				db.executeUpdate(node,"INSERT INTO Stamp(node,language,code,picture,recommend,inumber,denomination,designer,dimension,perforation,part,specification,printers,printing,rtime)VALUES(" + node + "," + language + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(recommend) + "," + DbAdapter.cite(inumber) + "," + denomination + "," + DbAdapter.cite(designer) + "," + DbAdapter.cite(dimension) + "," + DbAdapter.cite(perforation) + "," + DbAdapter.cite(part) + "," + DbAdapter.cite(specification) + "," + DbAdapter.cite(printers) + "," + DbAdapter.cite(printing) + "," + DbAdapter.cite(rtime) + ")");
			}
		} finally
		{
			db.close();
		}
		_cache.remove(node);
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(node,"DELETE FROM Stamp WHERE node=" + node + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_cache.remove(node + ":" + language);
	}

	public void set(String f,String v) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(node,"UPDATE Stamp SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_cache.remove(node + ":" + language);
	}

	//
	public String getDetail(Node n,Http h,int listing,String target) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		String subject = n.getSubject(h.language);
		ListingDetail detail = ListingDetail.find(listing,11,h.language);
		Iterator e = detail.keys();
		while(e.hasNext())
		{
			String name = (String) e.next(),value = null;
			int istype = detail.getIstype(name);
			if(istype == 0)
				continue;

			String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
			int dq = detail.getQuantity(name);
			int an = detail.getAnchor(name);
			if(name.equals("subject"))
				value = subject;
			else if(name.equals("content"))
				value = n.getText(h.language);
			else if(name.equals("picture"))
				value = picture == null ? null : "<img src='" + picture + "' />";
			else if(name.equals("recommend"))
				value = recommend == null ? null : "<img src='" + recommend + "' />";
			else if(name.equals("rtime") && an == 2) //英文日期
			{
				an = 0;
				value = Entity.sdf_en.format(rtime);
			} else
			{
				try
				{
					Object tmp = Class.forName("tea.entity.node.Stamp").getField(name).get(this);
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
			if(an != 0)
			{
				value = "<a href='" + n.getAnchor(h.language,h.status) + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
			}
			sb.append(bi).append("<span id='StampID" + name + "'>" + value + "</span>").append(ai);
		}
		return sb.toString();
	}

}
