package tea.entity.node;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.ui.TeaSession;


public class PerformStreak extends Entity
{
    private int psid; //主键id
    private int node; //演出的id号
    private String psname; //场次名称
    private int venues; //场馆ID
    private int chevalue; //价格同上以场次
    private Date pftime; //演出时间
    private Date stardrawtime; //开始出票时间
    private Date enddrawtime; //结束出票时间
    private Date endbouncetime; //结束退票时间
    private Date startonlinetime; //网上开始订票
    private Date endonlinetime; //网上订票结束
    private String community; //
    private String member; //
    private Date times; //
    private boolean exist; //
   public  java.text.SimpleDateFormat  sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");

    public PerformStreak(int psid) throws SQLException
    {
        this.psid = psid;
        load();
    }

    public static PerformStreak find(int psid) throws SQLException
    {
        return new PerformStreak(psid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,psname,venues,chevalue,pftime,stardrawtime,enddrawtime,endbouncetime,startonlinetime,endonlinetime,community,member,times FROM PerformStreak  WHERE psid = " + psid);
            if(db.next())
            {
                node = db.getInt(1);
                psname = db.getString(2);
                venues = db.getInt(3);
                chevalue = db.getInt(4);
                pftime = db.getDate(5);
                stardrawtime = db.getDate(6);
                enddrawtime = db.getDate(7);
                endbouncetime = db.getDate(8);
                startonlinetime = db.getDate(9);
                endonlinetime = db.getDate(10);
                community = db.getString(11);
                member = db.getString(12);
                times = db.getDate(13);
                exist = true;
            } else
            {
                exist = false;
            }
        } finally
        {
            db.close();
        }
    }
	public static int create(int  node,String psname,int venues,int chevalue,Date pftime,Date stardrawtime,Date enddrawtime,Date endbouncetime,Date startonlinetime,Date endonlinetime,String community,String member) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   Date times = new Date();
	   int i = 0;
	   try
	   {
		   db.executeUpdate("INSERT INTO PerformStreak(node,psname,venues,chevalue,pftime,stardrawtime,enddrawtime,endbouncetime,startonlinetime,endonlinetime,community,member,times) VALUES("+node+","+db.cite(psname)+","
				   +" "+venues+","+chevalue+","+db.cite(pftime)+","+db.cite(stardrawtime)+","+db.cite(enddrawtime)+","+db.cite(endbouncetime)+","+db.cite(startonlinetime)+","+db.cite(endonlinetime)+","+db.cite(community)+","
				   + db.cite(member)+","+db.cite(times)+" )");
		   i = db.getInt("SELECT MAX(psid) FROM PerformStreak");

	   } finally
	   {
		   db.close();
	   }
	   return i;

   }

   public void set(int  node,String psname,int venues,int chevalue,Date pftime,Date stardrawtime,Date enddrawtime,Date endbouncetime,Date startonlinetime,Date endonlinetime,String member) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeUpdate("UPDATE PerformStreak SET node="+node+",psname="+db.cite(psname)+",venues="+venues+",chevalue="+chevalue+",pftime="+db.cite(pftime)+",stardrawtime="+db.cite(stardrawtime)+",enddrawtime="+db.cite(enddrawtime)+","
							+" endbouncetime="+db.cite(endbouncetime)+",startonlinetime="+db.cite(startonlinetime)+",endonlinetime="+db.cite(endonlinetime)+",member="+db.cite(member)+" WHERE psid="+psid);
	   } finally
	   {
		   db.close();
	   }
       this.node = node;
       this.psname = psname;
       this.venues = venues;
       this.chevalue = chevalue;
       this.pftime = pftime;
       this.stardrawtime = stardrawtime;
       this.enddrawtime = enddrawtime;
       this.endbouncetime = endbouncetime;
       this.startonlinetime = startonlinetime;
       this.endonlinetime = endonlinetime;
       this.member = member;
   }

   public static Enumeration find(String community,String sql,int pos,int size)
   {
       Vector vector = new Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT psid FROM PerformStreak WHERE community= " + db.cite(community) + sql ,pos,size);
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
           db.executeUpdate("DELETE FROM  PerformStreak WHERE psid = " + psid);
       } finally
       {
           db.close();
       }
   }
   //删除 演出中的场次
   public static void delete(int node) throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   try{
		   db.executeUpdate("DELETE FROM PerformStreak WHERE node = "+node);
	   }finally{
		   db.close();
	   }
   }
   //通过日期获取演出信息
   public static String getPerformS(String pftime , TeaSession teasession)throws SQLException
   {
	   StringBuffer spBuffer = new StringBuffer();
	   DbAdapter db = new DbAdapter();
	   try{

		   java.util.Enumeration eps = PerformStreak.find(teasession._strCommunity," AND pftime  > '"+pftime+" 00:00' AND pftime <'"+pftime+" 23:59' ",0,Integer.MAX_VALUE);
     	 	while(eps.hasMoreElements())
     	 	{

     	 		int psid = ((Integer)eps.nextElement()).intValue();
     	 		PerformStreak psobj = PerformStreak.find(psid);

     	 		Node nobj = Node.find(psobj.getNode());//演出名称
     	 		spBuffer.append("<a href=/servlet/Node?node="+psobj.getNode()+"&em=0&language="+teasession._nLanguage+"&psid="+psid+">");
     	 		spBuffer.append(nobj.getSubject(teasession._nLanguage));
     	 		spBuffer.append("</a>");
     	 		spBuffer.append("<br>");
     	 		Node nobj2 = Node.find(psobj.getVenues());//演出场馆
     	 		spBuffer.append(nobj2.getSubject(teasession._nLanguage));
     	 		spBuffer.append("<br>");
     	 	}
	   }finally
	   {
		   db.close();
	   }

	   return spBuffer.toString();
   }
   public static int count(String community,String sql) throws SQLException
   {
       int count = 0;
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT COUNT(psid) FROM PerformStreak  WHERE community=" + db.cite(community) + sql);
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
   //日期加减
   public static String getYear(Date date,int day,String operator) throws SQLException
   {

	       SimpleDateFormat f   = new SimpleDateFormat ("yyyy-MM-dd");
           Calendar c=Calendar.getInstance();
           c.setTime(date);
           if("-".equals(operator))
           {
             c.add(c.DAY_OF_MONTH, -day);
           }
           if("+".equals(operator))
           {
        	   c.add(c.DAY_OF_MONTH, +day);
           }

	   return f.format(c.getTime());

   }
 //判断当前时间是否在时间date2之前
   public static boolean isDateBefore(String date2)
   {

	   try{

	    Date date1 = new Date();

	    SimpleDateFormat df =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 

	    return date1.before(df.parse(date2)); 

	   }catch(Exception e){

	    System.out.print("[SYS] " + e.getMessage());
	   }

	    return false;

	}




   /*
   //获取演出场次的时间
   public static String getPstime(int node)throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   StringBuffer sp = new StringBuffer("/");
	   try
	   {
		   db.executeQuery("SELECT pftime FROM PerformStreak WHERE node = "+node);
		   while(db.next())
		   {

			   sp.append(Entity.sdf2.format(db.getDate(1))+"/");
		   }
	   }finally
	   {
		   db.close();
	   }
	   return sp.toString();
   }
*/
   //转换 把时间添加成年月日 时分秒汉字
   public static String sdf(Date times)
   {
	   StringBuffer sp = new StringBuffer();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");//-MM-dd HH:mm:ss
    	SimpleDateFormat sdf2 = new SimpleDateFormat("MM");//-MM-dd HH:mm:ss
    	SimpleDateFormat sdf3 = new SimpleDateFormat("dd");//-MM-dd HH:mm:ss
    	SimpleDateFormat sdf4 = new SimpleDateFormat("HH");//-MM-dd HH:mm:ss
    	SimpleDateFormat sdf5 = new SimpleDateFormat("mm");//-MM-dd HH:mm:ss
    	
    	sp.append(sdf1.format(times)).append("年");
    	sp.append(sdf2.format(times)).append("月");
    	sp.append(sdf3.format(times)).append("日");
    	sp.append(sdf4.format(times)).append("时");
    	sp.append(sdf5.format(times)).append("分");
    
	   return sp.toString();
	    
   }  
   
   
   //判断场次网上订票 开始时间 和 网上订票 结束时间判断
   public boolean isTiems()throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   boolean f = false;
	   String timesql = " and startonlinetime <= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date()))+" and endonlinetime >= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date()));
	   try{
		   db.executeQuery(" SELECT psid FROM PerformStreak WHERE psid="+psid+timesql);
		 
		   if(db.next())
		   {
			   f = true;
		   }
	   }finally
	   {
		   db.close();
	   }
	   return f;
   }
   //判断场次出票 开始时间 和结束时间
   public boolean isAdminTiems()throws SQLException
   {
	   DbAdapter db = new DbAdapter();
	   boolean f = false;
	   String timesql = " and stardrawtime <= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date()))+" and enddrawtime >= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date()));
	   try{ 
		   db.executeQuery(" SELECT psid FROM PerformStreak WHERE psid="+psid+timesql);
		   if(db.next())
		   {
			   f = true;
		   }
	   }finally
	   {
		   db.close();
	   }
	   return f;
   }
   //价格模板添加方法  
   public static void setTemplet(int psid,int chevalue,String community)throws SQLException
   {
	   //1、先添加价格图片的
	   //先删除以前的id
	   SeatPic.delete(psid,2);
	   //2、在添加图片
	   java.util.Enumeration  en = SeatPic.find(community, " and node ="+chevalue+" and type=2  ", 0,Integer.MAX_VALUE);
	   while(en.hasMoreElements())
	   {
		   int spid = ((Integer)en.nextElement()).intValue();
		   SeatPic spobj = SeatPic.find(spid);
		   SeatPic.create(psid,spobj.getPicname(),spobj.getPicpath(), community,spobj.getMember(),2);//给新的场次添加图片
		   //spobj.delete();
	   }
	   
	   //3、 先删除分区价格表中的数据
	   PriceSubarea.delete(psid);
	   //4、在添加分区价格表
	   java.util.Enumeration  en2 = PriceSubarea.find(community, " and psid = "+chevalue, 0, Integer.MAX_VALUE);
	   while(en2.hasMoreElements())
	   {
		   int psubid = ((Integer)en2.nextElement()).intValue();
		   PriceSubarea psubobj = PriceSubarea.find(psubid);
		   PriceSubarea.create(psid,psubobj.getSubareaname(),psubobj.getPrice(),null,psubobj.getPicturepath(),psubobj.getMember(),community);
	   }
	   
	   //5先删除价格分区类型表
	   PriceDistrict.delete(psid);
	   //6在添加
	   java.util.Enumeration  en3 =PriceDistrict.find(community, " and psid = "+chevalue, 0, Integer.MAX_VALUE);
	   while(en3.hasMoreElements())
	   {
		   int pdid =((Integer)en3.nextElement()).intValue();
		   PriceDistrict pdobj = PriceDistrict.find(pdid,chevalue);
		   PriceDistrict.create(pdid,psid,pdobj.getPricesubareaid(),pdobj.getMember(),community);
	   }
   }
    public int getChevalue()
    {
        return chevalue;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getEndbouncetime()
    {
        return endbouncetime;
    }
	public String getEndbouncetimeToString()
	{
		if(endbouncetime == null )
			return "";
		return sdf3.format(endbouncetime);
	}

    public Date getEnddrawtime()
    {
        return enddrawtime;
    }

    public String getEnddrawtimeToString()
    {
        if(enddrawtime == null)
            return "";
        return sdf3.format(enddrawtime);
    }


    public Date getEndonlinetime()
    {
        return endonlinetime;
    }

    public String getEndonlinetimeToString()
    {
        if(endonlinetime == null)
            return "";
        return sdf3.format(endonlinetime);
    }


    public boolean isExist()
    {
        return exist;
    }

    public String getMember()
    {
        return member;
    }

    public int getNode()
    {
        return node;
    }

    public Date getPftime()
    {
        return pftime;
    }

    public String getPftimeToString()
    {
        if(pftime == null)
            return "";
        return sdf3.format(pftime);
    }
    

    public String getPsname()
    {
        return psname;
    }

    public Date getStardrawtime()
    {
        return stardrawtime;
    }

    public String getStardrawtimeToString()
    {
        if(stardrawtime == null)
            return "";
        return sdf3.format(stardrawtime);
    }


    public Date getStartonlinetime()
    {
        return startonlinetime;
    }

    public String getStartonlinetimeToString()
    {
        if(startonlinetime == null)
            return "";
        return sdf3.format(startonlinetime);
    }


    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
            return "";
        return sdf.format(times);
    }
    public int getVenues()
    {
        return venues;
    }
}
