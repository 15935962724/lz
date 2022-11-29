package tea.entity.node;

import java.io.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.AdminUnit;
import java.text.NumberFormat;
import com.lowagie.text.Phrase;
import com.lowagie.text.HeaderFooter;
import java.sql.SQLException;

public class Cebbank extends Entity
{
	private static Cache _cache = new Cache(100);
	private String cebbank;
	private int node;
	private String member; // 审批者
	private Date time; // 审批时间
	private boolean exists;
	private int pid; // 创建者的所属部门编号

	public Cebbank(int node) throws SQLException
	{
		this.node = node;
		loadBasic();
	}

	public static Cebbank find(int _nNode) throws SQLException
	{
		Cebbank node = (Cebbank) _cache.get(new Integer(_nNode));
		if (node == null)
		{
			node = new Cebbank(_nNode);
			_cache.put(new Integer(_nNode), node);
		}
		return node;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT cebbank ,member,time,pid FROM Cebbank  WHERE node=" + node);
			if (db.next())
			{
				cebbank = db.getString(1);
				member = db.getString(2);
				time = db.getDate(3);
				pid = db.getInt(4);
				exists = true;
			} else
			{
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static int create(int node, String cebbank, String member) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Cebbank(node,cebbank,member,time)VALUES(" + node + "," + DbAdapter.cite(cebbank) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(new java.util.Date()) + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(node));
		return node;
	}

	public static int create(int node, int pid) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Cebbank(node,pid)VALUES(" + node + "," + pid + ")");
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(node));
		return node;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE Cebbank WHERE node=" + node);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(node));
	}

	public synchronized String set(String type, String assignee, int year, String member, String community) throws SQLException
	{
		time = new java.util.Date();
		AdminUnit au = AdminUnit.findByPid(getPid(), community);
		int serial = (au.getSerial()) + 1;
		java.text.DecimalFormat df = new java.text.DecimalFormat("0000");
		String str = df.format((long) serial);
		String code = type + "-" + assignee + year + getPid() + str;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Cebbank SET cebbank=" + DbAdapter.cite(code) + ",member=" + DbAdapter.cite(member) + ",time=" + DbAdapter.cite(time) + " WHERE node=" + node);
			this.cebbank = code;
			au.setSerial(serial);
			this.member = member;
		} finally
		{
			db.close();
		}
		return code;
	}

	public String getCebbank()
	{
		return cebbank;
	}

	public int getNode()
	{
		return node;
	}

	public String getMember()
	{
		return member;
	}

	public Date getTime()
	{
		return time;
	}

	public boolean isExists()
	{
		return exists;
	}

	public int getPid()
	{
		return pid;
	}

	public void getPdf(OutputStream out, int type, int language)
	{
		com.lowagie.text.Document document = new com.lowagie.text.Document(com.lowagie.text.PageSize.A4);
		com.lowagie.text.pdf.PdfWriter pdfw = null;
		// java.io.File file=java.io.File.createTempFile("000", ".pdf", new java.io.File(application.getRealPath("/tea/image/type/" + s + "/")));
		try
		{
			pdfw = com.lowagie.text.pdf.PdfWriter.getInstance(document, out); // new FileOutputStream(file));
			pdfw.setEncryption(com.lowagie.text.pdf.PdfWriter.STRENGTH128BITS, null, null, com.lowagie.text.pdf.PdfWriter.AllowCopy | com.lowagie.text.pdf.PdfWriter.AllowPrinting);
			com.lowagie.text.pdf.BaseFont bfChinese = com.lowagie.text.pdf.BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", com.lowagie.text.pdf.BaseFont.NOT_EMBEDDED);
			com.lowagie.text.Font fontchinese = new com.lowagie.text.Font(bfChinese, 12, com.lowagie.text.Font.NORMAL);

			tea.entity.node.Node node_obj = tea.entity.node.Node.find(node);

			HeaderFooter header = new HeaderFooter(new Phrase(node_obj.getSubject(language), fontchinese), true);
			document.setHeader(header);

			document.open();
			/*
			 * String code = " " + "编号" + ":" + this.getCebbank(); document.add(new com.lowagie.text.Paragraph(code, fontchinese)); document.add(new com.lowagie.text.Paragraph(""));
			 */

			/*
			 * java.util.Enumeration enumer = tea.entity.site.DynamicType.findByDynamic(type); StringBuilder sb=new StringBuilder(); while (enumer.hasMoreElements()) { int id = ((Integer) enumer.nextElement()).intValue(); tea.entity.site.DynamicType dt = tea.entity.site.DynamicType.find(id); tea.entity.node.DynamicValue dv = tea.entity.node.DynamicValue.find(node, language, id);
			 *
			 * sb.append(dt.getBefore(language)+dv.getValue()+dt.getAfter(language));
			 *  } document.add(new com.lowagie.text.Paragraph(deleteHtml(sb.toString()), fontchinese));
			 */
			com.lowagie.text.html.HtmlParser.parse(document, "http://127.0.0.1:83/a.html");
		} catch (Exception ioe)
		{
			System.err.println(ioe.getMessage());
		} finally
		{
			document.close();
			if (pdfw != null)
			{
				pdfw.close();
			}
		}
	}

	private String deleteHtml(String text)
	{
		int start;
		while ((start = text.indexOf("<")) != -1)
		{
			int end = text.indexOf(">", start);
			if (end != -1)
			{
				text = text.substring(0, start) + text.substring(end + 1);
			} else
			{
				text = text.substring(0, start);
			}
		}
		return text;
	}
}
