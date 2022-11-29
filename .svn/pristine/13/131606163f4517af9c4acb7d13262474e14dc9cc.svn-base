package tea.entity.taoism;

import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.Cache;

public class Country {
	private static Cache c = new Cache(50);
	public String id;
    public String name;
    
    public static String find(String id) throws SQLException
    {
        String name="";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name FROM Country t  WHERE id="+DbAdapter.cite(id));
            if(db.next())
            {
            	name=db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return name;
    }

}
