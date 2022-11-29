package tea.entity.notices;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.custom.jjh.Voltype;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
import tea.entity.util.Card;
import tea.html.Anchor;
import tea.html.Span;
import tea.ui.TeaSession;

public class Notices {
	private static Cache cache=new Cache(100);
	private int nid;//表id
	private String noteid;//工程编号
    private int node;//node  id
	private String nname;//工程名称
	private String address;//工程地址
	private String ownerName;//业主单位名称
	private String generalName;//总包单位名称
	private String editname;//编辑者
	private String content;//内容
	private int recycle;//是否已删除
	private boolean isExsit;//是否存在
	private Date time;//发布时间
	private Date eidttime;//操作时间
	public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

	public static Notices find(int nid) throws SQLException{
		Notices not=(Notices) cache.get(nid);
		if(not==null){
			not=new Notices(nid);
			cache.put(nid, not);
		}
		return not;
	}
	public Notices(){}
	public Notices(int nid) throws SQLException{
		this.nid=nid;
		load();
	}
	private void load() throws SQLException {
		DbAdapter db =new DbAdapter();
		try{
		db.executeQuery("select nid,node,noteid,nname,address,ownerName,generalName,editname,[content],recycle,time,eidttime from notices where (recycle <>5 or recycle is null) and nid= "+getNid());
		if(db.next()){
			int i=1;
			this.nid=db.getInt(i++);
			this.node=db.getInt(i++);
			this.noteid=db.getString(i++);
			this.nname=db.getString(i++);
			this.address=db.getString(i++);
			this.ownerName=db.getString(i++);
			this.generalName=db.getString(i++);
			this.editname=db.getString(i++);
			this.content=db.getString(i++);
			this.recycle=db.getInt(i++);
			this.time=db.getDate(i++);
			this.eidttime=db.getDate(i++);
			this.isExsit=true;
		}else{
			this.isExsit=false;
		}
		}finally{
			db.close();
		}
	}

	public static Enumeration fintList(String sql,int page, int size) throws SQLException{
		Vector v=new Vector();
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("select nid from notices where (recycle <>5 or recycle is null) "+sql,page,size);
			while(db.next()){
				v.addElement(db.getInt(1));
			}
		}finally{
			db.close();
		}
		return v.elements();

	}
	public static void createNotices( String noteid,int node,String nname,String address,String ownerName,String generalName,
			String editname,String content,Date time,Date eidttime) throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("insert into notices(node,noteid,nname,address,ownerName,generalName,editname,[content],time,eidttime)  values (" +
					+node+","+db.cite(noteid)+","+db.cite(nname)+","+db.cite(address)+","+db.cite(ownerName)+","+db.cite(generalName)+","
					+db.cite(editname)+","+db.cite(content)+","+db.cite(time)+","+db.cite(eidttime)+")");

		}finally{
			db.close();
		}

	}
	public void updateNotices() throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("update  notices set  node="+this.node+",noteid="+db.cite(this.noteid)+",nname="+db.cite(this.nname)+",address="+db.cite(this.address)+",ownerName="+db.cite(this.ownerName)+"," +
					"generalName="+db.cite(this.generalName)+",editname="+db.cite(this.editname)+",[content]="+db.cite(this.content)+",time="+db.cite(this.time)+",eidttime="+db.cite(this.eidttime)+" where nid="+this.nid);

		}finally{
			db.close();
			cache.remove(this.nid);
		}

	}
	public void delteNotices() throws SQLException{
		this.setNvalue("recycle", "5");
	}
	public void setNvalue(String name ,String value) throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
		db.executeUpdate("update notices set "+name+"="+value+" where nid="+this.getNid());
		}finally{
			db.close();
			cache.remove(this.getNid());
		}
	}
	public static int count(String sql) throws SQLException{
		DbAdapter db=new DbAdapter();
		int count=0;
		try{
			db.executeQuery("select count(*) from notices where (recycle <>5 or recycle is null) "+sql);
			if(db.next()){
				count=db.getInt(1);
			}
		}finally{
			db.close();
		}
		return count;
	}

	public static String getDetail(Node node,Http h,int listing,String target) throws SQLException{
		Span span = null;
        StringBuilder content_sb = new StringBuilder();

        Enumeration e = Notices.fintList(" and node="+node._nNode, 0, 10);
        if(e.hasMoreElements())
        {
        	int nid=(Integer)e.nextElement();
            ListingDetail detail = ListingDetail.find(listing,99,h.language);;
            Iterator listingDetailEnumeration = detail.keys();
            Notices nt=Notices.find(nid);
            while(listingDetailEnumeration.hasNext())
            {
                String itemname = (String) listingDetailEnumeration.next(),value = null;
                int istype = detail.getIstype(itemname);
                if(istype == 0)
                {
                    continue;
                }


                if(itemname.equals("ProjectNumber"))
                {
                    value =nt.getNoteid() ;
                } else if(itemname.equals("ProjectName"))
                {
                    value =nt.getNname() ;
                } else if(itemname.equals("ProjectAddresss"))
                {
                    value =nt.getAddress() ;
                } else if(itemname.equals("OwnerName"))
                {
                    value =nt.getOwnerName() ;
                } else if(itemname.equals("PackageName"))
                {
                    value =nt.getGeneralName() ;
                } else if(itemname.equals("EditPerson"))
                {
                    value =nt.getEditname() ;
                } else if(itemname.equals("Content"))
                {
                    value =nt.getContent() ;
                } else if(itemname.equals("ReleaseTime"))
                {
                	String times="";
                	if(nt.getTime()!=null){
                		times =Notices.sdf2.format(nt.getTime()) ;
                	}
                    value =times ;
                }




                if(detail.getAnchor(itemname) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/resume/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("ResumeID" + itemname);
                content_sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
            }
        }

        return content_sb.toString();
	}
//	public  delete (int nid){}

	public boolean isExsit() {
		return isExsit;
	}

    public int getNid() {
		return nid;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public String getNoteid() {
		return noteid;
	}
	public void setNoteid(String noteid) {
		this.noteid = noteid;
	}
	public int getNode() {
		return node;
	}
	public void setNode(int node) {
		this.node = node;
	}
	public String getNname() {
		return nname;
	}
	public void setNname(String nname) {
		this.nname = nname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public String getGeneralName() {
		return generalName;
	}
	public void setGeneralName(String generalName) {
		this.generalName = generalName;
	}
	public String getEditname() {
		return editname;
	}
	public void setEditname(String editname) {
		this.editname = editname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRecycle() {
		return recycle;
	}
	public void setRecycle(int recycle) {
		this.recycle = recycle;
	}
	public Date getTime() {
		return time;
	}
	public String getTimes() {
		if(time!=null){
			return Notices.sdf2.format(time);
		}
		return "";
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Date getEidttime() {
		return eidttime;
	}
	public void setEidttime(Date eidttime) {
		this.eidttime = eidttime;
	}
}
