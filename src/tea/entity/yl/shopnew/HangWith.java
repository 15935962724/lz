package tea.entity.yl.shopnew;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Calendar;
import java.util.Date;

import javax.xml.crypto.Data;

import org.apache.poi.ss.formula.functions.T;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.Profile;

/**
 * 回款
 * */
public class HangWith {

	protected static Cache c = new Cache(50);

	private int id;
	private int rid;//回款id
	
	private float deductprice;//实际挂款


	private float replyPrice;//原回款

	private int bid;//回款匹配发票id
	
	private Date time;//时间
	
	private int member;//
	
	public HangWith(int id) {
		this.id = id;
	}

	public static HangWith find(int id) {
		HangWith aHospital = (HangWith) c.get(id);
		if (aHospital == null) {
			ArrayList<HangWith> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new HangWith(id) : list.get(0);
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
	
	public static ArrayList<HangWith> find(String sql, int pos, int size) {

		ArrayList<HangWith> list = new ArrayList<HangWith>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,rid,deductprice,time,member,replyPrice,bid from HangWith r "+tab(sql)+" where 1=1 "
				+ sql;
		try {
			db.executeQuery(QSql, pos, size);
			while (db.next()) {
				int i = 1;
				HangWith h = new HangWith(db.getInt(i++));
				h.rid = db.getInt(i++);
				h.deductprice = db.getFloat(i++);
				h.time = db.getDate(i++);
				h.member = db.getInt(i++);
				h.replyPrice = db.getFloat(i++);
				h.bid = db.getInt(i++);
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
		return DbAdapter.execute("select count(0) from HangWith r "+tab(sql)+" where 1=1 "
				+ sql);
	}
	
	public static int sumprice(String sql) throws SQLException {
		return DbAdapter.execute("select sum(replyprice) from HangWith r "+tab(sql)+" where 1=1 "
				+ sql);
	}

	public void set() throws SQLException {
		String sql = "";
		if (this.id < 1) {
			id = Seq.get();
			sql = "insert into HangWith(id,rid,deductprice,time,member,replyPrice,bid) values("+id+","+rid+","+deductprice+","+Database.cite(time)+","+member+","+replyPrice+","+bid+")";
		} else {
			sql = "update HangWith set rid="+rid+",deductprice="+deductprice+",time="+Database.cite(time)+",member="+member+",replyPrice="+replyPrice+",bid="+bid+" where id=" + this.id;
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
			db.executeUpdate(id, "delete from HangWith where id= " + id);
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
			db.executeUpdate(this.id, "update HangWith set " + column + "="
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

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public float getDeductprice() {
		return deductprice;
	}

	public void setDeductprice(float deductprice) {
		this.deductprice = deductprice;
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

	public float getReplyPrice() {
		return replyPrice;
	}

	public void setReplyPrice(float replyPrice) {
		this.replyPrice = replyPrice;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	/**
	 * 根据
	 * @return
	 */
	public static int findbid(int hid) {
		int bid = 0;
		List<BackInvoice> lstback2=BackInvoice.find(" and hangid = "+hid , 0, 1);
		if(lstback2.size()>0){
			//for(int i=0;i<lstback2.size();i++){
				BackInvoice back=lstback2.get(0);
				bid = back.getId();
			//}
		}
		return bid;
	}
    
	
	/**
	 * 根据
	 * @param bid
	 * @return
	 */
	public static float findDeductPriceBid(int bid) {
		float deductprice = 0;
		BackInvoice back=BackInvoice.find(bid);
		String rids=MT.f(back.getReplyid(),",");
		String[] ridarr=rids.split(",");
		//获取回款金额和回款编号
		for(int j=0;j<ridarr.length;j++){
			String rid1=ridarr[j];
			if(rid1.length()>0){
				int rid2=Integer.parseInt(rid1);
				ReplyMoney rm=ReplyMoney.find(rid2);
				List<HangWith> hangwith=HangWith.find(" and bid = "+bid+" order by time desc " , 0, 1);
				if(hangwith.size()>0) {
					HangWith hw = hangwith.get(0);
					deductprice = hw.deductprice;
				}
			}
		}
		return deductprice;
	}

	/**
	 * 根据
	 * @param bid
	 * @return
	 */
	public static float findReplyPricePriceBid(int bid) {
		float replyPrice = 0;
		BackInvoice back=BackInvoice.find(bid);
		String rids=MT.f(back.getReplyid(),",");
		String[] ridarr=rids.split(",");
		//获取回款金额和回款编号
		for(int j=0;j<ridarr.length;j++){
			String rid1=ridarr[j];
			if(rid1.length()>0){
				int rid2=Integer.parseInt(rid1);
				ReplyMoney rm=ReplyMoney.find(rid2);
				List<HangWith> hangwith=HangWith.find(" and rid = "+rm.getId()+" order by time desc " , 0, 1);
				if(hangwith.size()>0) {
					HangWith hw = hangwith.get(0);
					replyPrice = hw.replyPrice;
				}
			}
		}
		return replyPrice;
	}


	/**
	 * 根据
	 * @param bid
	 * @return
	 */
	public static HangWith findHw(int bid) {
		HangWith hw = HangWith.find(0);
		float deductprice = 0;
		BackInvoice back=BackInvoice.find(bid);
		String rids=MT.f(back.getReplyid(),",");
		String[] ridarr=rids.split(",");
		//获取回款金额和回款编号
		for(int j=0;j<ridarr.length;j++){
			String rid1=ridarr[j];
			if(rid1.length()>0){
				int rid2=Integer.parseInt(rid1);
				ReplyMoney rm=ReplyMoney.find(rid2);
				List<HangWith> hangwith=HangWith.find(" and bid = "+bid+" order by time desc " , 0, 1);
				if(hangwith.size()>0) {
					hw = hangwith.get(0);
				}
			}
		}
		return hw;
	}


}
