package tea.entity.yl.shopnew;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

/**
 * 申请服务费
 * @author yt
 * */
public class Charge {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;				        //服务商id
	private int hospitalid;			        //医院id
	private int backid;		            //backinvoice表主键 用逗号分隔(string改成int)
	private float payable;		            //应付服务费
	private float inputtax;		            //进项税返还
	private float total;		            //总计
	private int status;				        //状态 0：等待审核 1:审核通过 2：审核不通过
	public static String[] STATUS={"待审核","审核通过","审核不通过"};
	private Date createdate;                //申请服务费时间
	private String chargecode;              //服务费编号
	private float invoiceamount;            //发票总金额
	private int invoicenum;                 //发票总数量
	private String nobackreason;            //审核不通过原因
	private int istzfws;                    //是否通知服务商了  
	public static String[] ISTZFWS={"未通知服务商","已通知服务商","财务审核通过"};
	
	private int puid;//
	
	public Charge(int id){
		this.id = id;
	}
	
	public static Charge find(int id){
		Charge invoice = (Charge)c.get(id);
		if(invoice == null){
			ArrayList<Charge> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new Charge(id):list.get(0);
		}
		return invoice;
	}
	
	
	public static ArrayList<Charge> find(String sql,int pos,int size){
		ArrayList<Charge> list = new ArrayList<Charge>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,hospitalid,backid,payable,inputtax,total,status,createdate,chargecode,invoiceamount,invoicenum,nobackreason,istzfws,puid" +
				" from charge where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				Charge charge = new Charge(rs.getInt(i++));
				charge.setMember(rs.getInt(i++));
				charge.setHospitalid(rs.getInt(i++));
				charge.setBackid(rs.getInt(i++));
				charge.setPayable(rs.getFloat(i++));
				charge.setInputtax(rs.getFloat(i++));
				charge.setTotal(rs.getFloat(i++));
				charge.setStatus(rs.getInt(i++));
				charge.setCreatedate(db.getDate(i++));
				charge.setChargecode(rs.getString(i++));
				charge.setInvoiceamount(rs.getFloat(i++));
				charge.setInvoicenum(rs.getInt(i++));
				charge.setNobackreason(rs.getString(i++));
				charge.setIstzfws(rs.getInt(i++));
				charge.setPuid(rs.getInt(i++));
				c.put(charge.id, charge);
				list.add(charge);
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
		return DbAdapter.execute("select count(0) from charge where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into charge(id,member,hospitalid,backid,payable,inputtax,total,status,createdate,chargecode,invoiceamount,invoicenum,nobackreason,istzfws,puid" +
				  ") values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + this.hospitalid + "," + this.backid + "," 
					+ this.payable + "," + this.inputtax + "," + this.total + ","
				+ this.status +","+DbAdapter.cite(this.createdate)+","+DbAdapter.cite(this.chargecode)+","+this.invoiceamount+","+this.invoicenum+","+DbAdapter.cite(this.nobackreason)+","+this.istzfws+","+this.puid+")";
		}else{
			sql = "update charge set member=" + this.member +",hospitalid="+this.hospitalid+",backid="+this.backid 
					+",payable="+this.payable+",inputtax="+this.inputtax+",total="+this.total+
					",status="+this.status+",createdate="+DbAdapter.cite(this.createdate)+",chargecode="+DbAdapter.cite(this.chargecode)
					+",invoiceamount="+this.invoiceamount+",invoicenum="+this.invoicenum+",nobackreason="+DbAdapter.cite(this.nobackreason)+",istzfws="+this.istzfws+",puid="+this.puid+"  where id=" + this.id;
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
	
	public void delete(){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id,"delete from charge where id= " + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update charge set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	//计算服务费
	public static float getcharge(float price,float invoiceamount,float can){
		float a=0;
		a=(float) ((price-120)*can*(invoiceamount/price)/1.17);
		return a;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public int getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(int hospitalid) {
		this.hospitalid = hospitalid;
	}

	public int getBackid() {
		return backid;
	}

	public void setBackid(int backid) {
		this.backid = backid;
	}

	public float getPayable() {
		return payable;
	}

	public void setPayable(float payable) {
		this.payable = payable;
	}

	public float getInputtax() {
		return inputtax;
	}

	public void setInputtax(float inputtax) {
		this.inputtax = inputtax;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getChargecode() {
		return chargecode;
	}

	public void setChargecode(String chargecode) {
		this.chargecode = chargecode;
	}

	public float getInvoiceamount() {
		return invoiceamount;
	}

	public void setInvoiceamount(float invoiceamount) {
		this.invoiceamount = invoiceamount;
	}

	public int getInvoicenum() {
		return invoicenum;
	}

	public void setInvoicenum(int invoicenum) {
		this.invoicenum = invoicenum;
	}

	public String getNobackreason() {
		return nobackreason;
	}

	public void setNobackreason(String nobackreason) {
		this.nobackreason = nobackreason;
	}

	public int getIstzfws() {
		return istzfws;
	}

	public void setIstzfws(int istzfws) {
		this.istzfws = istzfws;
	}

	public int getPuid() {
		return puid;
	}

	public void setPuid(int puid) {
		this.puid = puid;
	}
	
	
	

}
