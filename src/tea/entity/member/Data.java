package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.bbs.BBSLevel;
import tea.entity.site.License;
import tea.entity.site.Subscriber;
import tea.entity.westrac.WestracIntegralLog;
import tea.entity.yl.shop.ShopOrder;
import tea.html.Anchor;
import tea.html.Image;
import tea.html.Text;
import tea.service.SMS;

import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Data extends Entity {

	public static ResultSet getResultSet(String sql) throws SQLException {
		DbAdapter db = new DbAdapter();
		ResultSet resultSet = null;
		try {
			 resultSet = db.executeQuerySql(sql);
		} finally {
			db.close();
		}
		return resultSet;
	}

}
