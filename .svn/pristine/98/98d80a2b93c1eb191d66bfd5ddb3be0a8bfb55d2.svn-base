package tea.entity.cio;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class CioPoll extends Entity
{
    public static final String CHOOSE_TYPE[] =
            {"协同办公","视频会议","ERP系统","预算管理","集团财务管理","资金集中管理","人力资源管理","决策支持系统","审计内控管理","知识管理"};
    public static final String SCORE_TYPE[] =
            {"好","一般"};
    private static Cache _cache = new Cache(100);
    private int ciocompany;
    private String community;
    private String choose[] = new String[10];
    private int score[] = new int[10]; //0:好,1:一般
    private boolean exists;
    public CioPoll(int ciocompany) throws SQLException
    {
        this.ciocompany = ciocompany;
        load();
    }

    public CioPoll(int ciocompany,String community,String choose[],int score[]) throws SQLException
    {
        this.ciocompany = ciocompany;
        this.community = community;
        this.choose = choose;
        this.score = score;
        this.exists = true;
    }

    public static CioPoll find(int ciopoll) throws SQLException
    {
        CioPoll obj = (CioPoll) _cache.get(ciopoll);
        if(obj == null)
        {
            obj = new CioPoll(ciopoll);
            _cache.put(ciopoll,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,choose0,choose1,choose2,choose3,choose4,choose5,choose6,choose7,choose8,choose9,score0,score1,score2,score3,score4,score5,score6,score7,score8,score9 FROM CioPoll WHERE ciocompany=" + ciocompany);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                for(int i = 0;i < choose.length;i++)
                {
                    choose[i] = db.getString(j++);
                }
                for(int i = 0;i < score.length;i++)
                {
                    score[i] = db.getInt(j++);
                }
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

    public static void create(int ciocompany,String community,String choose[],String score[]) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO CioPoll(ciocompany,community,choose0,choose1,choose2,choose3,choose4,choose5,choose6,choose7,choose8,choose9,score0,score1,score2,score3,score4,score5,score6,score7,score8,score9)VALUES(");
        sql.append(ciocompany).append(",").append(DbAdapter.cite(community));
        for(int i = 0;i < choose.length;i++)
        {
            sql.append(",").append(DbAdapter.cite(choose[i]));
        }
        for(int i = 0;i < score.length;i++)
        {
            sql.append(",").append(score[i]);
        }
        sql.append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        _cache.remove(ciocompany);
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM CioPoll WHERE ciocompany IN ( SELECT ciocompany FROM CioCompany WHERE community=" + DbAdapter.cite(community) + ")" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany,choose0,choose1,choose2,choose3,choose4,choose5,choose6,choose7,choose8,choose9,score0,score1,score2,score3,score4,score5,score6,score7,score8,score9 FROM CioPoll WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int ciocompany = db.getInt(j++);
                String choose[] = new String[10];
                for(int x = 0;x < choose.length;x++)
                {
                    choose[x] = db.getString(j++);
                }
                int score[] = new int[10];
                for(int x = 0;x < score.length;x++)
                {
                    score[x] = db.getInt(j++);
                }
                CioPoll obj = new CioPoll(ciocompany,community,choose,score);
                _cache.put(ciocompany,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find(String community,int choose,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT choose" + choose + ",COUNT(choose" + choose + ") FROM CioPoll WHERE community=" + DbAdapter.cite(community) + " GROUP BY choose" + choose + " ORDER BY COUNT(choose" + choose + ") DESC");
            while(db.next())
            {
                String str = db.getString(1);
                int cc = db.getInt(2);
                int cs[] = new int[2];
                db2.executeQuery("SELECT score" + choose + ",COUNT(score" + choose + ") FROM CioPoll WHERE community=" + DbAdapter.cite(community) + " AND choose" + choose + "=" + DbAdapter.cite(str) + " GROUP BY score" + choose);
                while(db2.next())
                {
                    int s = db2.getInt(1);
                    int c = db2.getInt(2);
                    cs[s] = c;
                }
                v.add(new Object[]
                      {
                      str,cc,cs[0],cs[1]
                });
            }
        } finally
        {
            db.close();
            db2.close();
        }
        return v.elements();
    }

    public void set(String choose[],String score[]) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE CioPoll SET community=").append(DbAdapter.cite(community));
        for(int i = 0;i < choose.length;i++)
        {
            sql.append(",choose").append(i).append("=").append(DbAdapter.cite(choose[i]));
        }
        for(int i = 0;i < score.length;i++)
        {
            sql.append(",score").append(i).append("=").append(score[i]);
        }
        sql.append(" WHERE ciocompany=").append(ciocompany);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
//        this.choose = choose;
//        this.score = score;
        _cache.remove(ciocompany);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CioPoll WHERE ciocompany=" + ciocompany);
        } finally
        {
            db.close();
        }
        _cache.remove(ciocompany);
    }

    public boolean isExists()
    {
        return exists;
    }

    public int[] getScore()
    {
        return score;
    }

    public int getCioCompany()
    {
        return ciocompany;
    }

    public String[] getChoose()
    {
        return choose;
    }


}
