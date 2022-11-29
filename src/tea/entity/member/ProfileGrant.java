package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class ProfileGrant extends Entity
{

	public ProfileGrant()
	{
	}

	public static boolean isExisted(String member, RV rv) throws SQLException
	{
		boolean flag = false;
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT member   FROM ProfileGrant  WHERE member=" + DbAdapter.cite(member) + " AND rmember=" + DbAdapter.cite(rv._strR) + " AND vmember=" + DbAdapter.cite(rv._strV));
			flag = dbadapter.next();
		} finally
		{
			dbadapter.close();
		}
		return flag;
	}
}
