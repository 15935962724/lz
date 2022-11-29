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
 * 剩余的回款（回款后减去应收账款后需通知服务商的回款）
 * */
public class RemainReplyMoney {

	protected static Cache c = new Cache(50);

	private int id;
	private int hid;//医院id
	private int replyid;//回款id
	private float amount;//剩余回款金额（此时该医院应收账款为0）
	private int type;//类型
	public static String [] typeARR = {"回款","挂款"};
	private int statusmember;//用户状态
	public static String [] statusmemberARR = {"未通知服务商","未匹配发票","待审核","已匹配发票","审核不通过"};
	private String memberReturnStr;//
	private Date time;//创建时间
	private int profile;//服务商id
	//挂款记录要用到以下三个字段
	private String code;//回款编号
	private Date replyTime;//回款时间
	private int member;//创建人
	
	
	public RemainReplyMoney(int id) {
		this.id = id;
	}

	public static RemainReplyMoney find(int id) {
		RemainReplyMoney aHospital = (RemainReplyMoney) c.get(id);
		if (aHospital == null) {
			ArrayList<RemainReplyMoney> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new RemainReplyMoney(id) : list.get(0);
		}
		return aHospital;
	}

	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND h."))
            sb.append(" inner join shopHospital h on h.id = r.hid");
        return sb.toString();
    }
	
	public static ArrayList<RemainReplyMoney> find(String sql, int pos, int size) {
		ArrayList<RemainReplyMoney> list = new ArrayList<RemainReplyMoney>();
		DbAdapter db = new DbAdapter();
		String QSql = "select r.id,r.hid,r.replyid,r.amount,r.type,r.statusmember,r.memberReturnStr,r.time,r.profile,r.code,r.replyTime,r.member from RemainReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql;
		try {
			db.executeQuery(QSql, pos, size);
			while (db.next()) {
				int i = 1;
				RemainReplyMoney h = new RemainReplyMoney(db.getInt(i++));
				h.setHid(db.getInt(i++));
				h.setReplyid(db.getInt(i++));
				h.setAmount(db.getFloat(i++));
				h.setType(db.getInt(i++));
				h.setStatusmember(db.getInt(i++));
				h.setMemberReturnStr(db.getString(i++));
				h.setTime(db.getDate(i++));
				h.setProfile(db.getInt(i++));
				h.setCode(db.getString(i++));
				h.setReplyTime(db.getDate(i++));
				h.setMember(db.getInt(i++));
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
		return DbAdapter.execute("select count(0) from RemainReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql);
	}
	
	public static int sumprice(String sql) throws SQLException {
		return DbAdapter.execute("select sum(replyid) from RemainReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql);
	}

	public void set() throws SQLException {
		String sql = "";
		if (this.id < 1) {
			sql = "insert into RemainReplyMoney(id,hid,replyid,amount,type,statusmember,memberReturnStr,time,profile,code,replyTime,member) values("+(this.id = Seq.get())+","+hid+","+replyid+","+amount+","+type+","+statusmember+","+Database.cite(memberReturnStr)+","+DbAdapter.cite(time)+","+profile+","+DbAdapter.cite(code)+","+DbAdapter.cite(replyTime)+","+member+")";
		} else {
			sql = "update RemainReplyMoney set hid="+hid+",replyid="+replyid+",amount="+amount+",type="+type+",statusmember="+statusmember+",memberReturnStr="+Database.cite(memberReturnStr)+",time="+Database.cite(time)+",profile="+profile+",code="+DbAdapter.cite(code)+",replyTime="+DbAdapter.cite(replyTime)+",member="+member+" where id=" + this.id;
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
			db.executeUpdate(id, "delete from RemainReplyMoney where id= " + id);
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
			db.executeUpdate(this.id, "update RemainReplyMoney set " + column + "="
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

	public int getHid() {
		return hid;
	}

	public void setHid(int hid) {
		this.hid = hid;
	}

	public int getReplyid() {
		return replyid;
	}

	public void setReplyid(int replyid) {
		this.replyid = replyid;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
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

	public int getProfile() {
		return profile;
	}

	public void setProfile(int profile) {
		this.profile = profile;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	
	
	
    
}
