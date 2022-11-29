package tea.entity.yl.shopnew;

import java.io.InputStream;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.jdbc.object.RdbmsOperation;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Filex;
import tea.entity.Seq;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shop.*;

/**
 * 设置未开票数量和未回款金额的操作记录
 * @author yantong
 * */
public class SetDataRecord {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int hospitalid;		//医院id
	private int isback;		    //退回操作   0：增加粒子数  1：退回粒子数  2：退回账款 3：增加应收账款 4：减少应收账款
	public static String[] ISBACK={"改变粒子数","退回粒子数","退回账款","应收账款增加","应收账款减少","未开票粒子数增加","已开票粒子数增加"};//前3种都是后台改变的，后4种都是下单或者开具发票或者回款时改变的。
	private int noinvoice;	    //未开票数量
	private Double noreply;		//未回款金额
	private Date timespot;	    //未开票粒子数日期节点
	private Date timespot2;	    //应收账款日期节点
	private int member;         //创建人
	private Date createdate;    //创建日期
	private int isinvoice;      //已开票数量   //3.9后加。小屈后提的。
	private int status;         //改变来源：0：后台编辑   1：回款改变
	public String[] STATUS = {"后台编辑","回款改变","开具发票","下单"};
	private int replyid;        //回款id
	private Double replymoney;  //回款金额
	private Double remainmoney; //剩余回款金额
	private int ordernum;       //自动增长（每个医院从1开始）
	
	public SetDataRecord(int id){
		this.id = id;
	}
	
	public static ArrayList<SetDataRecord> find(String sql,int pos,int size){
		ArrayList<SetDataRecord> list = new ArrayList<SetDataRecord>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,hospitalid,isback,noinvoice,noreply,timespot,timespot2,member,createdate,isinvoice,status,replyid,replymoney,remainmoney,ordernum from SetDataRecord where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				SetDataRecord s = new SetDataRecord(rs.getInt(i++));
				s.setHospitalid(rs.getInt(i++));
				s.setIsback(rs.getInt(i++));
				s.setNoinvoice(rs.getInt(i++));
				s.setNoreply(rs.getDouble(i++));
				s.setTimespot(db.getDate(i++));
				s.setTimespot2(db.getDate(i++));
				s.setMember(rs.getInt(i++));
				s.setCreatedate(db.getDate(i++));
				s.setIsinvoice(rs.getInt(i++));
				s.setStatus(rs.getInt(i++));
				s.setReplyid(rs.getInt(i++));
				s.setReplymoney(rs.getDouble(i++));
				s.setRemainmoney(rs.getDouble(i++));
				s.setOrdernum(rs.getInt(i++));
				c.put(s.id, s);
				list.add(s);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static ArrayList<Integer> findhid(String sql,int pos,int size){
		ArrayList<Integer> list = new ArrayList<Integer>();
		DbAdapter db = new DbAdapter();
		String QSql = "select hospitalid from SetDataRecord where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				
				list.add(rs.getInt(1));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from SetDataRecord where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into SetDataRecord(id,hospitalid,isback,noinvoice,noreply,timespot,timespot2,member,createdate,isinvoice,status,replyid,replymoney,remainmoney,ordernum) values(" + (this.id = Seq.get()) + "," + this.hospitalid + "," + this.isback + "," + this.noinvoice + "," + this.noreply + "," + DbAdapter.cite(this.timespot)+","+DbAdapter.cite(this.timespot2) + "," +this.member + ","+DbAdapter.cite(this.createdate)+","+this.isinvoice+","+this.status+","+this.replyid+","+this.replymoney+","+this.remainmoney+","+this.ordernum+")";
		}else{
			sql = "update SetDataRecord set hospitalid =" + this.hospitalid + ",isback = " + this.isback + ",noinvoice = " + this.noinvoice + ",noreply = " + this.noreply + ",timespot = " + DbAdapter.cite(this.timespot)+",timespot2="+DbAdapter.cite(this.timespot2) + ",member = "+this.member+",createdate = " + DbAdapter.cite(this.createdate)+",isinvoice="+this.isinvoice+",status="+this.status+",replyid="+this.replyid+",replymoney="+this.replymoney+",remainmoney="+this.remainmoney+",ordernum="+this.ordernum+" where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public static void delete(int id){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"delete from SetDataRecord where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update SetDataRecord set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
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

	public int getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(int hospitalid) {
		this.hospitalid = hospitalid;
	}

	public int getIsback() {
		return isback;
	}

	public void setIsback(int isback) {
		this.isback = isback;
	}

	public int getNoinvoice() {
		return noinvoice;
	}

	public void setNoinvoice(int noinvoice) {
		this.noinvoice = noinvoice;
	}

	
	public Double getNoreply() {
		return noreply;
	}

	public void setNoreply(Double noreply) {
		this.noreply = noreply;
	}

	public Date getTimespot() {
		return timespot;
	}

	public void setTimespot(Date timespot) {
		this.timespot = timespot;
	}
	
	public Date getTimespot2() {
		return timespot2;
	}

	public void setTimespot2(Date timespot2) {
		this.timespot2 = timespot2;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public int getIsinvoice() {
		return isinvoice;
	}

	public void setIsinvoice(int isinvoice) {
		this.isinvoice = isinvoice;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getReplyid() {
		return replyid;
	}

	public void setReplyid(int replyid) {
		this.replyid = replyid;
	}

	public Double getReplymoney() {
		return replymoney;
	}

	public void setReplymoney(Double replymoney) {
		this.replymoney = replymoney;
	}

	public Double getRemainmoney() {
		return remainmoney;
	}

	public void setRemainmoney(Double remainmoney) {
		this.remainmoney = remainmoney;
	}

	public int getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}
	
	
	
	

}
