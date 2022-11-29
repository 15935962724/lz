package tea.entity.city;

import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;

public class CityList {
	protected static Cache c = new Cache(50);
	public int cityid;
	/**城市中文*/
	public String cityName_CN;
	/**城市英文*/
	public String cityName_EN;
	/**父城市*/
	public int fatherId;
	/**热门城市*/
	public int hotcity;
	/**城市是否开放*/
	public int isOpen;
	/**区域类型*/
	public int areaType;
	public static String[] AREATYPE={"县或市区","商圈","地标"};
	public String community;
	public CityList(int cityid)
    {
        this.cityid = cityid;
    }

    public static CityList find(int cityid) throws SQLException
    {
    	CityList t = (CityList) c.get(cityid);
        if(t == null)
        {
            ArrayList al = find(" AND cityid=" + cityid,0,1);
            t = al.size() < 1 ? new CityList(cityid) : (CityList) al.get(0);
        }
        return t;
    }
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND n."))
            sb.append(" ");

        return sb.toString();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT cityid,cityName_CN,cityName_EN,fatherId,hotcity,isOpen,areaType,community FROM CityList c "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                CityList t = new CityList(rs.getInt(i++));
                t.cityName_CN = rs.getString(i++);
                t.cityName_EN = rs.getString(i++);
                t.fatherId = rs.getInt(i++);
                t.hotcity = rs.getInt(i++);
                t.isOpen = rs.getInt(i++);
                t.areaType=rs.getInt(i++);
                t.community=rs.getString(i++);
                c.put(t.cityid,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(1) FROM CityList WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(cityid,"INSERT INTO CityList(cityid,cityName_CN,cityName_EN,fatherId,hotcity,isOpen,areaType,community)VALUES(" + cityid + "," + DbAdapter.cite(cityName_CN) + "," + DbAdapter.cite(cityName_EN) + "," + fatherId + "," +hotcity  + "," + isOpen+"," + areaType +","+DbAdapter.cite(community)+")");
            if(j < 1)
                db.executeUpdate(cityid,"UPDATE CityList SET cityName_CN=" + DbAdapter.cite(cityName_CN) + ",cityName_EN=" + DbAdapter.cite(cityName_EN) + ",fatherId=" + fatherId + ",hotcity=" + hotcity + ",isOpen=" + isOpen+",areaType="+areaType +",community="+DbAdapter.cite(community) + " WHERE cityid=" + cityid);
        } finally
        {
        	c.remove(cityid);
            db.close();
        }

    }

    public void getselectCity(String city1,String city2,String city3) throws SQLException
    {
        StringBuffer sb=new StringBuffer();
        if(city1!=null){
         sb.append("<select name='"+city1+"' onchange=>");
         ArrayList list=getProvinceList();
         sb.append("<option value=''>-请选择-</option>");
         for(int i=0;i<list.size();i++){
        	 CityList cl=(CityList)list.get(i);
        	 sb.append("<option value='"+cl.cityid+"'>"+cl.cityName_CN+"</option>");
         }
         sb.append("</select>");
        }
        if(city2!=null){
            sb.append("<select name='"+city2+"'>");
            sb.append("<option value=''>-请选择-</option>");
            sb.append("</select>");
        }
    }
    public void delete() throws SQLException
    {
        DbAdapter.execute("delete from CityList  WHERE cityid=" + cityid);
        c.remove(cityid);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(cityid,"UPDATE CityList SET " + f + "=" + DbAdapter.cite(v) + " WHERE cityid=" + cityid);
        } finally
        {
            db.close();
        }
        c.remove(cityid);
    }
    public static String getProvinceName(int cityid,int language) throws SQLException
    {
    	CityList c=find(cityid);
    	String Province=language==1?c.cityName_CN:c.cityName_EN;
    	return Province;
    }
    public static ArrayList getProvinceList() throws SQLException
    {
    	ArrayList list=find(" fatherId=0", 0, Integer.MAX_VALUE);
    	return list;
    }
    public static int getMaxProvinceId() throws SQLException
    {
    	int max =DbAdapter.execute("select MAX(cityid) from CityList  WHERE Len(cityid)=2");
    	if(max==0)max=11;
    	return max;
    }
    public static int getMaxCityId(int cityid) throws SQLException
    {
    	int max =DbAdapter.execute("select MAX(cityid) from CityList  WHERE Len(cityid)=4");
    	if(max==0)max=Integer.parseInt(cityid+"01");
    	return max;
    }
    public static int getMaxAreaId(int cityid,int areaType) throws SQLException
    {
    	int max =DbAdapter.execute("select MAX(cityid) from CityList  WHERE Len(cityid)>=6 and areaType="+areaType);
    	if(max==0){
    		if(areaType==0){
    		  max=Integer.parseInt(cityid+"00");
    		}else if(areaType==1){
    		max=Integer.parseInt(cityid+"100");
    	    }else if(areaType==2){
    		max=Integer.parseInt(cityid+"200");
    	    }
    	}

    	return max;
    }
}
