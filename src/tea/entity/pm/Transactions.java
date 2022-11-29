package tea.entity.pm;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import tea.entity.cluster.DML;

public class Transactions {

	protected static Cache _cache = new Cache(400);
	private int tid;
	//private int language;
	private int member;
	private String community;
	private String varieties;//交易品种
	private String direction;//交易方向
	private Date ttime;//交易时间
	private int quantity;//成交数量
	private float tmoney;//成交金额
	private String content;//阐述理由
	private Date ctime;//交易记录添加时间
	private int hidden;//是否已删除
	private boolean exists;
	
	
	public static Transactions find(int tid) throws SQLException
    {
		Transactions obj = (Transactions) _cache.get(new Integer(tid));
        if(obj == null)
        {
            obj = new Transactions(tid);
            _cache.put(new Integer(tid),obj);
        }
        return obj;
    }

    public Transactions(int tid) throws SQLException
    {
        this.tid = tid;
        load();
    }
    
    
    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,community,varieties,direction,ttime,quantity,tmoney,content,hidden,ctime FROM Transactions WHERE tid=" + tid);
            int i = 1;
            if(db.next())
            {
                //language=db.getInt(i++);
                member=db.getInt(i++);
                community=db.getString(i++);
                varieties=db.getString(i++);
                direction=db.getString(i++);
                ttime=db.getDate(i++);
                quantity=db.getInt(i++);
                tmoney=db.getFloat(i++);
                content=db.getString(i++);
                hidden=db.getInt(i++);
                ctime=db.getDate(i++);
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
    
    public static void set(int member,String community,int tid,String varieties,String direction,Date ttime,int quantity,float tmoney,String content) throws SQLException
    {
        String sql;
        if(tid>0)
            sql = "UPDATE Transactions SET varieties="+DbAdapter.cite(varieties)+",direction="+DbAdapter.cite(direction)+",ttime="+DbAdapter.cite(ttime)+",quantity="+quantity+",tmoney="+tmoney+",content="+DbAdapter.cite(content)+" WHERE tid="+tid;
        else{
        	tid=Seq.get();
            sql = "INSERT INTO Transactions(tid,member,community,varieties,direction,ttime,quantity,tmoney,content,hidden,ctime)VALUES("+tid+", "+member+","+DbAdapter.cite(community)+"," + DbAdapter.cite(varieties) + ", " + DbAdapter.cite(direction) + "," + DbAdapter.cite(ttime) + ", " + quantity + "," + tmoney + "," + DbAdapter.cite(content) +  ",0,"+DbAdapter.cite(new Date())+")";
            
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(tid,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(tid));
    }
    
    public static void delete(int tid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(tid," UPDATE Transactions SET hidden=1  WHERE tid=" + tid);

        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(tid));
    }
    
    public static void show(int tid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(tid," UPDATE Transactions SET hidden=0  WHERE tid=" + tid);

        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(tid));
    }
    
    public static void hidden(int tid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(tid," UPDATE Transactions SET hidden=2  WHERE tid=" + tid);

        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(tid));
    }
    
    
    

	public static Enumeration find(String sql,int pos,int size)throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tid FROM Transactions WHERE 1=1 "  + sql,pos,size);
           
            while(db.next())
            {
                vector.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }
    
    public static int count(String sql)throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        int count=0;
        try
        {
            db.executeQuery("SELECT count(tid) FROM Transactions WHERE 1=1 "  + sql);
           
            if(db.next())
            {
            	count=db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }
    
    public String getVarieties() {
		return varieties;
	}

	public String getDirection() {
		return direction;
	}

	public Date getTtime() {
		return ttime;
	}

	public int getQuantity() {
		return quantity;
	}

	public float getTmoney() {
		return tmoney;
	}

	public String getContent() {
		return content;
	}

	public boolean isHidden() {
		return hidden==1;
	}

	public boolean isExists() {
		return exists;
	}
	public int getMember() {
		return member;
	}
	public int getHidden() {
		return hidden;
	}
}
