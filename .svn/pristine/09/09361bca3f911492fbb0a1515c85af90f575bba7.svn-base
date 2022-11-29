package tea.entity.zs;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.custom.jjh.Volunteer;

public class Ctf {
	   public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	   private Integer id=null;
	   private String name=null;
	   private Integer sex=null;
	   private String creNum=null;
	   private String creNumber=null;
	   private String creName=null;
	   private String creLv=null;
	   private String markName1=null;
	   private String markName2=null;
	   private String markName3=null;
	   private String markName4=null;
	   private String markName5=null;
	   private String markName6=null;
	   private String mark1=null;
	   private String mark2=null;
	   private String mark3=null;
	   private String mark4=null;
	   private String mark5=null;
	   private String mark6=null;
	   private Date time=null;
	   private String danwei=null;
	   private String gra=null;
	   private String photo=null;
	   private String otherName=null;
	   private String other=null;
	   private Integer isdel=null;
	   public Ctf(){
		   
	   }
       public Ctf(int id){
		   this.id=id;
	   }
       public Ctf(int id,String otherName,String other){
		   this.id=id;
		   this.otherName=otherName;
		   this.other=other;
	   }
       public Ctf(String name,String creNum){
		   this.name=name;
		   this.creNum=creNum;
	   }
	   public Ctf(Integer id,String name, Integer sex, String creNum, String creNumber,
			String creName, String creLv, String markName1, String markName2,
			String markName3, String markName4, String markName5,
			String markName6, String mark1, String mark2, String mark3,
			String mark4, String mark5, String mark6, Date time, String danwei,
			String gra, String photo, String otherName, String other) {
		super();
		this.id=id;
		this.name = name;
		this.sex = sex;
		this.creNum = creNum;
		this.creNumber = creNumber;
		this.creName = creName;
		this.creLv = creLv;
		this.markName1 = markName1;
		this.markName2 = markName2;
		this.markName3 = markName3;
		this.markName4 = markName4;
		this.markName5 = markName5;
		this.markName6 = markName6;
		this.mark1 = mark1;
		this.mark2 = mark2;
		this.mark3 = mark3;
		this.mark4 = mark4;
		this.mark5 = mark5;
		this.mark6 = mark6;
		this.time = time;
		this.danwei = danwei;
		this.gra = gra;
		this.photo = photo;
		this.otherName = otherName;
		this.other = other;
	}
	   public static Ctf getCtf(int cid) throws SQLException{
		   Ctf c=null;
		   List list=findCtf(" AND id="+cid,0,Integer.MAX_VALUE);
			if(list!=null&&list.size()>0){
				c=(Ctf) list.get(0);
			}else{
				
			}
			
			return c;
		}
	public void create(String name,int sex,String creNum,String creNumber,String creName,String creLv,String markName1,String markName2,String markName3,String markName4,String markName5,String markName6,String mark1,String mark2,String mark3,String mark4,String mark5,String mark6,String danwei,String gra,Date time,String photo,String otherName,String other) throws SQLException
	   {
	       DbAdapter db = new DbAdapter();
	       try
	       {
	           db.executeUpdate("INSERT INTO Certificate(name,sex,cre_num,cre_number,cre_name,cre_lv,mark_name1,mark_name2,mark_name3,mark_name4,mark_name5,mark_name6,mark1,mark2,mark3,mark4,mark5,mark6,danwei,gra,time,photo,other_name,other,isdel)VALUES(" + 
	                DbAdapter.cite(name) + "," + sex + "," + DbAdapter.cite(creNum) +
	           		","+ DbAdapter.cite(creNumber) + ","+ DbAdapter.cite(creName) + ","+ DbAdapter.cite(creLv) + ","+ 
	           		DbAdapter.cite(markName1) + ","+ DbAdapter.cite(markName2) + ","+ DbAdapter.cite(markName3) + ","+ 
	           		DbAdapter.cite(markName4) + ","+DbAdapter.cite(markName5) + ","+ DbAdapter.cite(markName6) + ","+ 
	           		DbAdapter.cite(mark1) + ","+ DbAdapter.cite(mark2) + ","+ DbAdapter.cite(mark3) + ","+ DbAdapter.cite(mark4) + 
	           		","+ DbAdapter.cite(mark5) + ","+ DbAdapter.cite(mark6) + ","+DbAdapter.cite(danwei) + ","+
	           		DbAdapter.cite(gra) +","+ DbAdapter.cite(time) +","+ DbAdapter.cite(photo) +","+ DbAdapter.cite(otherName) +","+ DbAdapter.cite(other) + ","+ 1+")");
	       } finally
	       {
	           db.close();
	       }
	   }
	   public void setCtf() throws SQLException{
		DbAdapter db=new DbAdapter();
			try {
				
					db.executeUpdate("UPDATE Certificate SET name="+db.cite(getName())+",sex="+getSex()+",cre_num="+db.cite(getCreNum())+",cre_number="+db.cite(getCreNumber())+",cre_name="+db.cite(getCreName())+",cre_lv="+db.cite(getCreLv())+",mark_name1="+db.cite(getMarkName1())+",mark_name2="+db.cite(getMarkName2())+",mark_name3="+db.cite(getMarkName3())+",mark_name4="+db.cite(getMarkName4())+",mark_name5="+db.cite(getMarkName5())+",mark_name6="+db.cite(getMarkName6())+",mark1="+db.cite(getMark1())+",mark2="+db.cite(getMark2())+",mark3="+db.cite(getMark3())+",mark4="+db.cite(getMark4())+",mark5="+db.cite(getMark5())+",mark6="+db.cite(getMark6())+",danwei="+db.cite(getDanwei())+",gra="+db.cite(getGra())+",time="+db.cite(getTime())+",photo="+db.cite(getPhoto())+",other_name="+db.cite(getOtherName())+",other="+db.cite(getOther())+" WHERE isdel=1 and id="+getId());
				
			} finally{
				db.close();
				
			}

	   }
	   public void updateCtf() throws SQLException{
			DbAdapter db=new DbAdapter();
				try {
					
						db.executeUpdate("UPDATE Certificate SET sex="+getSex()+",cre_number="+db.cite(getCreNumber())+",cre_name="+db.cite(getCreName())+",cre_lv="+db.cite(getCreLv())+",mark_name1="+db.cite(getMarkName1())+",mark_name2="+db.cite(getMarkName2())+",mark_name3="+db.cite(getMarkName3())+",mark_name4="+db.cite(getMarkName4())+",mark_name5="+db.cite(getMarkName5())+",mark_name6="+db.cite(getMarkName6())+",mark1="+db.cite(getMark1())+",mark2="+db.cite(getMark2())+",mark3="+db.cite(getMark3())+",mark4="+db.cite(getMark4())+",mark5="+db.cite(getMark5())+",mark6="+db.cite(getMark6())+",danwei="+db.cite(getDanwei())+",gra="+db.cite(getGra())+",time="+db.cite(getTime())+",photo="+db.cite(getPhoto())+",other_name="+db.cite(getOtherName())+",other="+db.cite(getOther())+" WHERE isdel=1 and name="+db.cite(getName())+" and cre_number="+db.cite(getCreNumber()));
					
				} finally{
					db.close();
					
				}

		   }
	   public void editbz() throws SQLException{
			DbAdapter db=new DbAdapter();
				try {
					
						db.executeUpdate("UPDATE Certificate SET other_name="+db.cite(getOtherName())+",other="+db.cite(getOther())+" WHERE id="+getId());
					
				} finally{
					db.close();
					
				}

		   }
	   public void delCtf() throws SQLException{
		   DbAdapter db=new DbAdapter();
			try {
				db.executeUpdate("UPDATE Certificate SET isdel = 0 where id="+getId());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				db.close();
				
			}
		}
	   public static int countCtf(String sql) throws SQLException{
		 return DbAdapter.execute("SELECT COUNT(*) FROM Certificate WHERE isdel=1  "+sql);
	   }
	   public static List findCtf(String sql,int page,int size) throws SQLException{
			List list=new ArrayList();
				DbAdapter db=new DbAdapter();
				try{
					ResultSet rs=db.executeQuery("SELECT id,name,sex,cre_num,cre_number,cre_name,cre_lv,mark_name1,mark_name2,mark_name3,mark_name4,mark_name5,mark_name6,mark1,mark2,mark3,mark4,mark5,mark6,danwei,gra,time,photo,other_name,other FROM Certificate WHERE 1=1 and isdel=1 "+sql, page, size);
					while(rs.next()){
						int i=1;
						int id=rs.getInt(i++);
						String name=rs.getString(i++);
						int sex=rs.getInt(i++);
						String creNum=rs.getString(i++);
						String creNumber=rs.getString(i++);
						String creName=rs.getString(i++);
						String creLv=rs.getString(i++);
						
						String markName1=rs.getString(i++);
						String markName2=rs.getString(i++);
						String markName3=rs.getString(i++);
						String markName4=rs.getString(i++);
						
						String markName5=rs.getString(i++);
						String markName6=rs.getString(i++);
						String mark1=rs.getString(i++);
						String mark2=rs.getString(i++);
						String mark3=rs.getString(i++);
						String mark4=rs.getString(i++);
						String mark5=rs.getString(i++);
						String mark6=rs.getString(i++);
						String danwei=rs.getString(i++);
						String gra=rs.getString(i++);
						Date time=rs.getDate(i++);
						String photo=rs.getString(i++);
						
						String otherName=rs.getString(i++);
						String other=rs.getString(i++);
						Ctf ctf=new Ctf(id,name, sex, creNum, creNumber, creName, creLv, markName1, markName2, markName3, markName4, markName5, markName6, mark1, mark2, mark3, mark4, mark5, mark6, time, danwei, gra, photo, otherName, other);
						list.add(ctf);
						
					}
					rs.close();
				}finally{
					db.close();
				}

			return list;
		}
	   
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getCreNum() {
		return creNum;
	}
	public void setCreNum(String creNum) {
		this.creNum = creNum;
	}
	public String getCreNumber() {
		return creNumber;
	}
	public void setCreNumber(String creNumber) {
		this.creNumber = creNumber;
	}
	public String getCreName() {
		return creName;
	}
	public void setCreName(String creName) {
		this.creName = creName;
	}
	public String getCreLv() {
		return creLv;
	}
	public void setCreLv(String creLv) {
		this.creLv = creLv;
	}
	public String getMarkName1() {
		return markName1;
	}
	public void setMarkName1(String markName1) {
		this.markName1 = markName1;
	}
	public String getMarkName2() {
		return markName2;
	}
	public void setMarkName2(String markName2) {
		this.markName2 = markName2;
	}
	public String getMarkName3() {
		return markName3;
	}
	public void setMarkName3(String markName3) {
		this.markName3 = markName3;
	}
	public String getMarkName4() {
		return markName4;
	}
	public void setMarkName4(String markName4) {
		this.markName4 = markName4;
	}
	public String getMark1() {
		return mark1;
	}
	public void setMark1(String mark1) {
		this.mark1 = mark1;
	}
	public String getMark2() {
		return mark2;
	}
	public void setMark2(String mark2) {
		this.mark2 = mark2;
	}
	public String getMark3() {
		return mark3;
	}
	public void setMark3(String mark3) {
		this.mark3 = mark3;
	}
	public String getMark4() {
		return mark4;
	}
	public void setMark4(String mark4) {
		this.mark4 = mark4;
	}
	public String getDanwei() {
		return danwei;
	}
	public void setDanwei(String danwei) {
		this.danwei = danwei;
	}
	public String getGra() {
		return gra;
	}
	public void setGra(String gra) {
		this.gra = gra;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getMarkName5() {
		return markName5;
	}
	public void setMarkName5(String markName5) {
		this.markName5 = markName5;
	}
	public String getMarkName6() {
		return markName6;
	}
	public void setMarkName6(String markName6) {
		this.markName6 = markName6;
	}
	public String getMark5() {
		return mark5;
	}
	public void setMark5(String mark5) {
		this.mark5 = mark5;
	}
	public String getMark6() {
		return mark6;
	}
	public void setMark6(String mark6) {
		this.mark6 = mark6;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	public String getOtherName() {
		return otherName;
	}
	public void setOtherName(String otherName) {
		this.otherName = otherName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getIsdel() {
		return isdel;
	}
	public void setIsdel(Integer isdel) {
		this.isdel = isdel;
	}
	
}
