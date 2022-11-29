package tea.entity.yl.shopnew;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.xml.crypto.Data;

import org.apache.poi.ss.formula.functions.T;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import tea.entity.member.Profile;

/**
 * 回款
 * */
public class ReplyMoneyList {

	protected static Cache c = new Cache(50);


	private int id;//
	private String rids;//回款集合
	private String iids;//发票集合
	private int statusmember;//状态
	private String memberReturnStr;//退回原因
	private Date time;//时间
	private int member;//服务商
	
	

	public static ReplyMoneyList find(int id) {
		ReplyMoneyList aHospital = (ReplyMoneyList) c.get(id);
		if (aHospital == null) {
			ArrayList<ReplyMoneyList> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ReplyMoneyList(id) : list.get(0);
		}
		return aHospital;
	}
	
	public ReplyMoneyList(int id) {
		this.id = id;
	}

	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND h."))
            sb.append(" inner join shopHospital h on h.id = r.hid");
        return sb.toString();
    }
	
	public static ArrayList<ReplyMoneyList> find(String sql, int pos, int size) {
		ArrayList<ReplyMoneyList> list = new ArrayList<ReplyMoneyList>();
		DbAdapter db = new DbAdapter();
		String QSql = "select r.id,r.hid,r.replyTime,r.replyPrice,r.context,r.status,r.returnStr,r.member,r.time,r.statusmember,r.memberReturnStr,r.code,r.type from ReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql;
		try {
			db.executeQuery(QSql, pos, size);
			while (db.next()) {
				int i = 1;
				ReplyMoneyList h = new ReplyMoneyList(db.getInt(i++));
				c.put(h.id, h);
				list.add(h);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static int count(String sql) throws SQLException {
		return DbAdapter.execute("select count(0) from ReplyMoneyList r "+tab(sql)+" where 1=1 "
				+ sql);
	}

	public void set() throws SQLException {
		String sql = "";
		if (this.id < 1) {
			sql = "insert into ReplyMoneyList(id,hid,replyTime,replyPrice,context,status,returnStr,member,time,statusmember,memberReturnStr,code,type) values("+(this.id = Seq.get())+")";
		} else {
			sql = "update ReplyMoneyList set  where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(this.id);
	}

	public static void delete(int id) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id, "delete from ReplyMoneyList where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(id);
	}

	public void set(String column, String value) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update ReplyMoneyList set " + column + "="
					+ DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(this.id);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRids() {
		return rids;
	}

	public void setRids(String rids) {
		this.rids = rids;
	}

	public String getIids() {
		return iids;
	}

	public void setIids(String iids) {
		this.iids = iids;
	}

	public int getStatusmember() {
		return statusmember;
	}

	public void setStatusmember(int statusmember) {
		this.statusmember = statusmember;
	}

	public String getMemberReturnStr() {
		return memberReturnStr;
	}

	public void setMemberReturnStr(String memberReturnStr) {
		this.memberReturnStr = memberReturnStr;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}
	
	
	
}
