package tea;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import tea.db.DbAdapter;

public class SeqShop
{
	public static SimpleDateFormat SDF = new SimpleDateFormat("yyMM");
	public static SimpleDateFormat SDFDD = new SimpleDateFormat("yyMMdd");
    public static DecimalFormat DF4 = new DecimalFormat("0000");
    public synchronized static int get(String name) throws SQLException
    {
        int no = 0; // Cluster.getInstance().no;
        name += no;
        int seqno = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            ResultSet rs = db.executeQuery("SELECT value FROM seq WHERE name=" + DbAdapter.cite(name), 0, Integer.MAX_VALUE);
            if (rs.next())
            {
                seqno = rs.getInt(1);
                db.executeUpdate("UPDATE seq SET value=value+1 WHERE name=" + DbAdapter.cite(name));
            } else
            {
                db.executeUpdate("INSERT INTO seq(name,value)VALUES(" + DbAdapter.cite(name) + ",1)");
            }
            rs.close();
            seqno++;
        } finally
        {
            db.close();
        }
        seqno = Integer.parseInt(no + DF4.format(seqno));
        return seqno;
    }

    public static String get() throws SQLException
    {
        String str = SDF.format(new Date());
        String strDD = SDFDD.format(new Date());
        return (strDD + DF4.format(get(str)));
    }
    
}
