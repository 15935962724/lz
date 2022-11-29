package tea.entity.lvyou;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import jxl.*;
import jxl.write.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.ProfileGolf;
import tea.resource.*;

public class LvyouModels
{
   
	 public int id;
	 public String name;

    public LvyouModels()
    {
   
    }
    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
       
        try
        {
         db.executeUpdate("delete from lvyoumodels where  id="+id);
          } finally
        {
            db.close();
        }
    
    }
    public void set(int id,	String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
     
        try
        {
            int j = db.executeUpdate("UPDATE lvyoumodels SET  name =" +DbAdapter.cite(name)  +
            		                 " WHERE id=" + id);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO lvyoumodels (name)VALUES (" + DbAdapter.cite(name)+")");
            }
        } finally
        {
            db.close();
        }
    
    }
    public static LvyouModels find(int id) throws SQLException
    {       DbAdapter db = new DbAdapter();
            LvyouModels city=new LvyouModels();
            try
            {
                db.executeQuery("SELECT	 id,name  FROM lvyoumodels WHERE id=" + id);
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
    public static ArrayList<LvyouModels> find() throws SQLException
    {
    	ArrayList<LvyouModels> al = new ArrayList<LvyouModels>();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,name FROM lvyoumodels");
            while(db.next())
            {
               LvyouModels g = new LvyouModels();
               g.setId(db.getInt(1));
               g.setName(db.getString(2));
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

  

  

}
