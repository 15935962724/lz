package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.Entity;
import java.sql.SQLException;

public class AnonPollResult extends Entity
{

    public AnonPollResult()
    {
    }

    public static void vote(int i,int j) throws SQLException
    {
        String s = "result" + (char) ((97 + j) - 1);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM AnonPollResult WHERE node=" + i);
            if(db.next())
            {
                db.executeUpdate("INSERT INTO AnonPollResult(node, resulta, resultb, resultc, resultd, resulte, resultf) VALUES (" + i + ", 0, 0, 0, 0, 0, 0)");
            }
            db.executeUpdate("UPDATE AnonPollResult  SET " + s + "=" + s + "+1" + " WHERE node=" + i);
        } finally
        {
            db.close();
        }
    }

    public static int getResult(int i,int j) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT result" + (char) ((97 + j) - 1) + " FROM AnonPollResult " + " WHERE node=" + i);
        } finally
        {
            db.close();
        }
        return k;
    }

    public static void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AnonPollResult  WHERE node=" + i);
        } finally
        {
            db.close();
        }
    }
}
