package tea.entity.plane;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;


public class PlaneBooking {
	public static Cache c = new Cache(100);
	public int id;
	public String name;
	public String address;
	public int city;
	public String content;
	public String mobile;
	public int price30;
	public int price45;
	public int price60;
	public int price90;
	public int price180;
    public String picture;
	
	public PlaneBooking(int id){
		this.id=id;
	}

	public static PlaneBooking find(int id){
		PlaneBooking p = (PlaneBooking) c.get(id);
        if(p == null)
        {
        	p=new PlaneBooking(0);
            DbAdapter db= new DbAdapter();
            try {
				db.executeQuery("select id,name,address,city,content,mobile,price30,price45,price60,price90,price180,picture from PlaneBooking where id="+id);
				if(db.next()){
					int i=1;
					p.id=db.getInt(i++);
					p.name=db.getString(i++);
					p.address=db.getString(i++);
					p.city=db.getInt(i++);
					p.content=db.getString(i++);
					p.mobile=db.getString(i++);
					p.price30=db.getInt(i++);
					p.price45=db.getInt(i++);
					p.price60=db.getInt(i++);
					p.price90=db.getInt(i++);
					p.price180=db.getInt(i++);
					p.picture=db.getString(i++);
					c.put(id,p);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				db.close();
			}
        }
        
        return p;
    }
	public static Enumeration find(String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PlaneBooking WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
	}
	
	public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM PlaneBooking WHERE 1=1" + sql);
    }
	
	public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE PlaneBooking SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }
	
	public void set() throws SQLException
    {
        String sql;
        if(id<1)
        {
            sql = "INSERT INTO PlaneBooking(name,address,city,content,mobile,price30,price45,price60,price90,price180,picture)VALUES(" + DbAdapter.cite(name) + ","
        	+ DbAdapter.cite(address) + "," + city + "," + DbAdapter.cite(content)+ "," + DbAdapter.cite(mobile)+ "," + price30 + "," + price45+","+price60 + "," + price90 + "," + price180 + ","+DbAdapter.cite(picture)+")";
        } else
            sql = "UPDATE PlaneBooking SET name=" + DbAdapter.cite(name)+ ",address=" + DbAdapter.cite(address)+ ",city=" + city+ ",content=" + DbAdapter.cite(content)+",mobile="+DbAdapter.cite(mobile)+",price30="+price30+",price45="+price45+ ",price60=" + price60+ ",price90=" +price90+ ",price180=" + price180+",picture="+DbAdapter.cite(picture)+ " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
            id = db.getInt("SELECT MAX(id) FROM PlaneBooking ");
        } finally
        {
            db.close();
        }
        c.remove(id);
    }
}
