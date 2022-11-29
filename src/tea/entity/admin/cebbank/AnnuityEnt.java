package tea.entity.admin.cebbank;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import java.math.*;
import java.sql.SQLException;

public class AnnuityEnt
{
	private static Cache _cache = new Cache(100);

	class Layer
	{
		private String name;
		private String content;
	}

	private Hashtable _htLayer;
	private String community;
	private int annuityent;
	private int father;
	private int sequence;
	private int plansum; // 参加计划数
	private int fundsum; // 投资组合数目
	private java.math.BigDecimal assets; // 总资产
	private int personsum; // 总人数
	private String code; // 客户号
	private String psword; // 密码

	private boolean exists;

	public AnnuityEnt(int annuityent) throws SQLException
	{
		_htLayer = new Hashtable();
		this.annuityent = annuityent;
		load();
	}

	public static AnnuityEnt find(int annuityent) throws SQLException
	{
		AnnuityEnt obj = (AnnuityEnt) _cache.get(new Integer(annuityent));
		if (obj == null)
		{
			obj = new AnnuityEnt(annuityent);
			_cache.put(new Integer(annuityent), obj);
		}
		return obj;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM annuityent WHERE annuityent=" + annuityent);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(annuityent));
		_cache.remove(community);
	}

	public void set(int sequence, int plansum, int fundsum, java.math.BigDecimal assets, int personsum, String code, String psword, int language, String name, String content) throws SQLException
	{
		if (exists)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE annuityent SET sequence=" + sequence + ",plansum=" + plansum + ",fundsum=" + fundsum + ",assets=" + assets + ",personsum=" + personsum + " ,code=" + DbAdapter.cite(code) + " , psword =" + psword + " WHERE annuityent=" + annuityent);
				int j = db.executeUpdate("UPDATE annuityentlayer SET name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + " WHERE annuityent=" + annuityent + " AND language=" + language);
				if (j < 1)
				{
					db.executeUpdate("INSERT INTO annuityentlayer (annuityent, language, name,content)VALUES(" + annuityent + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + ")");
				}
			} finally
			{
				db.close();
			}
			this.sequence = sequence;
			this.plansum = plansum;
			this.fundsum = fundsum;
			this.assets = assets;
			this.personsum = personsum;
			this.code = code;
			this.psword = psword;
			_htLayer.clear();
		} else
		{
			create(community, father, sequence, plansum, fundsum, assets, personsum, code, psword, language, name, content);
		}
	}

	public static int getRootId(String community) throws SQLException
	{
		Integer root_obj = (Integer) _cache.get(community);
		if (root_obj == null)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT annuityent FROM annuityent WHERE community=" + DbAdapter.cite(community) + " AND father=0");
				if (db.next())
				{
					root_obj = new Integer(db.getInt(1));
				}
			} finally
			{
				db.close();
			}

			// 本社区没有菜单,则创建基本菜单项
			if (root_obj == null)
			{
				int root = create(community, 0, 0, 1, 1, new BigDecimal("0"), 1, "webmaster", "123", 1, "根企业", "");
				root_obj = new Integer(root);
			}
			_cache.put(community, root_obj);
		}
		return root_obj.intValue();
	}

	public static int create(String community, int father, int sequence, int plansum, int fundsum, BigDecimal assets, int personsum, String code, String psword, int language, String name, String content) throws SQLException
	{
		int annuityent = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO annuityent (community,father,sequence,plansum,fundsum,assets,personsum,code,psword)VALUES(" + DbAdapter.cite(community) + "," + father + "," + sequence + " ," + plansum + " ," + fundsum + " ," + assets + " ," + personsum + " , " + DbAdapter.cite(code) + " , " + DbAdapter.cite(psword) + " )");
			annuityent = db.getInt("SELECT annuityent FROM annuityent ORDER BY annuityent DESC");
			db.executeUpdate("INSERT INTO annuityentlayer (annuityent, language, name,content)VALUES(" + annuityent + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + ")");
		} finally
		{
			db.close();
		}
		return annuityent;
	}

	public static void clone(int aimId, int sourceId, String community, boolean son) throws SQLException
	{
		AnnuityEnt obj = AnnuityEnt.find(sourceId);

		int newId = AnnuityEnt.create(obj.getCommunity(), aimId, obj.getSequence(), obj.getPlansum(), obj.getFundsum(), obj.getAssets(), obj.getPersonsum(), obj.getCode(), obj.getPsword(), 1, obj.getName(1), obj.getContent(1));
		if (son)
		{
			java.util.Enumeration enumer = AnnuityEnt.findByFather(sourceId);
			while (enumer.hasMoreElements())
			{
				clone(newId, ((Integer) enumer.nextElement()).intValue(), community, true);
			}
		}
	}

	public static java.util.Enumeration findByFather(int father) throws SQLException
	{
		java.util.Vector v = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT annuityent FROM annuityent WHERE father=" + (father) + " ORDER BY sequence");
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static int countByFather(int father) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(annuityent) FROM annuityent WHERE father=" + father);
			if (db.next())
			{
				count = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,father,sequence,plansum,fundsum,assets,personsum,code,psword FROM annuityent WHERE annuityent=" + annuityent);
			if (db.next())
			{
				community = db.getString(1);
				father = db.getInt(2);
				sequence = db.getInt(3);
				plansum = db.getInt(4);
				fundsum = db.getInt(5);
				assets = db.getBigDecimal(6, 2);
				personsum = db.getInt(7);
				code = db.getString(8);
				psword = db.getString(9);
				this.exists = true;
			} else
			{
				this.exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration find(String sql, int pos, int size) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT annuityent FROM annuityent WHERE 1=1" + sql + " ORDER BY sequence");
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public int getAnnuityent()
	{
		return annuityent;
	}

	public String getName(int language) throws SQLException
	{
		return getLayer(language).name;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			int j = getLanguage(i);
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT name,content FROM annuityentlayer WHERE annuityent=" + annuityent + " AND language=" + j);
				if (db.next())
				{
					layer.name = db.getVarchar(j, i, 1);
					layer.content = db.getVarchar(j, i, 2);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT language FROM annuityentlayer WHERE annuityent=" + annuityent);
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1)
		{
			return language;
		} else
		{
			if (language == 1)
			{
				if (v.indexOf(new Integer(2)) != -1)
				{
					return 2;
				}
			} else if (language == 2)
			{
				if (v.indexOf(new Integer(1)) != -1)
				{
					return 1;
				}
			}
			if (v.size() < 1)
			{
				return 0;
			}
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	public String getContent(int language) throws SQLException
	{
		return getLayer(language).content;
	}

	public int getSequence()
	{
		return sequence;
	}

	public int getFather()
	{
		return father;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isSon(int newfather) throws SQLException
	{
		if (newfather == annuityent)
		{
			return true;
		}
		do
		{
			AnnuityEnt obj = AnnuityEnt.find(newfather);
			newfather = obj.getFather();
			if (!obj.isExists() || newfather == annuityent)
			{
				return true;
			}
			if (newfather == 0)
			{
				return false;
			}
		} while (true);
	}

	public void setFather(int father) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE annuityent SET father=" + father + " WHERE annuityent=" + annuityent);
		} finally
		{
			db.close();
		}
		this.father = father;
	}

	public java.math.BigDecimal getAssets()
	{
		return assets;
	}

	public String getCode()
	{
		return code;
	}

	public int getFundsum()
	{
		return fundsum;
	}

	public int getPersonsum()
	{
		return personsum;
	}

	public int getPlansum()
	{
		return plansum;
	}

	public String getPsword()
	{
		return psword;
	}

}
