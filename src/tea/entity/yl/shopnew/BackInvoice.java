package tea.entity.yl.shopnew;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import tea.entity.yl.shop.ProcurementUnitJoin;
import util.Config;

/**
 * 回款匹配发票
 * @author yt
 * */
public class BackInvoice {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;				        //服务商id
	private int hospitalid;			        //医院id
	private Date createdate;		        //匹配时间
	private String replyid;		            //回款编号
	private String invoiceid;		        //发票编号
	private int hangid;		                //产生的挂款id
	private int status;				        //状态 0：等待审核
	public static String[] STATUS={"待审核","审核通过","审核不通过"};
	private float replyamount;              //回款金额
	private float hangamount;               //挂款金额
	private float matchamount;              //匹配金额
	private String nobackreason;            //未通过审核原因
	private int chargestatus;               //申请服务费状态  0:未提交  1：待审核  2：审核通过
	public static String[] CHARGESTATUS={"未提交","待审核","审核通过"};
	public float oldnoreply;                //应收账款金额
	public float soldnoreply;               //剩余应收账款
	
	private float deductprice;//扣除挂款（高科
	
	private int puid;//
	
	private String qianinvoiceid;//欠款发票id
	private float qianamount;//欠款金额
	
	private String huanid;//归还欠款id
	private float huanamount;//归还欠款金额

    private int deductionRecordType = 0;//实际服务费计算百分比
    public static String [] deductionRecordTypeARR = {"100%","90%","60%"};
    public static float [] deductionRecordTypeARRnum = {1,0.9f,0.6f};


    public BackInvoice(int id){
		this.id = id;
	}
	
	public static BackInvoice find(int id){
		BackInvoice invoice = (BackInvoice)c.get(id);
		if(invoice == null){
			ArrayList<BackInvoice> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new BackInvoice(id):list.get(0);
		}
		return invoice;
	}

	public static BackInvoice findHangId(int hangid){
		BackInvoice invoice = (BackInvoice)c.get(0);
		if(invoice == null){
			ArrayList<BackInvoice> list = find(" AND hangid = " + hangid, 0, 1);
			invoice = list.size() < 1 ? new BackInvoice(0):list.get(0);
		}
		return invoice;
	}

	/**
	 * @param sql
	 * @param pos
	 * @param size
	 * @return
	 */
	public static ArrayList<BackInvoice> find(String sql,int pos,int size){
		ArrayList<BackInvoice> list = new ArrayList<BackInvoice>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,hospitalid,createdate,replyid,invoiceid,hangid,status,replyamount,hangamount,matchamount,nobackreason,chargestatus,oldnoreply,soldnoreply,puid,qianinvoiceid,qianamount,huanid,huanamount,deductprice,deductionRecordType" +
				" from backinvoice where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				BackInvoice invoice = new BackInvoice(rs.getInt(i++));
				invoice.setMember(rs.getInt(i++));
				invoice.setHospitalid(rs.getInt(i++));
				invoice.setCreatedate(db.getDate(i++));
				invoice.setReplyid(rs.getString(i++));
				invoice.setInvoiceid(rs.getString(i++));
				invoice.setHangid(rs.getInt(i++));
				invoice.setStatus(rs.getInt(i++));
				invoice.setReplyamount(rs.getFloat(i++));
				invoice.setHangamount(rs.getFloat(i++));
				invoice.setMatchamount(rs.getFloat(i++));
				invoice.setNobackreason(rs.getString(i++));
				invoice.setChargestatus(rs.getInt(i++));
				invoice.setOldnoreply(rs.getFloat(i++));
				invoice.setSoldnoreply(rs.getFloat(i++));
				invoice.setPuid(rs.getInt(i++));
				invoice.setQianinvoiceid(rs.getString(i++));
				invoice.setQianamount(rs.getFloat(i++));
				invoice.setHuanid(rs.getString(i++));
				invoice.setHuanamount(rs.getFloat(i++));
				invoice.setDeductprice(rs.getFloat(i++));
				invoice.setDeductionRecordType(rs.getInt(i++));
				c.put(invoice.id, invoice);
				list.add(invoice);
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
		return DbAdapter.execute("select count(0) from backinvoice where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into backinvoice(id,member,hospitalid,createdate,replyid,invoiceid,hangid,status,replyamount,hangamount,matchamount,nobackreason,chargestatus,oldnoreply,soldnoreply,puid,qianinvoiceid,qianamount,huanid,huanamount,deductprice,deductionRecordType" +
				  ") values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + this.hospitalid + "," + DbAdapter.cite(this.createdate) + "," 
					+ DbAdapter.cite(this.replyid) + "," + DbAdapter.cite(this.invoiceid) + "," + this.hangid + ","
				+ this.status +","+this.replyamount+","+this.hangamount+ ","+this.matchamount+","+DbAdapter.cite(this.nobackreason)+","+this.chargestatus+","+this.oldnoreply+","+this.soldnoreply+","+puid+","+Database.cite(qianinvoiceid)+","+qianamount+","+Database.cite(huanid)+","+huanamount+","+deductprice+","+deductionRecordType+")";
		}else{
			sql = "update backinvoice set member=" + this.member +",hospitalid="+this.hospitalid+",createdate="+DbAdapter.cite(this.createdate) 
					+",replyid="+DbAdapter.cite(replyid)+",invoiceid="+DbAdapter.cite(this.invoiceid)+",hangid="+this.hangid+
					",status="+this.status+",replyamount="+this.replyamount+",hangamount="+this.hangamount+",matchamount="+this.matchamount
					+",nobackreason="+DbAdapter.cite(nobackreason)+",chargestatus="+this.chargestatus+",oldnoreply="+this.oldnoreply+",soldnoreply="+this.soldnoreply+ ",puid="+puid+",qianinvoiceid="+Database.cite(qianinvoiceid)+",qianamount="+qianamount+",huanid="+Database.cite(huanid)+",huanamount="+huanamount+",deductprice="+deductprice+",deductionRecordType="+deductionRecordType+" where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from backinvoice where id= " + this.id);
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
			db.executeUpdate(this.id, "update backinvoice set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}

	/**
	 * 计算扣款
	 * @param qianstr
	 * @return
	 */
	@Deprecated
	public static float findQianKuai(String qianstr) {
		float sum = 0;
   		String [] qians = qianstr.split(",");
 		for (int i = 1; i < qians.length; i++) {
			Invoice t= Invoice.find(Integer.parseInt(qians[i]));
			try {
				double amount = Double.parseDouble(String.valueOf(t.getAmount()));
				double fwf = Double.parseDouble(String.valueOf(Invoice.findfwf(Integer.parseInt(qians[i]))));
				BigDecimal b2=new BigDecimal(amount - fwf);
				double taxamount2=(double) b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//
				sum += taxamount2;
				//sum += taxamount2;
			}catch (Exception e) {
				
			}
		}
		return sum;
	}


	/**
	 * 计算预期扣款
	 * @param iid
	 * @return
	 */
	public static float invoiceWithhold(int iid) {
		float sum = 0;
		Invoice invoice = Invoice.find(iid);
		int phpuid = InvoiceData.getPuid(invoice.getId());
		//ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
		ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),invoice.getHospitalid());
		// 计算服务费:(开票价格-底价)*0.9844*数量/1.13
		double chargeamountsum =  (invoice.getAmount()/invoice.getNum()-puj.agentPriceNew)*0.1456*invoice.getNum()/1.13;

		double yuansum = (puj.agentPriceNew*invoice.getNum());
		chargeamountsum += yuansum;

		BigDecimal b2=new BigDecimal(chargeamountsum);
		double taxamount2=(double) b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//
		sum = (float) taxamount2;
		return sum;
	}

    public static float invoiceWithhold(int iid,long day) {
        float sum = 0;
        Invoice invoice = Invoice.find(iid);
        if(invoice.getPuid()== Config.getInt("junan")){//君安
            int [] days = {365,730};//12个月 24个月
            List<Float> sumlist = new ArrayList<Float>();
            sumlist.add(0,invoiceWithhold(iid));
            sumlist.add(1,invoice.getAmount());

            for(int i=0;i<days.length;i++){
                if(day>=days[i]){
                    sum = sumlist.get(i);
                }
            }

        }else if(invoice.getPuid()== Config.getInt("tongfu")){//欣科
            int [] days = {365,730};//12个月 24个月
            List<Float> sumlist = new ArrayList<Float>();
            sumlist.add(0,invoiceWithhold(iid));
            sumlist.add(1,invoice.getAmount());

            for(int i=0;i<days.length;i++){
                if(day>=days[i]){
                    sum = sumlist.get(i);
                }
            }

        }else if(invoice.getPuid()== Config.getInt("gaoke")){//高科
            int [] days = {270,365,730};//9个月 12个月 24个月
            List<Float> sumlist = new ArrayList<Float>();
            sumlist.add(0,invoiceWithhold(iid));
            sumlist.add(1,invoice.getAmount());
            sumlist.add(2,invoice.getAmount());

            for(int i=0;i<days.length;i++){
                if(day>=days[i]){
                    sum = sumlist.get(i);
                }
            }

        }


        return sum;
    }


    public static void main(String[] args) {
		invoiceWithhold(18032908);
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

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getReplyid() {
		return replyid;
	}

	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}

	public String getInvoiceid() {
		return invoiceid;
	}

	public void setInvoiceid(String invoiceid) {
		this.invoiceid = invoiceid;
	}

	public int getHangid() {
		return hangid;
	}

	public void setHangid(int hangid) {
		this.hangid = hangid;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public float getReplyamount() {
		return replyamount;
	}

	public void setReplyamount(float replyamount) {
		this.replyamount = replyamount;
	}

	public float getHangamount() {
		return hangamount;
	}

	public void setHangamount(float hangamount) {
		this.hangamount = hangamount;
	}

	public float getMatchamount() {
		return matchamount;
	}

	public void setMatchamount(float matchamount) {
		this.matchamount = matchamount;
	}

	public String getNobackreason() {
		return nobackreason;
	}

	public void setNobackreason(String nobackreason) {
		this.nobackreason = nobackreason;
	}

	public int getChargestatus() {
		return chargestatus;
	}

	public void setChargestatus(int chargestatus) {
		this.chargestatus = chargestatus;
	}

	public float getOldnoreply() {
		return oldnoreply;
	}

	public void setOldnoreply(float oldnoreply) {
		this.oldnoreply = oldnoreply;
	}

	public float getSoldnoreply() {
		return soldnoreply;
	}

	public void setSoldnoreply(float soldnoreply) {
		this.soldnoreply = soldnoreply;
	}

	public int getPuid() {
		return puid;
	}

	public void setPuid(int puid) {
		this.puid = puid;
	}

	public String getQianinvoiceid() {
		return qianinvoiceid;
	}

	public void setQianinvoiceid(String qianinvoiceid) {
		this.qianinvoiceid = qianinvoiceid;
	}

	public float getQianamount() {
		return qianamount;
	}

	public void setQianamount(float qianamount) {
		this.qianamount = qianamount;
	}

	public String getHuanid() {
		return huanid;
	}

	public void setHuanid(String huanid) {
		this.huanid = huanid;
	}

	public float getHuanamount() {
		return huanamount;
	}

	public void setHuanamount(float huanamount) {
		this.huanamount = huanamount;
	}

	public float getDeductprice() {
		return deductprice;
	}

	public void setDeductprice(float deductprice) {
		this.deductprice = deductprice;
	}

    public int getDeductionRecordType() {
        return deductionRecordType;
    }

    public void setDeductionRecordType(int deductionRecordType) {
        this.deductionRecordType = deductionRecordType;
    }
}
