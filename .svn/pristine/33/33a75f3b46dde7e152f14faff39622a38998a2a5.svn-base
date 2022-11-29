package tea.entity.site;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;

/*
 招聘职业类别
 */
public class Occupation
{
    private static Cache _cache = new Cache(100);
    private int occupation;
    private int father;
    private String subject;
    private int sequence;
    private boolean exists;
    private String community;
    private String code;

    public Occupation(int occupation) throws SQLException
    {
        this.occupation = occupation;
        loadBasic();
    }

    public static Occupation find(int occupation) throws SQLException
    {
        Occupation obj = (Occupation) _cache.get(new Integer(occupation));
        if (obj == null)
        {
            obj = new Occupation(occupation);
            _cache.put(new Integer(occupation), obj);
        }
        return obj;
    }

    public static Occupation find(String community, String code) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT occupation FROM Occupation WHERE code=" + DbAdapter.cite(code) + " AND community=" + DbAdapter.cite(community));
            if (db.next())
            {
                id = db.getInt(1);
            } else
            {
//                return null;
            }
        } finally
        {
            db.close();
        }
        return find(id);
    }

    public static java.util.Enumeration findByFather(int father) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT occupation FROM Occupation WHERE father=" + father + " ORDER BY sequence");
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

    public static int getRootId(String community) throws SQLException
    {
        int root = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT occupation FROM Occupation WHERE father=0 AND community=" + DbAdapter.cite(community));
            if (db.next())
            {
                root = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        if (root == 0)
        {
            root = create(0, "", "根", 10, community);
            create(root, "01", "勘探", 20, community);
            create(root, "02", "开发", 30, community);
            create(root, "03", "钻井/采油", 40, community);
            create(root, "04", "工程", 50, community);
            create(root, "05", "石油炼化", 60, community);
            create(root, "06", "综合", 70, community);
            create(root, "9A", "物探（工）", 80, community);
            create(root, "9B", "钻井（工）", 90, community);
            create(root, "9C", "测井（工）", 100, community);
            create(root, "9D", "海洋采油（工）", 110, community);
            create(root, "9E", "井下作业（工）", 120, community);
            create(root, "9F", "化工（工）", 130, community);
            create(root, "9G", "分析化验（工）", 140, community);
            create(root, "9H", "海洋工程施工（工）", 150, community);
            create(root, "9I", "工程施工（工）", 160, community);
            create(root, "9J", "机械制造（工）", 170, community);
            create(root, "9K", "机械修理（工）", 180, community);
            create(root, "9L", "仪器仪表（工）", 190, community);
            create(root, "9M", "电气（工）", 200, community);
            create(root, "9N", "供水供热（工）", 210, community);
            create(root, "9O", "通信（工）", 220, community);
            create(root, "9P", "交通运输（工）", 230, community);
            create(root, "9Q", "物资供销（工）", 240, community);
            create(root, "9R", "健康安全环保（工）", 250, community);
            create(root, "9S", "技术监督（工）", 260, community);
            create(root, "9T", "计算机（工）", 270, community);
            create(root, "9U", "新闻出版（工）", 280, community);
            create(root, "9V", "后勤服务（工）", 290, community);
            create(root, "9X", "石油加工（工）", 300, community);
        }
        return root;
    }

    public void set(String code, String subject) throws SQLException
    {
        if (this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                //  db.executeUpdate("OccupationEdit " + occupation + "," + father + " ," +
                //	DbAdapter.cite(code) + " ," + DbAdapter.cite(subject) + " ," + sequence + " ," +
                //DbAdapter.cite(community));
                db.executeUpdate("UPDATE  Occupation SET  father =" + father + " ,code   =" + DbAdapter.cite(code) + ",subject =" + DbAdapter.cite(subject) + " ,sequence=" + sequence + ",community=" + DbAdapter.cite(community) + " WHERE occupation=" + occupation);
            } finally
            {
                db.close();
            }
            this.exists = true;
            this.code = code;
            this.subject = subject;
//            this._cache.clear();
//            _cache.remove(new Integer(occupation));
        } else
        {
            create(father, code, subject, sequence, community);
        }
    }

    public static int create(int father, String code, String subject, int sequence, String community) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Occupation(father,code,subject,sequence,community)VALUES(" + father + " ," + DbAdapter.cite(code) + "," + DbAdapter.cite(subject) + ", " + sequence + "," + DbAdapter.cite(community) + ")");
            i = db.getInt("SELECT MAX(occupation) FROM Occupation");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(i));
        return i;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE Occupation WHERE occupation=" + this.occupation);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(occupation));
    }

    public static String getNextCode(String community) throws SQLException
    {
        String code = "A0";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(code) FROM Occupation WHERE community= " + DbAdapter.cite(community));
            if (db.next())
            {
                code = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        for (int i = code.length(); i > 0; i--)
        {
            int ch = (int) code.charAt(i - 1);
            if (ch == 'Z')
            {
                ch = '1';
                code = code.substring(0, i - 1) + (char) ch + code.substring(i, code.length());
                continue;
            } else
            if (ch == '9')
            {
                ch = 'A';
            } else
            {
                ch = ch + 1;
            }
            code = code.substring(0, i - 1) + (char) ch + code.substring(i, code.length());
            break;
        }
        return code;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT    father ,  code,  subject,    sequence,community FROM Occupation WHERE occupation= " + occupation);
            if (db.next())
            {
                father = db.getInt(1);
                code = db.getString(2);
                subject = db.getVarchar(1, 1, 3);
                sequence = db.getInt(4);
                community = db.getString(5);
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


    public void setSequenceUp()
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT occupation FROM Occupation WHERE father=" + father + " AND community=" + DbAdapter.cite(community) + " ORDER BY sequence,subject");
            int occ;
            for (int index = 0; db.next(); index += 10)
            {
                occ = db.getInt(1);
                if (occ == this.occupation)
                {
                    db2.executeUpdate("UPDATE Occupation SET sequence=" + (index - 15) + " WHERE occupation=" + occ);
                } else
                {
                    db2.executeUpdate("UPDATE Occupation SET sequence=" + index + " WHERE occupation=" + occ);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
            db2.close();
        }

    }

    public void setSequenceDown()
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT occupation FROM Occupation WHERE father=" + father + " AND community=" + DbAdapter.cite(community) + " ORDER BY sequence,subject");
            int occ;
            for (int index = 0; db.next(); index += 10)
            {
                occ = db.getInt(1);
                if (occ == this.occupation)
                {
                    db2.executeUpdate("UPDATE Occupation SET sequence=" + (index + 15) + " WHERE occupation=" + occ);
                } else
                {
                    db2.executeUpdate("UPDATE Occupation SET sequence=" + index + " WHERE occupation=" + occ);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
            db2.close();
        }

    }


    public int getOccupation()
    {
        return occupation;
    }

    public int getFather()
    {
        return father;
    }

    public String getSubject()
    {
        return subject;
    }

    public int getSequence()
    {
        return sequence;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCode()
    {
        return code;
    }

}
