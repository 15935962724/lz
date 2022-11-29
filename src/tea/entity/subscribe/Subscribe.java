package tea.entity.subscribe;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class Subscribe extends Entity
{ 
	private int subid;
	private String subject; //套餐名称
	private BigDecimal marketprice; //人民币价格
	private BigDecimal promotionsprice; //美元价格
	
	
	
	private String createmember;//创建人
	private Date createtime;//创建时间
	
	private String publishmember;//公布人
	private Date publishtime;//公布时间
	
	private int publish;//公布状态  0 公布 1 未公布 3 已撤销
	
	private String community;//
	private int node;
	private String remarks;//备注说明
	private boolean exists;
	private int membertype;//会员类型
	

	public final static String [] PUBLISH_TYPE ={"未公布","已公布"};//,"已撤销"
	

	public Subscribe(int subid)throws SQLException
	{
		this.subid = subid;
		load();
	}
	public static Subscribe find(int subid) throws SQLException
	{
		return new Subscribe(subid);
	}

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subject,marketprice,promotionsprice,node,community,createmember, createtime, publishmember, publishtime, publish,remarks,membertype FROM Subscribe WHERE subid= " + subid);
            if(db.next())
            {
                subject = db.getString(1);
                marketprice = db.getBigDecimal(2,2);
                promotionsprice = db.getBigDecimal(3,2);
                node = db.getInt(4);
                community = db.getString(5);
                createmember=db.getString(6);
                createtime=db.getDate(7);
                publishmember=db.getString(8);
                publishtime=db.getDate(9);
                publish=db.getInt(10);
                remarks=db.getString(11);
                membertype=db.getInt(12);
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

    public static int create(String subject,BigDecimal marketprice,BigDecimal promotionsprice,int node,String community,
    		String createmember,Date createtime,String publishmember,Date publishtime,int publish,String remarks,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO Subscribe (subject,marketprice,promotionsprice,node,community,createmember, createtime, publishmember, publishtime, publish,remarks,membertype) " +
                             " VALUES (" + db.cite(subject) + "," + marketprice + "," + promotionsprice + "," + node + "," + db.cite(community) + "," +
                             		"  "+db.cite(createmember)+", "+db.cite(createtime)+", "+db.cite(publishmember)+", "+db.cite(publishtime)+", "+publish+","+db.cite(remarks)+","+membertype+" )");
            i = db.getInt("SELECT MAX(subid) FROM Subscribe");
        } finally
        {
            db.close();
        }
        return i;
    }

    public void set(String subject,BigDecimal marketprice,BigDecimal promotionsprice,int node,String community,
    		String createmember,Date createtime,String publishmember,Date publishtime,int publish,String remarks,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Subscribe SET subject =" + db.cite(subject) + ",marketprice=" + marketprice + ",promotionsprice=" + promotionsprice + " ,node =" + node + ",community =" + db.cite(community) + "," +
            		" createmember="+db.cite(createmember)+",createtime="+db.cite(createtime)+",publishmember="+db.cite(publishmember)+",publishtime="+db.cite(publishtime)+"," +
            				" publish="+publish+",remarks="+db.cite(remarks)+",membertype="+membertype+" WHERE subid=" + subid);
        } finally
        {
            db.close();
        }
    }

	public static Enumeration find(String community,String sql,int pos,int size)
   {
	   Vector vector = new Vector();
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT subid FROM Subscribe WHERE community= " + db.cite(community) + sql,pos,size);
		   while(db.next())
		   {
			   vector.add(new Integer(db.getInt(1)));
		   }
	   } catch(Exception exception3)
	   {
		   System.out.print(exception3);
	   } finally
	   {
		   db.close();
	   }
	   return vector.elements();
   }
	

   public void delete() throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("DELETE FROM  Subscribe WHERE subid = " + subid);

       } finally
       {
           db.close();
       }
   }
   //修改套餐是否公布
   public void setPublish(int publish)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try 
	   {
		  db.executeUpdate("UPDATE Subscribe SET publish = "+publish+" WHERE subid =  "+subid);
		} catch (Exception e) {
			// TODO: handle exception
		}finally
		{
			db.close();
		}
   }
   public void setMemberTime(String member,Date times)throws SQLException
   {
		//private String publishmember;//公布人
		//private Date publishtime;//公布时间 
	   DbAdapter db = new DbAdapter();
	   try 
	   {
		  db.executeUpdate("UPDATE Subscribe SET publishmember = "+db.cite(publishmember)+",publishtime="+db.cite(times)+" WHERE subid =  "+subid);
		} catch (Exception e) {
			// TODO: handle exception
		}finally
		{
			db.close();
		}
   } 

   public static int count(String community,String sql) throws SQLException
   {
       int count = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT COUNT(subid) FROM Subscribe  WHERE community=" + db.cite(community) + sql);
           if(db.next())
           {
               count = db.getInt(1);
           }
       } finally
       {
           db.close();
       }
       return count;
   }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getMarketprice()
    {
        return marketprice;
    }

    public int getNode()
    {
        return node;
    }

    public BigDecimal getPromotionsprice()
    {
        return promotionsprice;
    }

    public String getSubject()
    {
        return subject;
    }
    public String getCreatemember() {
		return createmember;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public String getCreatetimeToString()
	{
		if(createtime ==null)
		{
			return "";
		}
		return sdf2.format(createtime);
	}
	public String getPublishmember() {
		return publishmember;
	}
	public Date getPublishtime() {
		return publishtime;
	}
	public String getPublishtimeToString()
	{
		if(publishtime ==null)
		{
			return "";
		}
		return sdf2.format(publishtime);
	}
	public int getPublish() {
		return publish;
	}
	public String getRemarks()
	{
		return remarks;
	} 
	public int getMembertype()
	{
		return membertype;
	}
}
