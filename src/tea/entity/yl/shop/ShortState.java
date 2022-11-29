package tea.entity.yl.shop;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 
 * @author dou
 * 
 * MsgID与提交返回的MsgID一致。SendState只有两个值（bit类型），False（数据库存储为0）或者True（数据库存储为1），
 * 其中False是发送失败，True是发送成功，ReportState只有两个值（bit类型），False（数据库存储为0）或者True（数据库存储为1），
 * 其中True是状态报告成功即成功送达到手机上，False是失败。ReportResultInfo是状态报告的具体信息，譬如状态报告失败的错误代码信息，
 * 如ReportResultInfo里包含DB:0102，那说明用户手机停机。
 *
 *AccountID=dl-zhaojianbo&MsgID=1409241628004192103&MobilePhone=18263362708
 *&ReportResultInfo=DELIVRD&ReportState=True&ReportTime=2014-09-24 16:28:32.000&
 *SendedTime=2014-09-24 16:28:03.000&SendResultInfo=0&SendState=True&SPNumber=1069004951546223
 */
public class ShortState {
	
	static Cache c=new Cache(500);
	public static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private int id;
	private String AccountID;//客户账号dl-zhaojianbo
	private String MessageID;//(短信提交成功后会生成MsgID)1409241628004192103
	private String MobilePhone;	//客户提交手机号码18263362708
	private String ReportResultInfo;	//状态报告信息DELIVRD
	private int ReportState;	//状态报告，bit类型True
	private Date ReportTime;	//状态报告时间2014-09-24 16:28:32.000
	private String SendResultInfo;	//信息发送结果信息0
	private int SendState;	//信息发送状态，bit类型True
	private Date SendedTime;	//信息发送时间2014-09-24 16:28:03.000
	private String SPNumber;	//长号码（下发端口号）1069004951546223
	
	public ShortState(){}
	public ShortState(int id){}
	public static ShortState find(int id) throws SQLException{
		ShortState ss=(ShortState)c.get(id);
		if(ss==null){
			ArrayList al = find(" AND id=" + id,0,1);
			ss = al.size() < 1 ? new ShortState(id) : (ShortState) al.get(0);
		}
		return ss;
	}
	
	public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,AccountID,MessageID,MobilePhone,ReportResultInfo,ReportState,ReportTime,SendResultInfo,SendState,SendedTime,SPNumber FROM ShortState WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int i = 1;
                ShortState t = new ShortState(db.getInt(i++));
                t.AccountID = db.getString(i++);
                t.MessageID = db.getString(i++);
                t.MobilePhone = db.getString(i++);
                t.ReportResultInfo = db.getString(i++);
                t.ReportState = db.getInt(i++);
                t.ReportTime = db.getDate(i++);
                t.SendResultInfo = db.getString(i++);
                t.SendState = db.getInt(i++);
                t.SendedTime = db.getDate(i++);
                t.SPNumber = db.getString(i++);
                c.put(t.getId(),t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM ShortState WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql = "UPDATE ShortState SET AccountID="+DbAdapter.cite(AccountID)+",MessageID="+DbAdapter.cite(MessageID)+",MobilePhone="+DbAdapter.cite(MobilePhone)+",ReportResultInfo="+
    DbAdapter.cite(ReportResultInfo)+",ReportState="+ReportState+",ReportTime="+DbAdapter.cite(ReportTime)+",SendResultInfo="+DbAdapter.cite(SendResultInfo)+",SendState="+SendState+",SendedTime="
        		+DbAdapter.cite(SendedTime)+",SPNumber="+DbAdapter.cite(SPNumber)+" WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(0,sql);
            if(j < 1)
                db.executeUpdate(0,
                                 "INSERT INTO ShortState(id,AccountID,MessageID,MobilePhone,ReportResultInfo,ReportState,ReportTime,SendResultInfo,SendState,SendedTime,SPNumber)VALUES(" +
                                 Seq.get() + "," + DbAdapter.cite(AccountID) + "," + DbAdapter.cite(MessageID) + "," + DbAdapter.cite(MobilePhone) + "," + DbAdapter.cite(ReportResultInfo) + "," 
                                		 + ReportState + "," + DbAdapter.cite(ReportTime) + "," + DbAdapter.cite(SendResultInfo) + "," +
                                		 SendState + "," + DbAdapter.cite(SendedTime) + "," + DbAdapter.cite(SPNumber) +  ")");
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

   
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccountID() {
		return AccountID;
	}
	public void setAccountID(String accountID) {
		AccountID = accountID;
	}
	public String getMessageID() {
		return MessageID;
	}
	public void setMessageID(String messageID) {
		MessageID = messageID;
	}
	public String getMobilePhone() {
		return MobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		MobilePhone = mobilePhone;
	}
	public String getReportResultInfo() {
		return ReportResultInfo;
	}
	public void setReportResultInfo(String reportResultInfo) {
		ReportResultInfo = reportResultInfo;
	}
	public int getReportState() {
		return ReportState;
	}
	public void setReportState(int reportState) {
		ReportState = reportState;
	}
	public Date getReportTime() {
		return ReportTime;
	}
	public void setReportTime(Date reportTime) {
		ReportTime = reportTime;
	}
	public String getSendResultInfo() {
		return SendResultInfo;
	}
	public void setSendResultInfo(String sendResultInfo) {
		SendResultInfo = sendResultInfo;
	}
	public int getSendState() {
		return SendState;
	}
	public void setSendState(int sendState) {
		SendState = sendState;
	}
	public Date getSendedTime() {
		return SendedTime;
	}
	public void setSendedTime(Date sendedTime) {
		SendedTime = sendedTime;
	}
	public String getSPNumber() {
		return SPNumber;
	}
	public void setSPNumber(String sPNumber) {
		SPNumber = sPNumber;
	}
	
}
