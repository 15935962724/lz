package tea.entity.netdisk;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.ui.*;

public class FileCenter extends Entity
{
  public static Cache _cache = new Cache(100);
  public static String FIELD_TYPE[] =
	  {"----------------", "FileCenter.subject", "FileCenter.code", "FileCenter.make", "FileCenter.unit", "FileCenter.content"}; //, "FileCenter.valid"
  private int filecenter;
  private String community;
  private int father;
  private String path;
  private boolean extend; // true:继承,false:不继承
  private String member;
  private boolean type; // false:文件夹,true:文件
  private String subject;
  private String code; // 文件编号
  private boolean valid; // 文件版本
  private Date make; // 成文日期
  private String unit; // 部门
  private String word; //使用office编辑器,代替content时.此项存office的文件路径.
  private String content;
  private int filesize;
  private Date time;
  private String prefix;
  private int showtype; //查看标示
  private boolean exists;

  public FileCenter(int filecenter) throws SQLException
  {
	this.filecenter = filecenter;
	load();
  }

  public static FileCenter find(int filecenter) throws SQLException
  {
	FileCenter obj = (FileCenter) _cache.get(new Integer(filecenter));
	if (obj == null)
	{
	  obj = new FileCenter(filecenter);
	  _cache.put(new Integer(filecenter), obj);
	}
	return obj;
  }

  public void load() throws SQLException
  {
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeQuery("SELECT community,father,path,extend,member,type,subject,code,valid,make,unit,word,content,filesize,time,showtype FROM FileCenter WHERE filecenter=" + filecenter);
	  if (db.next())
	  {
		community = db.getString(1);
		father = db.getInt(2);
		path = db.getString(3);
		extend = db.getInt(4) != 0;
		member = db.getString(5);
		type = db.getInt(6) != 0;
		subject = db.getString(7);
		code = db.getString(8);
		valid = db.getInt(9) != 0;
		make = db.getDate(10);
		unit = db.getString(11);
		word = db.getString(12);
		content = db.getString(13);
		filesize = db.getInt(14);
		time = db.getDate(15);
		showtype = db.getInt(16);
		exists = true;
		prefix = "/res/" + community + "/netdisk";
	  } else
	  {
		exists = false;
	  }
	} finally
	{
	  db.close();
	}
  }

  public static int create(String community, int father, boolean extend, String member, boolean type, String subject, String code, boolean valid, Date make, String unit, String word, String content) throws SQLException
  {
	int id = 0;
	String path = "/";
	if (father > 0)
	{
	  path = FileCenter.find(father).getPath();
	}
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate("INSERT INTO FileCenter(community,father,extend,member,type,subject,code,valid,make,unit,word,content,time)VALUES(" + DbAdapter.cite(community) + "," + father + "," + DbAdapter.cite(extend) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(valid) + "," + db.cite(make) + "," + db.cite(unit) + "," + DbAdapter.cite(word) + "," + DbAdapter.cite(content) + "," + db.citeCurTime() + ")");
	  id = db.getInt("SELECT MAX(filecenter) FROM FileCenter");
	  db.executeUpdate("UPDATE FileCenter SET path=" + db.cite(path + id + "/") + " WHERE filecenter=" + id);
	} finally
	{
	  db.close();
	}
	return id;
  }

  public void move(int newfc) throws SQLException
  {
	String s1 = find(getFather()).getPath();
	FileCenter fc = find(newfc);
	String newpath = fc.getPath();
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate("UPDATE FileCenter SET father=" + newfc + ",path=" + DbAdapter.cite(newpath + filecenter + "/") + ",community=" + DbAdapter.cite(fc.getCommunity()) + " WHERE filecenter=" + filecenter);
	  db.executeUpdate("UPDATE FileCenter SET path=REPLACE(path," + DbAdapter.cite(s1) + ", " + DbAdapter.cite(newpath) + "),community=" + DbAdapter.cite(fc.getCommunity()) + " WHERE path LIKE " + DbAdapter.cite(path + "_%"));
	} finally
	{
	  db.close();
	}
	_cache.clear();
  }

  public void clone(String community, int father) throws SQLException
  {
	int newid = FileCenter.create(community, father, extend, member, type, subject, code, valid, make, unit, word, content);
	Enumeration e1 = FileCenterAttach.findByFileCenter(filecenter);
	while (e1.hasMoreElements())
	{
	  int _id = ( (Integer) e1.nextElement()).intValue();
	  FileCenterAttach obj = FileCenterAttach.find(_id);
	  obj.clone(newid);
	}
	if (!type)
	{
	  Enumeration e2 = FileCenter.findByFather(this.community, filecenter, null, false);
	  while (e2.hasMoreElements())
	  {
		int _id = ( (Integer) e2.nextElement()).intValue();
		FileCenter obj = FileCenter.find(_id);
		obj.clone(community, newid);
	  }
	}
  }

  public void set(String subject, String code, boolean valid, Date make, String unit, String word, String content) throws SQLException
  {
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate("UPDATE FileCenter SET subject=" + DbAdapter.cite(subject) + ",code=" + DbAdapter.cite(code) + ",valid=" + DbAdapter.cite(valid) + ",make=" + db.cite(make) + ",unit=" + db.cite(unit) + ",word=" + db.cite(word) + ",content=" + DbAdapter.cite(content) + " WHERE filecenter=" + filecenter);
	} finally
	{
	  db.close();
	}
	this.subject = subject;
	this.code = code;
	this.valid = valid;
	this.make = make;
	this.unit = unit;
	this.word = word;
	this.content = content;
  }

  public void set(int showtype) throws SQLException
  {
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate("UPDATE FileCenter SET showtype=" + showtype + " WHERE filecenter=" + filecenter);
	} finally
	{
	  db.close();
	}
	this.showtype = showtype;

  }

  public void setExtend(boolean extend) throws SQLException
  {
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate("UPDATE FileCenter SET extend=" + DbAdapter.cite(extend) + " WHERE community=" + db.cite(community) + " AND path=" + db.cite(path));
	} finally
	{
	  db.close();
	}
	this.extend = extend;
  }

  // 不接受继承的父路径///////////////////////////////
  public String getFatherEx() throws SQLException
  {
	String p = null;
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeQuery("SELECT MAX(path) FROM FileCenter WHERE extend=0 AND " + db.cite(path) + " LIKE " + db.concat("path", "'%'") + " AND path<=" + db.cite(path)); // type=0 AND
	  if (db.next())
	  {
		p = db.getString(1);
	  }
	} finally
	{
	  db.close();
	}
	return p;
  }

  public boolean isExtend()
  {
	return extend;
  }

  public void delete() throws SQLException
  {
	StringBuffer sb = new StringBuffer();
	sb.append("DELETE FROM FileCenter WHERE");
	if (isType())
	{
	  sb.append(" path=").append(DbAdapter.cite(path));
	} else
	{
	  sb.append(" path LIKE ").append(DbAdapter.cite(path + "%"));
	}
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeUpdate(sb.toString());
	  db.executeUpdate("DELETE FROM FileCenterAttach WHERE filecenter=" + filecenter);
	} finally
	{
	  db.close();
	}
	_cache.clear();
  }

  // base: 说明:null=没有链接
  public String getAncestor(int base) throws SQLException
  {
	return getAncestor(null, base);
  }

  public String getAncestor(String url, int base) throws SQLException
  {
	boolean bool = url != null;
	StringBuffer a = new StringBuffer();
	String bp = path;
	if (base > 0)
	{
	  FileCenter obj = FileCenter.find(base);
	  if (obj.getFather() > 0)
	  {
		obj = FileCenter.find(obj.getFather());
		bp = path.substring(obj.getPath().length() - 1);
	  }
	}
	// a.append("<a href=" + url + "&community=" + community + "&base=" + base + "&filecenter=" + 0 + ">");
	// a.append("根目录</a>");
	StringTokenizer st = new StringTokenizer(bp, "/");
	while (st.hasMoreTokens())
	{
	  int id = Integer.parseInt(st.nextToken());
	  FileCenter obj = FileCenter.find(id);
	  a.append(" / ");
	  if (bool)
	  {
		a.append("<a href=" + url + "&community=" + community + "&base=" + base + "&filecenter=" + id + ">");
	  }
	  a.append(obj.getSubject() + "</a>");
	}
	return a.toString();
  }

  public static Enumeration findByFather(String community, int father, String order, boolean asc) throws SQLException
  {
	return find(community, " AND father=" + father, order, asc);
  }

  public static Enumeration find(String community, String sql, String order, boolean asc) throws SQLException
  {
	StringBuffer sb = new StringBuffer();
	sb.append("SELECT filecenter FROM FileCenter WHERE community=").append(DbAdapter.cite(community));
	sb.append(sql);
	if (order != null)
	{
	  sb.append(" ORDER BY type,").append(order).append(asc ? " ASC" : " DESC");
	}
	Vector v = new Vector();
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeQuery(sb.toString());
	  while (db.next())
	  {
		v.add(new Integer(db.getInt(1)));
	  }
	} finally
	{
	  db.close();
	}
	return v.elements();
  }

  public static Enumeration findUnit(String community) throws SQLException
  {
	Vector v = new Vector();
	DbAdapter db = new DbAdapter();
	try
	{
	  db.executeQuery("SELECT DISTINCT unit FROM FileCenter WHERE community=" + DbAdapter.cite(community));
	  while (db.next())
	  {
		v.add(db.getString(1));
	  }
	} finally
	{
	  db.close();
	}
	return v.elements();
  }

  public static int getRootId(String community) throws SQLException
  {
	int root = 0;
	DbAdapter db = new DbAdapter();
	try
	{
	  root = db.getInt("SELECT filecenter FROM FileCenter WHERE community=" + DbAdapter.cite(community) + " AND father=0");
	} finally
	{
	  db.close();
	}
	if (root == 0)
	{
	  root = FileCenter.create(community, 0, true, "webmaster", false, "root", "", true, null, "", "", "");
	}
	return root;
  }

  public boolean isType()
  {
	return type;
  }

  public Date getTime()
  {
	return time;
  }

  public String getTimeToString()
  {
	if (time == null)
	{
	  return "";
	}
	return sdf2.format(time);
  }

  public String getPath()
  {
	return path;
  }

  public String getSubject()
  {
	return subject;
  }

  public String getEx()
  {
	String ex = "dir";
	if (isType())
	{
	  ex = subject.substring(subject.lastIndexOf(".") + 1);
	}
	return ex;
  }

  public String getMember()
  {
	return member;
  }

  public int getFileSize()
  {
	return filesize;
  }

  public String getCommunity()
  {
	return community;
  }

  public String getContent()
  {
	return content;
  }

  public String getContentToHtml()
  {
	return "时间:" + getTimeToString() + "&#13;" + "大小:" + getFileSize() + "&#13;路径:" + getPath() + "&#13;" + "描述:" + getContent();
  }

  public boolean isExists()
  {
	return exists;
  }

  public String getPrefix()
  {
	return prefix;
  }

  public int getFather()
  {
	return father;
  }

  public boolean isValid()
  {
	return valid;
  }

  public Date getMake()
  {
	return make;
  }

  public String getMakeToString()
  {
	if (make == null)
	{
	  return "";
	}
	return sdf.format(make);
  }

  public String getCode()
  {
	return code;
  }

  public String getUnit()
  {
	return unit;
  }

  public String getWord()
  {
	return word;
  }

  public int getFileCenter()
  {
	return filecenter;
  }

  public int getShowtype()
  {
	return showtype;
  }

  public String getTreeToHtml(TeaSession teasession, int step) throws SQLException
  {
	StringBuffer h = new StringBuffer();
	try
	{
	  tree(teasession, step, h);
	} catch (UnsupportedEncodingException ex)
	{
	}
	return h.toString();
  }

  private void tree(TeaSession teasession, int step, StringBuffer h) throws SQLException, UnsupportedEncodingException
  {
	StringBuffer s = new StringBuffer();
	for (int i = 0; i < step; i++)
	{
	  s.append("　 ");
	}
	Enumeration e = FileCenter.findByFather(teasession._strCommunity, filecenter, null, false);
	while (e.hasMoreElements())
	{
	  int id = ( (Integer) e.nextElement()).intValue();
	  FileCenter obj = FileCenter.find(id);
	  h.append(s);
	  h.append("<SPAN id=leftuptree").append(step).append(" >");
	  if (obj.isType()) // 文件
	  {
		h.append("<IMG SRC=/tea/image/tree/tree_minus.gif align=absmiddle ID=img").append(id).append(" />");
	  } else
	  {
		h.append("<a href=### onclick=f_ex('").append(id).append("',").append(step).append("); ID=a").append(step).append("><IMG SRC=/tea/image/tree/tree_plus.gif align=absmiddle ID=img").append(id).append(" /></a>");
	  }
	  h.append("<a href=### onclick=f_open('").append(id).append("');>").append(obj.getSubject()).append("</a>");
	  h.append("<br></SPAN>");
	  h.append("<Div id=divid").append(id).append(" style=display:none>");
	  // obj.tree(teasession, popedom, step + 1, def, h);
	  h.append("</Div>");
	}
  }
}
