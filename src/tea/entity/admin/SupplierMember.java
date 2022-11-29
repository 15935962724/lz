package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class SupplierMember extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String member;
    private String company; //我有权限管理的公司
    private boolean exists;

    public static SupplierMember find(String community,String member) throws SQLException
    {
        SupplierMember t = new SupplierMember();
        t.community = community;
        t.member = member;
        t.company = AdminUsrRole.find(community,member).getCompany();
        return t;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM SupplierMember WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public void set(String company) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SupplierMember SET company=" + DbAdapter.cite(company) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.company = company;
    }

    public static void create(String community,String member,String company) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SupplierMember (community,member,company) VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(company) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + member);
    }


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM SupplierMember WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    //旗下有权限管理的公司///////
    public String toHtmlCompany(int language,int dv) throws SQLException
    {
        String cexs[] = getCompanyEx().split("/");
        StringBuilder sb = new StringBuilder();
        sb.append("<SELECT NAME=company ><OPTION VALUE=''>-------------------------");
        for(int i = 1;i < cexs.length;i++)
        {
            int node = Integer.parseInt(cexs[i]);
            sb.append("<OPTION VALUE=").append(node);
            if(node == dv)
            {
                sb.append(" SELECTED ");
            }
            sb.append(">").append(Node.find(node).getSubject(language));
        }
        sb.append("</SELECT>");
        return sb.toString();
    }

    //select * from Job where node in (select node from Node where rcreator = 'webmaster')
    //没有权限的职位管理 zhangjinshu 08-07-11添加
    public String toHtmlJob_NO(int language,int dv) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("<SELECT NAME=job ><OPTION VALUE=''>-------------------------");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Job WHERE node IN (SELECT node FROM Node WHERE type=50)");
            while(db.next())
            {
                int node = db.getInt(1);
                Node n = Node.find(node);
                if(n.getTime() != null)
                {
                    sb.append("<OPTION VALUE=").append(node);
                    if(node == dv)
                    {
                        sb.append(" SELECTED ");
                    }
                    sb.append(">").append(n.getSubject(language));
                }
            }
        } finally
        {
            db.close();
        }
        sb.append("</SELECT>");
        return sb.toString();
    }


    //旗下有权限管理的职位///////
    public String toHtmlJob(int language,int dv) throws SQLException
    {
        String cex = getCompanyEx();

        StringBuilder sb = new StringBuilder();
        sb.append("<SELECT NAME=job ><OPTION VALUE=''>-------------------------");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Job WHERE orgid IN(" + cex.substring(1,cex.length() - 1).replaceAll("/",",") + ")");
            while(db.next())
            {
                int node = db.getInt(1);
                Node n = Node.find(node);
                if(n.getTime() != null)
                {
                    sb.append("<OPTION VALUE=").append(node);
                    if(node == dv)
                    {
                        sb.append(" SELECTED ");
                    }
                    sb.append(">").append(n.getSubject(language));
                }
            }
        } finally
        {
            db.close();
        }
        sb.append("</SELECT>");
        return sb.toString();
    }

    //我有权限管理的公司 和 是我创建的公司
    public String getCompanyEx() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("/");
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT node FROM Node WHERE community=").append(DbAdapter.cite(community)).append(" AND type=21 AND ( vcreator=").append(DbAdapter.cite(member));
        if(company.length() > 2)
        {
            sql.append(" OR node IN(").append(company.substring(1,company.length() - 1).replaceAll("/",",")).append(")");
        }
        sql.append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            while(db.next())
            {
                sb.append(db.getInt(1)).append("/");
            }
        } finally
        {
            db.close();
        }
        return sb.toString();
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public String getCompany()
    {
        return company;
    }

    public String getCompanyToHtml(int language) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String arr[] = company.split("/");
        for(int h = 1;h < arr.length;h++)
        {
            sb.append(Node.find(Integer.parseInt(arr[h])).getSubject(language)).append(",");
        }
        return sb.toString();
    }
}
