package tea.entity.node;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;

public class Mphoto {
	private int id;
	private String author;// 作者
	private String phone;// 联系方式
	private String path;// 图片路径
	private String introduce;// 图片说明
	private String place;// 拍摄地点
	private Date time;// 拍摄时间
	private String parameters;// 拍摄参数
	private boolean isExits;// 是否存在
	private static Cache cache = new Cache(100);

	public Mphoto() {

	}

	public Mphoto(int id) {
		this.id = id;
		load();
	}

	public static Mphoto findPhoto(int id) {
		Mphoto mp = (Mphoto) cache.get(new Integer(id));
		if (mp == null) {
			mp = new Mphoto(id);
			cache.put(new Integer(id), mp);
		}
		return mp;

	}

	public static void set(int id, String author, String phone, String path,
			String introduce, String place, String time, String parameters) {
		Mphoto mp = Mphoto.findPhoto(id);
		DbAdapter db = new DbAdapter();
		try {
			StringBuffer sql = new StringBuffer();
			if (mp.isExits()) {
				sql.append("update Mphoto set author=" + DbAdapter.cite(author)
						+ " , phone=" + DbAdapter.cite(phone) + " , mpath="
						+ DbAdapter.cite(path) + " , introduce="
						+ DbAdapter.cite(introduce) + " , place="
						+ DbAdapter.cite(place) + " , mtime="
						+ DbAdapter.cite(time) + " , parameters="
						+ DbAdapter.cite(parameters) + " where id=" + id);
			} else {
				sql.append("insert into Mphoto (author,phone,mpath,introduce,place,mtime,parameters) values ("
						+ DbAdapter.cite(author)
						+ ","
						+ DbAdapter.cite(phone)
						+ ","
						+ DbAdapter.cite(path)
						+ ","
						+ DbAdapter.cite(introduce)
						+ ","
						+ DbAdapter.cite(place)
						+ ","
						+ DbAdapter.cite(time)
						+ "," + DbAdapter.cite(parameters)+")");
			}
			db.executeUpdate(sql.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
			cache.remove(new Integer(id));
		}
	}

	public static void set(int id,String name ,String value){
		DbAdapter db=new DbAdapter();
		try {
			db.executeUpdate("update Mphoto set "+name+"="+DbAdapter.cite(value)+" where id="+id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
			cache.remove(new Integer(id));
		}
	}
	
	public static void delete(int id){
		DbAdapter db=new DbAdapter();
		try {
			db.executeUpdate("delete from  Mphoto where id= "+id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
			cache.remove(new Integer(id));
		}
	}
	
	public static int countMphoto(String sql){
		int count=0;
		try {
			count=DbAdapter.execute("select count(*) from Mphoto where 1=1 "+sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}
	
	public void load() {
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select id,author,phone,mpath,introduce,place,mtime,parameters from Mphoto where id="+this.id);
			if (db.next()) {
				int i = 1;
				this.id = db.getInt(i++);
				this.author = db.getString(i++);
				this.phone = db.getString(i++);
				this.path = db.getString(i++);
				this.introduce = db.getString(i++);
				this.place = db.getString(i++);
				this.time = db.getDate(i++);
				this.parameters = db.getString(i++);
				this.isExits = true;
			} else {
				this.isExits = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close();
		}

	}

	public static Enumeration findMphotos(String sql, int page, int size) {
		DbAdapter db = new DbAdapter();
		Vector v = new Vector();
		try {
			db.executeQuery("select id from Mphoto where 1=1 " + sql, page,
					size);
			while (db.next()) {
				v.addElement(new Integer(db.getInt(1)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close();
		}
		return v.elements();

	}

	public int getId() {
		return id;
	}

	public boolean isExits() {
		return this.isExits;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getTime() {
		if(time==null){
			return "";
		}
		return Entity.sdf.format(time);
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getParameters() {
		return parameters;
	}

	public void setParameters(String parameters) {
		this.parameters = parameters;
	}
}
