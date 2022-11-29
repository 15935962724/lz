package tea.entity.cfw;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;


public class MemberRegister extends Entity {
	
	private int mrid;
	private String names;//会员名称
	private int gender;//性别
	
	private Date birthdate;//出生日期
	private String occupation;//职业/Occupation
	private String conporation;//所属机构/Conporation
	private String mobile;//移动电话/Mobile No
	private String tel;//固定电话/Tel No
	private String email;//电子邮箱/E-mail
	private String fax;//传真/Fax:
	private String address;//邮寄地址/Mailing address
	private String postalcode;//邮编/Postal code
	private String favorite;//喜欢的艺术家
	private String activity;//喜欢的活动
	
	private String community;//
	//会员签名
	private String membersignature;
	//签名日期
	private Date signature;
	private Date times;//
	 
	private boolean exists;  
    
	
	          
	public final static String   ACTIVITY_TYPE [] ={"讲座/Lecture","写生活动/Painting activity","专业研讨会/Symoposium","艺术培训/Atrs training","国内外艺术之旅/Art trip","艺术品鉴赏/art appreciation","摄影之旅/Photographic trip","其它/Others"};
	 
	public MemberRegister(int mrid)throws SQLException
	{
		this.mrid = mrid;
		load();
	}
	public static MemberRegister find(int mrid) throws SQLException
	{
		return new MemberRegister(mrid);
	}

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT names,gender,birthdate,occupation,conporation,mobile,tel,email,fax,address,postalcode,activity,community,times,membersignature,signature,favorite FROM MemberRegister WHERE mrid = " + mrid);
            if(db.next())
            {
            	names = db.getString(1);
            	gender = db.getInt(2);
            	birthdate = db.getDate(3);
            	occupation = db.getString(4);
            	conporation=db.getString(5);
           
            	 mobile=db.getString(6);//
            	 tel=db.getString(7);//
            	 email=db.getString(8);//
            	 fax=db.getString(9);//
            	 address=db.getString(10);//
            	 postalcode=db.getString(11);//
            	 activity=db.getString(12);//
            	 community=db.getString(13);//
            	 times=db.getDate(14);//
            	 membersignature=db.getString(15);
            	 signature=db.getDate(16);
            	 favorite=db.getString(17);
            
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
    
    public static int create(String names,int gender,Date birthdate,String occupation,String conporation,String mobile,String tel,String email,String fax,String address,
    		String postalcode,String activity,String community,Date times,String membersignature,Date signature,String favorite) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO MemberRegister (names,gender,birthdate,occupation,conporation,mobile,tel,email,fax,address,postalcode,activity,community,times,membersignature,signature,favorite) " +
                             " VALUES ("+db.cite(names)+" , "+gender+","+db.cite(birthdate)+","+db.cite(occupation)+","+db.cite(conporation)+","+db.cite(mobile)+","+db.cite(tel)+" ," +
                             		"  "+db.cite(email)+","+db.cite(fax)+","+db.cite(address)+" ,"+db.cite(postalcode)+","+db.cite(activity)+","+db.cite(community)+" ,"+db.cite(times)+" ,"+db.cite(membersignature)+","+db.cite(signature)+","+db.cite(favorite)+" )");
            i = db.getInt("SELECT MAX(mrid) FROM MemberRegister");
        } finally
        {
            db.close();
        }
        return i; 
    }
    
    
    public void set(String names,int gender,Date birthdate,String occupation,String conporation,String mobile,String tel,String email,String fax,String address,
    		String postalcode,String activity,String membersignature,Date signature,String favorite) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE MemberRegister SET names =" + db.cite(names) + ",gender=" + gender + ",birthdate=" + db.cite(birthdate) + " ,occupation =" + db.cite(occupation) + "," +
            		"conporation =" + db.cite(conporation) + ",mobile =" + db.cite(mobile) + ",tel =" + db.cite(tel) + ",email =" + db.cite(email) + "" +
            				",fax =" + db.cite(fax) + ",address =" + db.cite(address) + ",postalcode =" + db.cite(postalcode) + ",activity =" + db.cite(activity) + "," +
            						"membersignature="+db.cite(membersignature)+",signature="+db.cite(signature)+",favorite="+db.cite(favorite)+" WHERE mrid=" + mrid);
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
 		   db.executeQuery("SELECT mrid FROM MemberRegister WHERE community= " + db.cite(community) + sql,pos,size);
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
 	           db.executeUpdate("DELETE FROM  MemberRegister WHERE mrid = " + mrid);

 	       } finally
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
 	           db.executeQuery("SELECT COUNT(mrid) FROM MemberRegister  WHERE community=" + db.cite(community) + sql);
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
	public String getNames() {
		return names;
	}
	public int getGender() {
		return gender;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public String getBirthdateToString()
	{
		if(birthdate == null)
			return  "";
		return sdf.format(birthdate);
	}
	public String getOccupation() {
		return occupation;
	}
	public String getConporation() {
		return conporation;
	}
	public String getMobile() {
		return mobile;
	}
	public String getTel() {
		return tel;
	}
	public String getEmail() {
		return email;
	}
	public String getFax() {
		return fax;
	}
	public String getAddress() {
		return address;
	}
	public String getPostalcode() {
		return postalcode;
	}
	public String getActivity() {
		return activity;
	}
	public String getCommunity() {
		return community;
	}
	public Date getTimes() {
		return times;
	}
	public String getTimesToString()
	{
		return sdf.format(times);  
	}
	public boolean isExists() {
		return exists;
	}

	public String getMembersignature() {
		return membersignature;
	}
	public Date getSignature() {
		return signature;
	}
	public String getSignatureToString()
	{
		if(signature == null)
		{
			return "";
		}
		return sdf.format(signature);
	}
	public String getFavorite()
	{
		return favorite;
	}


}
