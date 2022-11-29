package tea.entity.yl.shopnew;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 回款
 * */
public class ReplyMoney {

	protected static Cache c = new Cache(50);

	private int id;
	private int hid;
	private Date replyTime;// 回款时间
	private float replyPrice;//回款金额
	private String context;//备注
	
	private int type;//类型
	
	public static String [] typeARR = {"回款","挂款"};
	
	private int status;//审核状态
	public static String [] statusARR = {"待审核","已通过","已退回","待提交"};
	private String returnStr;//退回原因
	
	private int statusmember;//用户
	
	public static String [] statusmemberARR = {"未通知服务商","未匹配发票","待审核","已匹配发票","审核不通过"};
	
	private String memberReturnStr;//
	
	private String code;//回款编号
	
	private Date time;//
	
	private int member;//

	private int profile;//服务商id
	
	private int thmember;//退回人
	
	private int puid;//厂商id

	private int add_type; //添加回款类型   0按医院添加  1按服务商添加
	
	public ReplyMoney(int id) {
		this.id = id;
	}

	public static ReplyMoney find(int id) {
		ReplyMoney aHospital = (ReplyMoney) c.get(id);
		if (aHospital == null) {
			ArrayList<ReplyMoney> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ReplyMoney(id) : list.get(0);
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
	
	public static ArrayList<ReplyMoney> find(String sql, int pos, int size) {

		ArrayList<ReplyMoney> list = new ArrayList<ReplyMoney>();
		DbAdapter db = new DbAdapter();
		String QSql = "select r.id,r.hid,r.replyTime,r.replyPrice,r.context,r.status,r.returnStr,r.member,r.time,r.statusmember,r.memberReturnStr,r.code,r.type,r.profile,r.thmember,r.puid,r.add_type from ReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql;
		try {
			db.executeQuery(QSql, pos, size);
			while (db.next()) {
				int i = 1;
				ReplyMoney h = new ReplyMoney(db.getInt(i++));
				h.setHid(db.getInt(i++));
				h.setReplyTime(db.getDate(i++));
				h.setReplyPrice(db.getFloat(i++));
				h.setContext(db.getString(i++));
				h.setStatus(db.getInt(i++));
				h.setReturnStr(db.getString(i++));
				h.setMember(db.getInt(i++));
				h.setTime(db.getDate(i++));
				h.setStatusmember(db.getInt(i++));
				h.setMemberReturnStr(db.getString(i++));
				h.setCode(db.getString(i++));
				h.setType(db.getInt(i++));
				h.setProfile(db.getInt(i++));
				h.setThmember(db.getInt(i++));
				h.setPuid(db.getInt(i++));
				h.setAdd_type(db.getInt(i++));
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
		return DbAdapter.execute("select count(0) from ReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql);
	}
	
	public static int sumprice(String sql) throws SQLException {
		return DbAdapter.execute("select sum(replyprice) from ReplyMoney r "+tab(sql)+" where 1=1 "
				+ sql);
	}

	public void set() throws SQLException {
		String sql = "";
		if (this.id < 1) {
			sql = "insert into ReplyMoney(id,hid,replyTime,replyPrice,context,status,returnStr,member,time,statusmember,memberReturnStr,code,type,profile,thmember,puid,add_type) values("+(this.id = Seq.get())+","+hid+","+Database.cite(replyTime)+","+replyPrice+","+Database.cite(context)+","+status+","+Database.cite(returnStr)+","+member+","+Database.cite(time)+","+statusmember+","+Database.cite(memberReturnStr)+","+Database.cite(code)+","+type+","+profile+","+thmember+","+puid+","+add_type+")";
		} else {
			sql = "update ReplyMoney set hid="+hid+",replyTime="+Database.cite(replyTime)+",replyPrice="+replyPrice+",context="+Database.cite(context)+",status="+status+",returnStr="+Database.cite(returnStr)+",member="+member+",time="+Database.cite(time)+",statusmember="+statusmember+",memberReturnStr="+Database.cite(memberReturnStr)+",code="+Database.cite(code)+",type="+type+",profile="+profile+",thmember="+thmember+",puid="+puid+",add_type="+add_type+" where id=" + this.id;
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
			db.executeUpdate(id, "delete from ReplyMoney where id= " + id);
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
			db.executeUpdate(this.id, "update ReplyMoney set " + column + "="
					+ DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(this.id);
	}

	/**
	 * 回款信息提交审核
	 * @param rid
	 */
	public static void submission(int rid) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("update ReplyMoney set status = 0 where id=" + rid);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
	}

	public static Map<Integer,Float> find1(String sql) {
		Map<Integer,Float> map = new HashMap<Integer,Float>();
		DbAdapter db = new DbAdapter();
		String QSql = "select hid,sum(replyprice) from ReplyMoney where 1=1"
				+ sql;
		try {
			db.executeQuery(QSql);
			while (db.next()) {
				int hid0=db.getInt(1);
				float replyprice0=db.getFloat(2);
				map.put(hid0, replyprice0);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return map;
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

	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}

	public float getReplyPrice() {
		return replyPrice;
	}

	public void setReplyPrice(float replyPrice) {
		this.replyPrice = replyPrice;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getReturnStr() {
		return returnStr;
	}

	public void setReturnStr(String returnStr) {
		this.returnStr = returnStr;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getProfile() {
		return profile;
	}

	public void setProfile(int profile) {
		this.profile = profile;
	}

	public int getThmember() {
		return thmember;
	}

	public void setThmember(int thmember) {
		this.thmember = thmember;
	}

	public int getPuid() {
		return puid;
	}

	public void setPuid(int puid) {
		this.puid = puid;
	}

	public int getAdd_type() {
		return add_type;
	}

	public void setAdd_type(int add_type) {
		this.add_type = add_type;
	}
}
