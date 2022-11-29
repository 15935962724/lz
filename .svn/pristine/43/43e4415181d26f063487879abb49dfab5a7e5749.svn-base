package tea.entity.netdisk;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;

public class Safety
{
    private static Cache _cache = new Cache(100);
    public static final String APPLY_STYLE[] =
            {"只有该文件夹", "只有子文件夹", "该文件夹及子文件夹"};
    public static final String PUR_TYPE[] =
            {"列出文件夹目录", "读取", "读取和写入", "完全控制"};
    private int safety;
    private String community;
    private String path;
    private int style;
    private int purview; //0:列出文件夹目录,1:读取,2:写入,3:删除
    private String role;
    private String unit;
    private String member;
    private boolean exists;
    public Safety(int safety) throws SQLException
    {
        this.safety = safety;
        load();
    }

    public static Safety find(int safety) throws SQLException
    {
        return new Safety(safety);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,path,style,purview,role,unit,member FROM Safety WHERE safety=" + safety);
            if (db.next())
            {
                community = db.getString(1);
                path = db.getString(2);
                style = db.getInt(3);
                purview = db.getInt(4);
                role = db.getString(5);
                unit = db.getString(6);
                member = db.getString(7);
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

    public static void create(String community, String path, int style, int purview, String role, String unit, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Safety(community,path,style,purview,role,unit,member)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(path) + "," + style + "," + purview + "," + DbAdapter.cite(role) + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(member) + ")");
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Safety WHERE safety=" + safety);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(safety));
    }

    public void set(int style, int purview, String role, String unit, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Safety SET style=" + style + ",purview=" + purview + ",role=" + DbAdapter.cite(role) + ",unit=" + DbAdapter.cite(unit) + ",member=" + DbAdapter.cite(member) + " WHERE safety=" + safety);
        } finally
        {
            db.close();
        }
        this.style = style;
        this.purview = purview;
        this.role = role;
        this.unit = unit;
        this.member = member;
    }

    /****枚举列出那个路径对应的相应信息******/
    public static Enumeration findByPath(String community, String path) throws SQLException
    {
        NetDisk obj = NetDisk.find(community, path);
        String extend = obj.getParentEx();
        Vector v = new Vector();
        StringBuilder sql = new StringBuilder();
        DbAdapter db = new DbAdapter();
        sql.append("SELECT safety FROM Safety WHERE community=").append(DbAdapter.cite(community)).append(" AND (");
        sql.append("    ( style=0 AND path=").append(DbAdapter.cite(path)).append(")");
        //只有子文件夹////////
        sql.append(" OR ( style=1");
        if (extend != null && extend.length() > 0)
        {
            sql.append(" AND path>=" + DbAdapter.cite(extend));
        }
        sql.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("path", "'_%'") + ")");
        //该文件夹及子文件夹////////
        sql.append(" OR ( style=2");
        if (extend != null && extend.length() > 0)
        {
            sql.append(" AND path>=" + DbAdapter.cite(extend));
        }
        sql.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("path", "'%'") + ")");
        //向上继承//////////
        sql.append(" OR ( path LIKE " + DbAdapter.cite(path + "%") + " )");
        sql.append(")");
        try
        {
            //System.out.println(sql.toString());
            db.executeQuery(sql.toString());
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

    public static int findByMember(String community, String path, String member) throws SQLException
    {
        int j = -1;
        //=====会员=================================//
        AdminUsrRole aur = AdminUsrRole.find(community, member);
        int unit = aur.getUnit();
        String rs[] = aur.getRole().split("/");
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT purview FROM Safety WHERE community=").append(DbAdapter.cite(community));
        sql.append(" AND( unit LIKE ").append(DbAdapter.cite("%/" + unit + "/%"));
        for (int i = 1; i < rs.length; i++)
        {
            sql.append(" OR role LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
        }
        sql.append(" OR member LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
        sql.append(")");
        //======================================//
        DbAdapter db = new DbAdapter();
        NetDisk obj = NetDisk.find(community, path);
        if(obj.isType())
        {
        	path=obj.getParent();
        	obj = NetDisk.find(community, path);
        }
        String extend = obj.getParentEx();
        StringBuilder s2 = new StringBuilder();
        s2.append(" AND(   ( style=0 AND path=").append(DbAdapter.cite(path)).append(")");
        //只有子文件夹////////
        s2.append(" OR ( style=1");
        if (extend != null && extend.length() > 0)
        {
            s2.append(" AND path>=" + DbAdapter.cite(extend));
        }
        s2.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("path", "'_%'") + ")");
        //该文件夹及子文件夹////////
        s2.append(" OR ( style=2");
        if (extend != null && extend.length() > 0)
        {
            s2.append(" AND path>=" + DbAdapter.cite(extend));
        }
        s2.append(" AND " + DbAdapter.cite(path) + " LIKE " + db.concat("path", "'%'") + ")");
        s2.append(") ORDER BY purview DESC");
        try
        {
            db.executeQuery(sql.toString() + s2.toString());
            if (db.next())
            {
                j = db.getInt(1);
            } else
            { 	//向上继承//////////
                db.executeQuery(sql.toString() + " AND path LIKE " + DbAdapter.cite(path + "%"));
                if (db.next())
                {
                    j = 0;
                }
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public String getUnit()
    {
        return unit;
    }

    public int getSafety()
    {
        return safety;
    }

    public String getRole()
    {
        return role;
    }

    public String getRoleToHtml() throws SQLException
    {
        String rs[] = role.split("/");
        StringBuilder sb = new StringBuilder();
        for (int j = 1; j < rs.length; j++)
        {
            AdminRole ar = AdminRole.find(Integer.parseInt(rs[j]));
            if (ar.isExists())
            {
                sb.append(ar.getName()).append(" ");
            }
        }
        return sb.toString();
    }

    public String getUnitToHtml() throws SQLException
    {
        String us[] = unit.split("/");
        StringBuilder sb = new StringBuilder();
        for (int j = 1; j < us.length; j++)
        {
            AdminUnit au = AdminUnit.find(Integer.parseInt(us[j]));
            if (au.isExists())
            {
                sb.append(au.getName()).append(" ");
            }
        }
        return sb.toString();
    }

    public String getMemberToHtml() throws SQLException
    {
        return member.replace('/', ' ');
    }

    public int getPurview()
    {
        return purview;
    }

    public int getPurview(String p)
    {
        int i = -1;
        if (style == 1 && path.equals(p))
        {
            i = 0;
        } else if (p.startsWith(path))
        {
            i = purview;
        } else if (path.startsWith(p))
        {
            i = 0;
        }
        return i;
    }

    public String getPath()
    {
        return path;
    }

    public String getMember()
    {
        return member;
    }

    public int getStyle()
    {
        return style;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }
}
