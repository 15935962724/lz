package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.map.*;
import tea.entity.qcjs.QcMember;
import tea.html.Button;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Image;
import tea.ui.TeaSession;
import java.sql.SQLException;

public class GolfSite extends Entity
{
	
	 private int gsid;
	 private String gsname;//场地名称
	 private String seq;//场地序号
	 private int node;//球场id
	 private Date times;//添加时间
	 private String community;
	 private boolean exists;
	//标准杆
	 private int standard1;
	 private int standard2;
	 private int standard3;
	 private int standard4;
	 private int standard5;
	 private int standard6;
	 private int standard7;
	 private int standard8;
	 private int standard9;
	 public int[] standard = new int[18]; //标准杆
	 
	 //码数
	 private int yardage1; 
	 private int yardage2;
	 private int yardage3;
	 private int yardage4;
	 private int yardage5;
	 private int yardage6;
	 private int yardage7;
	 private int yardage8;
	 private int yardage9;
	 
	 //球洞图
	 private String hole1;
	 private String hole2;
	 private String hole3;
	 private String hole4;
	 private String hole5;
	 private String hole6;
	 private String hole7;
	 private String hole8;
	 private String hole9;
	 
	 //果岭经纬度
	 private String latlong1;
	 private String latlong2;
	 private String latlong3;
	 private String latlong4;
	 private String latlong5;
	 private String latlong6;
	 private String latlong7;
	 private String latlong8;
	 private String latlong9;
	 
	 private float difficulty = 0f; // 球场难度系数
	 private float gradient = 0f; // 球场坡度系数
	 
	 public float[] difficultys = new float[5];
	 public float[] gradients = new float[5]; //同上，5个发球台的!
	 
	 
	 public static GolfSite find(int gsid) throws SQLException
		{
			return new GolfSite(gsid);
		}
		
		public GolfSite(int gsid) throws SQLException
		{
			this.gsid = gsid;
			load();
		}
	  
		private void load() throws SQLException
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT gsname,node,times,community,standard1,standard2,standard3,standard4,standard5,standard6,standard7,standard8,standard9," +
						"yardage1,yardage2,yardage3,yardage4,yardage5,yardage6,yardage7,yardage8,yardage9,hole1,hole2,hole3,hole4,hole5,hole6,hole7,hole8,hole9,seq," +
						"difficulty1,difficulty2,difficulty3,difficulty4,difficulty5,gradient1,gradient2,gradient3,gradient4,gradient5," +
						" latlong1,latlong2,latlong3,latlong4,latlong5,latlong6,latlong7,latlong8,latlong9 FROM GolfSite  WHERE gsid=" + gsid);
				if(db.next())
				{
					  int x = 0;
					gsname=db.getString(1);
					node=db.getInt(2);
					times=db.getDate(3);
					community=db.getString(4);
					standard1=db.getInt(5);
					standard2=db.getInt(6);
					standard3=db.getInt(7);
					standard4=db.getInt(8);
					standard5=db.getInt(9);
					standard6=db.getInt(10);
					standard7=db.getInt(11);
					standard8=db.getInt(12);
					standard9=db.getInt(13);
					yardage1=db.getInt(14);
					yardage2=db.getInt(15);
					yardage3=db.getInt(16);
					yardage4=db.getInt(17);
					yardage5=db.getInt(18);
					yardage6=db.getInt(19);
					yardage7=db.getInt(20);
					yardage8=db.getInt(21);
					yardage9=db.getInt(22);
					hole1=db.getString(23);
					hole2=db.getString(24);
					hole3=db.getString(25);
					hole4=db.getString(26);
					hole5=db.getString(27);
					hole6=db.getString(28);
					hole7=db.getString(29);
					hole8=db.getString(30);
					hole9=db.getString(31);
					seq=db.getString(32);
					
				
				
					 x = 33;
	             
	                for(int index = 0;index < 5;index++)
	                {
	                    difficultys[index] = db.getFloat(x++);
	                }
	                for(int index = 0;index < 5;index++)
	                {
	                    gradients[index] = db.getFloat(x++);
	                }
	           
	            	latlong1=db.getString(x++);
					latlong2=db.getString(x++);
					latlong3=db.getString(x++);
					latlong4=db.getString(x++);
					latlong5=db.getString(x++);
					latlong6=db.getString(x++);
					latlong7=db.getString(x++);
					latlong8=db.getString(x++);
					latlong9=db.getString(x++);
	                 
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
	      
		
	
		public static void create(String gsname,int node,Date times,String community,int standard1,int standard2,int standard3,int standard4,int standard5,int standard6,int standard7,int standard8,int standard9,
				int yardage1,int yardage2,int yardage3,int yardage4,int yardage5,int yardage6,int yardage7,int yardage8,int yardage9,String hole1,String hole2,String hole3,String hole4,String hole5,String hole6,
				String hole7,String hole8,String hole9,float difficulty,float gradient,String seq,String latlong1,String latlong2,String latlong3,String latlong4,String latlong5,
				String latlong6,String latlong7,String latlong8,String latlong9) throws SQLException
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("INSERT INTO GolfSite(gsname,node,times,community,standard1,standard2,standard3,standard4,standard5,standard6,standard7,standard8,standard9," +
						" yardage1,yardage2,yardage3,yardage4,yardage5,yardage6,yardage7,yardage8,yardage9,hole1,hole2,hole3,hole4,hole5,hole6,hole7,hole8,hole9," +
						" difficulty1,difficulty2,difficulty3,difficulty4,difficulty5,gradient1,gradient2,gradient3,gradient4,gradient5,seq,latlong1,latlong2,latlong3,latlong4,latlong5," +
						" latlong6,latlong7,latlong8,latlong9)VALUES("+db.cite(gsname)+","+node+"," +
						" "+db.cite(times)+","+db.cite(community)+","+standard1+","+standard2+","+standard3+","+standard4+","+standard5+","+standard6+","+standard7+","+standard8+","+standard9+"," +
						" "+yardage1+","+yardage2+","+yardage3+","+yardage4+","+yardage5+","+yardage6+","+yardage7+","+yardage8+","+yardage9+"," +
						" "+db.cite(hole1)+","+db.cite(hole2)+","+db.cite(hole3)+","+db.cite(hole4)+","+db.cite(hole5)+","+db.cite(hole6)+","+db.cite(hole7)+","+db.cite(hole8)+","+db.cite(hole9)+"," +
						" "+difficulty+","+difficulty+","+difficulty+","+difficulty+","+difficulty+","+gradient+","+gradient+","+gradient+","+gradient+","+gradient+","+db.cite(seq)+"," +
						" "+db.cite(latlong1)+","+db.cite(latlong2)+","+db.cite(latlong3)+","+db.cite(latlong4)+","+db.cite(latlong5)+","+db.cite(latlong6)+","+db.cite(latlong7)+"," +
						" "+db.cite(latlong8)+","+db.cite(latlong9)+" )");
			
			} finally
			{
				db.close();
			}
		}
		
		public void set(String gsname,int standard1,int standard2,int standard3,int standard4,int standard5,int standard6,int standard7,int standard8,int standard9,
				int yardage1,int yardage2,int yardage3,int yardage4,int yardage5,int yardage6,int yardage7,int yardage8,int yardage9,
				String hole1,String hole2,String hole3,String hole4,String hole5,String hole6,String hole7,String hole8,String hole9,String seq,
			    String latlong1,String latlong2,String latlong3,String latlong4,String latlong5,String latlong6,String latlong7,String latlong8,String latlong9) throws SQLException
		{
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE GolfSite SET");
			sb.append(" gsname=").append(DbAdapter.cite(gsname));
			sb.append(",standard1=").append(standard1);
			sb.append(",standard2=").append(standard2);
			sb.append(",standard3=").append(standard3);
			sb.append(",standard4=").append(standard4);
			sb.append(",standard5=").append(standard5);
			sb.append(",standard6=").append(standard6);
			sb.append(",standard7=").append(standard7);
			sb.append(",standard8=").append(standard8);
			sb.append(",standard9=").append(standard9);
			
			sb.append(",yardage1=").append(yardage1);
			sb.append(",yardage2=").append(yardage2);
			sb.append(",yardage3=").append(yardage3);
			sb.append(",yardage4=").append(yardage4);
			sb.append(",yardage5=").append(yardage5);
			sb.append(",yardage6=").append(yardage6);
			sb.append(",yardage7=").append(yardage7);
			sb.append(",yardage8=").append(yardage8);
			sb.append(",yardage9=").append(yardage9);
			
			sb.append(",hole1=").append(DbAdapter.cite(hole1));
			sb.append(",hole2=").append(DbAdapter.cite(hole2));
			sb.append(",hole3=").append(DbAdapter.cite(hole3));
			sb.append(",hole4=").append(DbAdapter.cite(hole4));
			sb.append(",hole5=").append(DbAdapter.cite(hole5));
			sb.append(",hole6=").append(DbAdapter.cite(hole6));
			sb.append(",hole7=").append(DbAdapter.cite(hole7));
			sb.append(",hole8=").append(DbAdapter.cite(hole8));
			sb.append(",hole9=").append(DbAdapter.cite(hole9));
			sb.append(",seq=").append(DbAdapter.cite(seq));
			
			sb.append(",latlong1=").append(DbAdapter.cite(latlong1));
			sb.append(",latlong2=").append(DbAdapter.cite(latlong2));
			sb.append(",latlong3=").append(DbAdapter.cite(latlong3));
			sb.append(",latlong4=").append(DbAdapter.cite(latlong4));
			sb.append(",latlong5=").append(DbAdapter.cite(latlong5));
			sb.append(",latlong6=").append(DbAdapter.cite(latlong6));
			sb.append(",latlong7=").append(DbAdapter.cite(latlong7));
			sb.append(",latlong8=").append(DbAdapter.cite(latlong8));
			sb.append(",latlong9=").append(DbAdapter.cite(latlong9));
			
			
		
			sb.append(" WHERE gsid=").append( gsid);
			DbAdapter db = new DbAdapter();
			try
			{
				 db.executeUpdate(sb.toString());
			} finally
			{
				db.close();
			}
		}
	    public void setTee(float[] difficultys,float[] gradients) throws SQLException
	    {
	        StringBuilder sql = new StringBuilder();
	        sql.append("UPDATE GolfSite SET ");
	        for(int i = 0;i < 5;i++)
	        {
	            if(i > 0)
	            {
	                sql.append(",");
	            }
	            sql.append("difficulty").append(i + 1).append("=").append(difficultys[i]);
	            sql.append(",gradient").append(i + 1).append("=").append(gradients[i]);
	        }
	        sql.append(" WHERE gsid=" + this.gsid);
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(sql.toString());
	        } finally
	        {
	            db.close();
	        }
	    
	    }
		
		public void delete()throws SQLException
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate(" DELETE FROM GolfSite   WHERE gsid=" + gsid);
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
		            db.executeQuery("SELECT gsid FROM GolfSite WHERE community= " + db.cite(community) + sql,pos,size);
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
			
		    public static int count(String community,String sql) throws SQLException
		    {
		        int count = 0;
		        DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT COUNT(gsid) FROM GolfSite  WHERE community=" + db.cite(community) + sql);
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
		    //通过球会和场地序号获取
		    public static int getGSid(int node,String fieldid)throws SQLException
		    {
		    	int id = 0;
		    	DbAdapter db = new DbAdapter();
		        try
		        {
		            db.executeQuery("SELECT gsid FROM GolfSite  WHERE node=" +node+" AND seq="+db.cite(fieldid)+" ");
		            if(db.next())
		            {
		                id = db.getInt(1);
		            }
		        } finally
		        {
		            db.close();
		        }
		        return id; 
		    }

			public String getGsname()
			{
				return gsname;
			}

			public int getNode()
			{
				return node;
			}

			public Date getTimes()
			{
				return times;
			}

			public String getCommunity()
			{
				return community;
			}

			public boolean isExists()
			{
				return exists;
			}

			public int getStandard1()
			{
				return standard1;
			}

			public int getStandard2()
			{
				return standard2;
			}

			public int getStandard3()
			{
				return standard3;
			}

			public int getStandard4()
			{
				return standard4;
			}

			public int getStandard5()
			{
				return standard5;
			}

			public int getStandard6()
			{
				return standard6;
			}

			public int getStandard7()
			{
				return standard7;
			}

			public int getStandard8()
			{
				return standard8;
			}

			public int getStandard9()
			{
				return standard9;
			}
			public int getStandard(int i)
			{
				int d = 0;
				if(i==1)
				{
					d = standard1;
				}else if(i==2)
				{
					d = standard2;
				}else if(i==3)
				{
					d = standard3;
				}else if(i==4)
				{
					d = standard4;
				}else if(i==5)
				{
					d = standard5;
				}else if(i==6)
				{
					d = standard6;
				}else if(i==7)
				{
					d = standard7;
				}else if(i==8)
				{
					d = standard8;
				}else if(i==9)
				{
					d = standard9;
				}
				return d;
				
			}
			public int getYardage1()
			{
				return yardage1;
			}

			public int getYardage2()
			{
				return yardage2;
			}

			public int getYardage3()
			{
				return yardage3;
			}

			public int getYardage4()
			{
				return yardage4;
			}

			public int getYardage5()
			{
				return yardage5;
			}

			public int getYardage6()
			{
				return yardage6;
			}

			public int getYardage7()
			{
				return yardage7;
			}

			public int getYardage8()
			{
				return yardage8;
			}

			public int getYardage9()
			{
				return yardage9;
			}

			public int getYardage(int i)
			{
				int d = 0;
				if(i==1)
				{
					d = yardage1;
				}else if(i==2)
				{
					d = yardage2;
				}else if(i==3)
				{
					d = yardage3;
				}else if(i==4)
				{
					d = yardage4;
				}else if(i==5)
				{
					d = yardage5;
				}else if(i==6)
				{
					d = yardage6;
				}else if(i==7)
				{
					d = yardage7;
				}else if(i==8)
				{
					d = yardage8;
				}else if(i==9)
				{
					d = yardage9;
				}
				return d;
				
			}
			
			public String getHole1()
			{
				return hole1;
			}

			public String getHole2()
			{
				return hole2;
			}

			public String getHole3()
			{
				return hole3;
			}

			public String getHole4()
			{
				return hole4;
			}

			public String getHole5()
			{
				return hole5;
			}

			public String getHole6()
			{
				return hole6;
			}

			public String getHole7()
			{
				return hole7;
			}

			public String getHole8()
			{
				return hole8;
			}

			public String getHole9()
			{
				return hole9;
			}
			public String getHole(int i)
			{
				String d = null;
				if(i==1)
				{
					d = hole1;
				}else if(i==2)
				{
					d = hole2;
				}else if(i==3)
				{
					d = hole3;
				}else if(i==4)
				{
					d = hole4;
				}else if(i==5)
				{
					d = hole5;
				}else if(i==6)
				{
					d = hole6;
				}else if(i==7)
				{
					d = hole7;
				}else if(i==8)
				{
					d = hole8;
				}else if(i==9)
				{
					d = hole9;
				}
				return d;
				
			}
			
			public String getSeq()
			{
				return seq;
			}
			
			public String getLatlong1()
			{
				return latlong1;
			}
			public String getLatlong2()
			{
				return latlong2;
			}
			public String getLatlong3()
			{
				return latlong3;
			}
			public String getLatlong4()
			{
				return latlong4;
			}
			public String getLatlong5()
			{
				return latlong5;
			}
			public String getLatlong6()
			{
				return latlong6;
			}
			public String getLatlong7()
			{
				return latlong7;
			}
			public String getLatlong8()
			{
				return latlong8;
			}
			public String getLatlong9()
			{
				return latlong9;
			}
			
			public String getLatlong(int i)
			{
				String d = "";
				if(i==1)
				{
					d = latlong1;
				}else if(i==2)
				{
					d = latlong2;
				}else if(i==3)
				{
					d = latlong3;
				}else if(i==4)
				{
					d = latlong4;
				}else if(i==5)
				{
					d = latlong5;
				}else if(i==6)
				{
					d = latlong6;
				}else if(i==7)
				{
					d = latlong7;
				}else if(i==8)
				{
					d = latlong8;
				}else if(i==9)
				{
					d = latlong9;
				}
				return d;
				
			}
		    
	 
		
}
