package tea.entity.sup;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class SupQualification
{
	protected static Cache c = new Cache(50);
	public int qualification; //设备物资分类
	public int father; //父类
	public String path = "|"; //路径
	public String name; //名称
	public String code; //编码
	public String spec; //规格
	public String unit; //单位
	public String brand = "|"; //品牌
	public int child; //子节点数
	public boolean deleted; //是否已删除

	public SupQualification(int qualification)
	{
		this.qualification = qualification;
	}

	public static SupQualification find(int qualification) throws SQLException
	{
		SupQualification t = (SupQualification) c.get(qualification);
		if(t == null)
		{
			ArrayList al = find(" AND qualification=" + qualification,0,1);
			t = al.size() < 1 ? new SupQualification(qualification) : (SupQualification) al.get(0);
		}
		return t;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			java.sql.ResultSet rs = db.executeQuery("SELECT qualification,father,path,name,code,spec,unit,brand,child,deleted FROM supqualification WHERE 1=1" + sql + " ORDER BY code",pos,size);
			while(rs.next())
			{
				int i = 1;
				SupQualification t = new SupQualification(rs.getInt(i++));
				t.father = rs.getInt(i++);
				t.path = rs.getString(i++);
				t.name = rs.getString(i++);
				t.code = rs.getString(i++);
				t.spec = rs.getString(i++);
				t.unit = rs.getString(i++);
				t.brand = rs.getString(i++);
				t.child = rs.getInt(i++);
				t.deleted = rs.getBoolean(i++);
				c.put(t.qualification,t);
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
		return DbAdapter.execute("SELECT COUNT(*) FROM supqualification WHERE 1=1" + sql);
	}

	public int set() throws SQLException
	{
		c.remove(qualification);
		boolean isNew = qualification < 1;
		if(isNew)
			qualification = Seq.get();
		path = SupQualification.find(father).path += qualification + "|";
		String sql;
		if(isNew)
			sql = ("INSERT INTO supqualification(qualification,father,path,name,code,spec,unit,brand,child,deleted)VALUES(" + qualification + "," + father + "," + DbAdapter.cite(path) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(spec) + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(brand) + "," + child + "," + DbAdapter.cite(deleted) + ")");
		else
			sql = ("UPDATE supqualification SET father=" + father + ",path=" + DbAdapter.cite(path) + ",name=" + DbAdapter.cite(name) + ",code=" + DbAdapter.cite(code) + ",spec=" + DbAdapter.cite(spec) + ",unit=" + DbAdapter.cite(unit) + ",brand=" + DbAdapter.cite(brand) + ",child=" + child + ",deleted=" + DbAdapter.cite(deleted) + " WHERE qualification=" + qualification);
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(qualification,sql);
			if(isNew)
			{
				db.executeUpdate(qualification,"UPDATE supqualification SET child=child+1 WHERE qualification=" + father);
				c.remove(father);
			}
		} finally
		{
			db.close();
		}
		return qualification;
	}

	public void delete() throws SQLException
	{
		deleted = true;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(father,"UPDATE supqualification SET child=child-1 WHERE qualification=" + father);
			db.executeUpdate(qualification,"UPDATE supqualification SET deleted=" + DbAdapter.cite(deleted) + " WHERE qualification=" + qualification);
		} finally
		{
			db.close();
		}
		c.remove(qualification);
		c.remove(father);
	}

	public void set(String f,String v) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(qualification,"UPDATE supqualification SET " + f + "=" + DbAdapter.cite(v) + " WHERE qualification=" + qualification);
		} finally
		{
			db.close();
		}
		c.remove(qualification);
	}

	//
	public static String options(int qualification,int v) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		SupQualification t = SupQualification.find(qualification);
		sb.append("<option value=" + t.qualification);
		if(v == t.qualification)
			sb.append(" selected");
		sb.append(">" + t.name);
		opt(sb,t.qualification,v,"");
		return sb.toString();
	}

	private static void opt(StringBuilder sb,int qualification,int v,String prefix) throws SQLException
	{
		Iterator it = findByFather(qualification).iterator();
		while(it.hasNext())
		{
			SupQualification t = (SupQualification) it.next();
			sb.append("<option value=" + t.qualification);
			if(v == t.qualification)
				sb.append(" selected");
			sb.append(">" + prefix + (it.hasNext() ? "├ " : "└ ") + t.name);
			//if(t.type == 0)
			opt(sb,t.qualification,v,prefix + "│ ");
		}
	}
	public static String getTree2(int qualification,String sb,int count,int node)throws SQLException{
		
		ArrayList aList= SupQualification.findByFather(qualification);
		if (aList.size()<1) {
			return sb;
		}
		StringBuffer tree=new StringBuffer().append(sb);
		count++;
		tree.append("<ul class='ul"+count+"'>");
		for(int i=0;i<aList.size();i++){
			SupQualification s=(SupQualification)aList.get(i);
			if(count==2){
				tree.append("<li><a href='/html/jskxcbs/folder/"+node+"-1.htm?qualification="+s.qualification+"'>["+s.name+"]</a></li>");
			}
			if(count==3){
				if(i==(aList.size()-1)){
					tree.append("<li><a href='/html/jskxcbs/folder/"+node+"-1.htm?qualification="+s.qualification+"'>"+s.name+"</a></li>");
				}else{
					tree.append("<li><a href='/html/jskxcbs/folder/"+node+"-1.htm?qualification="+s.qualification+"'>"+s.name+"  |</a></li>");
				}
				
			}
			tree=new StringBuffer("").append(getTree2(s.qualification, tree.toString(), count,node));
		}
		tree.append("</ul>");
		return tree.toString();
	}
	public String getPath() throws SQLException
	{
		return(father < 1 ? "|" : SupQualification.find(father).getPath()) + qualification + "|";
	}

	public static ArrayList findByFather(int father) throws SQLException
	{
		return find(" AND father=" + father + " AND deleted=0",0,200);
	}

	public static SupQualification getRoot() throws SQLException
	{
		Iterator it = findByFather(0).iterator();
		if(it.hasNext())
		{
			return(SupQualification) it.next();
		}
		SupQualification ro = new SupQualification(0);
		ro.name = "图书分类";
		ro.code = "00";
		ro.set();
		return getRoot();
	}

	public String getName(int lang) throws SQLException
	{
		return(father > 1 ? find(father).getName(lang) : "") + " >> " + name;
	}

	public String getBrand() throws SQLException
	{
		StringBuilder sb = new StringBuilder("|");
		String[] ac = getPath().split("[|]");
		for(int i = 1;i < ac.length;i++)
		{
			SupQualification c = SupQualification.find(Integer.parseInt(ac[i]));
			String[] arr = c.brand.split("[|]");
			for(int j = 1;j < arr.length;j++)
				if(sb.indexOf("|" + arr[j] + "|") == -1)
					sb.append(arr[j]).append("|");
		}
//        Iterator it = findByFather(category).iterator();
//        while(it.hasNext())
//        {
//            Category c = (Category) it.next();
//            String[] arr = c.brand.split("[|]");
//            for(int i = 1;i < arr.length;i++)
//                if(sb.indexOf("|" + arr[i] + "|") == -1)
//                    sb.append(arr[i]).append("|");
//        }
		return sb.toString();
	}

	public String getAnchor() throws SQLException
	{
		return(father > 0 ? find(father).getAnchor() : "") + " >> <a href='?qualification=" + qualification + "'>" + name + "</a>";
	}

//    public String toTree(int member) throws SQLException
//    {
//        StringBuilder h = new StringBuilder();
//        String menus = member > 0 ? Member.find(member).getSupQualification() : null;
//
//        Iterator it = SupQualification.findByFather(menu).iterator();
//        while(it.hasNext())
//        {
//            SupQualification t = (SupQualification) it.next();
//            if(member < 1)
//            {
//                h.append("<img src='/tea/image/tree/" + (t.type == 0 ? "plus" : "minus") + ".gif' onclick='tree(this," + t.menu + ")' align=absmiddle>");
//                h.append("<span onmouseover='mt.mouse(this,1)' onmouseout='mt.mouse(this,0)'>&nbsp;<a href='SupQualificationEdit.jsp?menu=" + t.menu + "'>");
//                if(t.hidden)
//                    h.append("<strike>");
//                h.append(t.name + "</strike></a>");
//                if(t.type == 0)
//                    h.append("　<a href='SupQualificationEdit.jsp?father=" + t.menu + "' style='display:none'>添加</a>");
//                h.append("</span><br/>");
//            } else
//            {
//                if(t.hidden || menus.indexOf("|" + t.menu + "|") == -1)
//                    continue;
//                h.append("<a href='" + (t.type == 0 ? "javascript:;' onclick='tree(this," + t.menu + ")" : "SupQualificationRight.jsp?menu=" + t.menu) + "' target='" + t.target + "'>");
//                h.append("<img src='/tea/image/tree/" + (t.type == 0 ? "plus" : "minus") + ".gif' align=absmiddle>&nbsp;" + t.name + "</a>");
//            }
//            h.append("<div class='tree' style='display:none'></div>\r\n");
//        }
//        return h.toString();
//    }

	//ids: 默认展开  dept:工程局
	public String toTree(String ids,int dept,String sql) throws SQLException
	{
		StringBuilder htm = new StringBuilder();
		Iterator it = SupQualification.find(" AND father=" + qualification + " AND deleted=0" + sql,0,Integer.MAX_VALUE).iterator();
		while(it.hasNext())
		{
			SupQualification t = (SupQualification) it.next();
			int count = sql.length() < 1 ? t.child : SupQualification.count(" AND father=" + t.qualification + " AND deleted=0" + sql);
			boolean sub = count > 0 && ids.contains("|" + t.qualification + "|");
			//工程局数量
			int sum = 0;
			if(dept != 0)
			{
				StringBuilder sqlf = new StringBuilder();
				if(dept > 0)
					sqlf.append(" AND sp.dept2 LIKE " + DbAdapter.cite("%|" + dept + "|%"));
				else
					sqlf.append(" AND sp.dept2 NOT IN('|','|" + -dept + "|')");
				sqlf.append(" AND(");
				ArrayList al = SupQualification.find(" AND path LIKE " + DbAdapter.cite(t.path + "%"),0,Integer.MAX_VALUE);
				//ArrayList al = SupQualification.findByFather(t.qualification);
				//确定后的分类
				sqlf.append(" (ssd.dept=" + dept + " AND(ssd.qualification LIKE " + DbAdapter.cite("%|" + t.qualification + "|%"));
				for(int j = 0;j < al.size();j++)
				{
					SupQualification sq = (SupQualification) al.get(j);
					sqlf.append(" OR ssd.qualification LIKE " + DbAdapter.cite("%|" + sq.qualification + "|%"));
				}
				sqlf.append("))");
				//未确定后的分类
				sqlf.append(" OR(ssd.dept IS NULL AND(sp.qualification LIKE " + DbAdapter.cite("%|" + t.qualification + "|%"));
				for(int j = 0;j < al.size();j++)
				{
					SupQualification sq = (SupQualification) al.get(j);
					sqlf.append(" OR sp.qualification LIKE " + DbAdapter.cite("%|" + sq.qualification + "|%"));
				}
				sqlf.append("))");
				sqlf.append(")");
				//sum = SupSupplier.count(sqlf.toString());
			}
			htm.append("<div id='" + t.qualification + "' data='" + t.toString() + "' class='nowrap child_" + count + "'><img src='/tea/image/tree/" + (sub || count == 0 ? "minus" : "plus") + ".gif' onclick='mt.tree(this)' align=absmiddle>");
			htm.append("&nbsp;<a href='javascript:;' onclick='mt.click(this)' oncontextmenu='return mt.menu(event,cm(" + t.qualification + "))'>[" + (t.code.startsWith(code) ? t.code.substring(code.length()) : t.code) + "]" + t.name);
			if(sum > 0)
				htm.append("<span>(" + sum + ")</span>");
			htm.append("</a></div>");
			htm.append("<div class='tree' style='display:" + (sub ? "" : "none") + "'>");
			if(sub)
				htm.append(t.toTree(ids,dept,sql));
			htm.append("</div>\r\n");
		}
		return htm.toString();
	}

	//新入会承包商
	public static void cache() throws SQLException,IOException
	{
		StringBuilder htm = new StringBuilder();
		htm.append("var qua=[ ");
		Iterator it = SupQualification.find(" AND deleted=0",0,Integer.MAX_VALUE).iterator();
		while(it.hasNext())
			htm.append((SupQualification) it.next()).append(",");
		htm.setCharAt(htm.length() - 1,']');
		htm.append(";");
		Filex.write(Http.REAL_PATH + "/res/GYS/cache/qua.js",htm.toString());
	}

	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("{id:" + qualification);
		sb.append(",name:" + Attch.cite(name));
		sb.append(",father:" + father);
		sb.append(",path:" + Attch.cite(path));
		sb.append(",code:" + Attch.cite(code));
		sb.append(",spec:" + Attch.cite(spec));
		sb.append(",unit:" + Attch.cite(unit));
		sb.append(",child:" + child);
		sb.append("}");
		return sb.toString();
	}

	public static String f(String str) throws NumberFormatException,SQLException
	{
		StringBuilder qua = new StringBuilder();
		String[] arr = str.split("[|]");
		for(int i = 1;i < arr.length;i++)
		{
			SupQualification q = SupQualification.find(Integer.parseInt(arr[i]));
			qua.append("<span id='_q" + q.qualification + "' path='" + q.path + "'><input type='hidden' name='qualification' value='" + q.qualification + "' />" + q.name + "<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>");
		}
		return qua.toString();
	}

	public static String f(String str,String sp) throws NumberFormatException,SQLException
	{
		StringBuilder qua = new StringBuilder();
		String[] arr = str.split("[|]");
		for(int i = 1;i < arr.length;i++)
		{
			SupQualification q = SupQualification.find(Integer.parseInt(arr[i]));
			qua.append(q.name).append(sp);
		}
		return qua.toString();
	}

}
