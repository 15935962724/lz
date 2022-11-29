package tea.entity.admin.erp.icard;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.Profile;

//卡
@SuppressWarnings("unchecked")
public class ICard extends Entity
{
    public static final String STATE_TYPE[] =
            {"禁用","正常","挂失","补办","","",""};
    String icard;
    int icardtype;
    String password; //密码
    BigDecimal money; //存入金额
    Date invaliddate; //作废日期
    int shopicard; //加盟店领卡记录
    int state; //0:禁用 1:正常 2:挂失
   
    

	Date time; //发行日期
    ///
    private int shine; //面部呈油光状况:  全脸   只在T字部位   少量
    private int stab; // 因环境或接触引起刺疼、红疹：  经常   偶尔   没有
    private int acne; //出现暗疮、粉刺：  经常   偶尔   没有
    private int sensitive; //因日晒敏感：  会发红，不会晒黑   会发红，然后变黑，易黑不红   没有
    private int spotted; //肤色不均出现斑点：  非常明显   不太明显   极不明显
    private int relaxation; //松弛或出现细纹：  非常明显   不太明显   极不明显
    private String aging; //自然老化：  有黑眼圈   有眼袋   眼圈出现细纹
    boolean exists;
    private Date  sxrq;
    BigDecimal zxfje;
    private int zxfcs;
    private String txdz;
    private BigDecimal price;
    private String cardname;
    private Date birthday;
    private BigDecimal czkjf;
    private BigDecimal ljyhje;  
    private BigDecimal ljsl; 
    private BigDecimal jfsl ;
    private int cs;
    private int sycs;  
    private  BigDecimal ljjf;
    private  String jmkh;
    private    BigDecimal zczje;
    
    public ICard(String icard) throws SQLException
    {
        this.icard = icard;
        load();
   
    
    }
    public static void delete(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM ICard WHERE icard=" + DbAdapter.cite(member));
           
        } finally
        {
            db.close();
        }
       
    }
    public static void set(String icard,int icardtype,BigDecimal money,int state,int shine,int stab,int acne,int sensitive,int spotted,int relaxation,String aging,
    		String  sxrq,BigDecimal zxfje,int zxfcs,String txdz,
    		   BigDecimal price,String cardname,String birthday,BigDecimal czkjf,
 		     BigDecimal ljyhje,  BigDecimal ljsl, BigDecimal jfsl ,
    		 int cs,int sycs,  BigDecimal ljjf,String jmkh,
    		   BigDecimal zczje) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {            j = db.executeUpdate("UPDATE ICard SET icardtype=" + icardtype + ",money=" + money + ",state=" + state + ",shine=" + shine + ",stab=" + stab + ",acne=" + acne + ",sensitive=" + sensitive + ",spotted=" + spotted + ",relaxation=" + relaxation + ",aging=" + DbAdapter.cite(aging) + 
            		",invaliddate="+DbAdapter.cite(sxrq)+",zxfje="+zxfje+",zxfcs="+zxfcs+",txdz="+DbAdapter.cite(txdz)+",price="+price+
            		",cardname="+DbAdapter.cite(cardname)+",birthday="+DbAdapter.cite(birthday)+",czkjf="+czkjf+
            		",ljyhje="+ljyhje+",ljsl="+ljsl+",jfsl="+jfsl+",cs="+cs+",sycs="+sycs+",ljjf="+ljjf+
            		",jmkh="+DbAdapter.cite(jmkh)+",zczje="+zczje
            		+" WHERE icard=" + DbAdapter.cite(icard));
            
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            ICard.create(icard,0,"",BigDecimal.ZERO,new Date(),new Date());
            ICard.set(icard,icardtype,money,state,shine,stab,acne,sensitive,spotted,relaxation,aging,
            		  sxrq,zxfje,zxfcs,txdz,price, cardname, birthday,  czkjf,ljyhje,ljsl,jfsl,
         		      cs,sycs,ljjf, jmkh,zczje );
        }
    }

    public static void set(String icard,int icardtype,BigDecimal money,int state,int shine,int stab,int acne,int sensitive,int spotted,int relaxation,String aging) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE ICard SET icardtype=" + icardtype + ",money=" + money + ",state=" + state + ",shine=" + shine + ",stab=" + stab + ",acne=" + acne + ",sensitive=" + sensitive + ",spotted=" + spotted + ",relaxation=" + relaxation + ",aging=" + DbAdapter.cite(aging) + " WHERE icard=" + DbAdapter.cite(icard));
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            ICard.create(icard,0,"",BigDecimal.ZERO,new Date(),new Date());
            ICard.set(icard,icardtype,money,state,shine,stab,acne,sensitive,spotted,relaxation,aging);
        }
    }
    public static ICard find(String icard) throws SQLException
    {
        return new ICard(icard);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT icardtype,password,money,invaliddate,time ,shine,stab,acne,sensitive,spotted,relaxation,aging,state," +
            		"invaliddate,zxfje,zxfcs,txdz,price,cardname,birthday,czkjf,ljyhje, ljsl, jfsl ,cs,sycs, ljjf,jmkh, zczje" +
            		" FROM ICard WHERE icard=" + DbAdapter.cite(icard));
            if(db.next())
            {   int i=1;
                icardtype = db.getInt(i++);
                password = db.getString(i++);
                money = db.getBigDecimal(i++,2);
                invaliddate = db.getDate(i++);
                time = db.getDate(i++);
                //
                shine = db.getInt(i++);
                stab = db.getInt(i++);
                acne = db.getInt(i++);
                sensitive = db.getInt(i++);
                spotted = db.getInt(i++);
                relaxation = db.getInt(i++);
                aging = db.getString(i++);
                state=db.getInt(i++);
                sxrq=db.getDate(i++);
                zxfje=db.getBigDecimal(i++, 2);
                zxfcs=db.getInt(i++);
                txdz=db.getString(i++);
                price=db.getBigDecimal(i++, 2);
                 cardname=db.getString(i++);
                 birthday=db.getDate(i++);
                 czkjf=db.getBigDecimal(i++, 2);
                 ljyhje=db.getBigDecimal(i++, 2); 
                 ljsl=db.getBigDecimal(i++, 2);
                 jfsl=db.getBigDecimal(i++, 2); 
                 cs=db.getInt(i++);
                 sycs=db.getInt(i++);  
                 ljjf=db.getBigDecimal(i++, 2);
                 jmkh=db.getString(i++);
                 zczje=db.getBigDecimal(i++, 2);
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

    public static boolean create(String icard,int icardtype,String password,BigDecimal money,Date invaliddate,Date time) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return 0 != db.executeUpdate("INSERT INTO ICard(icard,icardtype,password,money,invaliddate,shopicard,time)VALUES(" + DbAdapter.cite(icard) + "," + icardtype + "," + DbAdapter.cite(password) + "," + money + "," + DbAdapter.cite(invaliddate) + ",0," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String name,int mode,float integral,int discount) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ICard SET name=" + DbAdapter.cite(name) + ",mode=" + mode + ",integral=" + integral + ",discount=" + discount + " WHERE icard=" + icard);
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
            db.executeUpdate("DELETE FROM ICard WHERE icard=" + DbAdapter.cite(icard));
        } finally
        {
            db.close();
        }
    }

    public static Enumeration find(int icardtype,String sql,int pos,int size) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT icard FROM ICard WHERE 1=1");
        if(icardtype > 0)
        {
            sb.append(" AND icardtype=").append(icardtype);
        }
        sb.append(sql);
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sb.toString(),pos,size);
            while(db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        return find(0," AND icardtype IN(SELECT icardtype FROM ICardType WHERE community=" + DbAdapter.cite(community) + ")" + sql,pos,size);
    }

    public static int count(int icardtype,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM ICard WHERE icardtype=" + icardtype + sql);
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

    public String getPassword()
    {
        return password;
    }

    public BigDecimal getMoney()
    {
        return money;
    }
    public Date getInvalidDate()
    {
        return invaliddate;
    }

    public String getInvalidDateToString()
    {
        return Entity.sdf.format(invaliddate);
    }


    public int getICardType()
    {
        return icardtype;
    }

    public String getICard()
    {
        return icard;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getAcne()
    {
        return acne;
    }

    public String getAging()
    {
        return aging;
    }

    public String getIcard()
    {
        return icard;
    }

    public int getIcardtype()
    {
        return icardtype;
    }

    public Date getInvaliddate()
    {
        return invaliddate;
    }

    public int getRelaxation()
    {
        return relaxation;
    }

    public int getSensitive()
    {
        return sensitive;
    }

    public int getShine()
    {
        return shine;
    }

    public int getShopicard()
    {
        return shopicard;
    }

    public int getSpotted()
    {
        return spotted;
    }

    public int getStab()
    {
        return stab;
    }

    public Date getTime()
    {
        return time;
    }

    public int getShopICard()
    {
        return shopicard;
    }
    public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
	
    
	public String getSxrq() {
 
		
		 if(sxrq == null)
	        {
	            return "";
	        }

	        return Profile.sdf.format(sxrq);
	}

	public void setSxrq(Date sxrq) {
		this.sxrq = sxrq;
	}

	public BigDecimal getZxfje() {
		return zxfje;
	}

	public void setZxfje(BigDecimal zxfje) {
		this.zxfje = zxfje;
	}

	public int getZxfcs() {
		return zxfcs;
	}

	public void setZxfcs(int zxfcs) {
		this.zxfcs = zxfcs;
	}

	public String getTxdz() {
		return txdz;
	}

	public void setTxdz(String txdz) {
		this.txdz = txdz;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getCardname() {
		return cardname;
	}

	public void setCardname(String cardname) {
		this.cardname = cardname;
	}

	public String getBirthday() {
		 if(birthday == null)
	        {
	            return "";
	        }

	        return Profile.sdf.format(birthday);
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public BigDecimal getCzkjf() {
		return czkjf;
	}

	public void setCzkjf(BigDecimal czkjf) {
		this.czkjf = czkjf;
	}

	public BigDecimal getLjyhje() {
		return ljyhje;
	}

	public void setLjyhje(BigDecimal ljyhje) {
		this.ljyhje = ljyhje;
	}

	public BigDecimal getLjsl() {
		return ljsl;
	}

	public void setLjsl(BigDecimal ljsl) {
		this.ljsl = ljsl;
	}

	public BigDecimal getJfsl() {
		return jfsl;
	}

	public void setJfsl(BigDecimal jfsl) {
		this.jfsl = jfsl;
	}

	public int getCs() {
		return cs;
	}

	public void setCs(int cs) {
		this.cs = cs;
	}

	public int getSycs() {
		return sycs;
	}

	public void setSycs(int sycs) {
		this.sycs = sycs;
	}

	public BigDecimal getLjjf() {
		return ljjf;
	}

	public void setLjjf(BigDecimal ljjf) {
		this.ljjf = ljjf;
	}

	public String getJmkh() {
		return jmkh;
	}

	public void setJmkh(String jmkh) {
		this.jmkh = jmkh;
	}

	public BigDecimal getZczje() {
		return zczje;
	}
	public void setZczje(BigDecimal zczje) {
		this.zczje = zczje;
	}

	public static String[] getStateType() {
		return STATE_TYPE;
	}

	public void setIcard(String icard) {
		this.icard = icard;
	}

	public void setIcardtype(int icardtype) {
		this.icardtype = icardtype;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public void setInvaliddate(Date invaliddate) {
		this.invaliddate = invaliddate;
	}

	public void setShopicard(int shopicard) {
		this.shopicard = shopicard;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public void setShine(int shine) {
		this.shine = shine;
	}

	public void setStab(int stab) {
		this.stab = stab;
	}

	public void setAcne(int acne) {
		this.acne = acne;
	}

	public void setSensitive(int sensitive) {
		this.sensitive = sensitive;
	}

	public void setSpotted(int spotted) {
		this.spotted = spotted;
	}

	public void setRelaxation(int relaxation) {
		this.relaxation = relaxation;
	}

	public void setAging(String aging) {
		this.aging = aging;
	}

	public void setExists(boolean exists) {
		this.exists = exists;
	}

	protected static void setShopICard(String icard,int shopicard) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ICard SET shopicard=" + shopicard + " WHERE icard=" + DbAdapter.cite(icard));
        } finally
        {
            db.close();
        }
    }
}
