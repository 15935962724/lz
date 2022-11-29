package tea.entity.lvyou;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.*;
import tea.resource.*;

public class LvyouCity
{
   
    public int id;
    public int fatheridid;
    public String name;

    public LvyouCity()
    {
   
    }
    
    public static LvyouCity find(int id) throws SQLException
    {
         
            DbAdapter db = new DbAdapter();
            LvyouCity city=new LvyouCity();
            try
            {
                db.executeQuery("SELECT	 id,name  FROM lvyou_city WHERE id=" + id);
                if(db.next())
                { 
                  city.setId(id);
                  city.setName(db.getString(2));
               } else
                {city.setId(id);
                city.setName("");
               }
            } finally
            {
                db.close();
            }
          return city;
    }
    public static ArrayList<LvyouCity> find1() throws SQLException
    {
    	ArrayList<LvyouCity> al = new ArrayList<LvyouCity>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,fatherid,name FROM lvyou_city where fatherid=0");
            while(db.next())
            {
               LvyouCity g = new LvyouCity();
               g.setId(db.getInt(1));
               g.setFatheridid(db.getInt(2));
               g.setName(db.getString(3));
               al.add(g);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public static ArrayList<LvyouCity> find2(int fatherid) throws SQLException
    {
    	ArrayList<LvyouCity> al = new ArrayList<LvyouCity>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,fatherid,name FROM lvyou_city where fatherid="+fatherid);
            while(db.next())
            {
               LvyouCity g = new LvyouCity();
               g.setId(db.getInt(1));
               g.setFatheridid(db.getInt(2));
               g.setName(db.getString(3));
               al.add(g);
            }
        } finally
        {
            db.close();
        }
        return al;
    }
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFatheridid() {
		return fatheridid;
	}

	public void setFatheridid(int fatheridid) {
		this.fatheridid = fatheridid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

  

  

}
