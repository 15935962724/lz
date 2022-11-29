package tea.entity.node;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.resource.Resource;
import tea.ui.TeaSession;
import tea.ui.Utils;

public class WeatherIndex {
	private static Cache c=new Cache(100);
	public static String[] WI=new String[]{"HeatStrokeIndex","TheUVIndex","IndexOfTheMood","IndexOfTheAppointment","IndexOfTheNightlife","IndexOfTheUmbrella","MovementIndex","CarWashIndex","MeteorologicalIndexOfTransportation","MeteorologicalIndexOfRoads","" +
					"IndexOfTourism","IndexOfBodyFeelingTemperature","Windchill","ComfortIndex","DressingIndex","Apdimc","KiteIndex","HairdressingIndex","Acoi","IndexOfShopping","" +
					"SPF","IndexOfFishing","DryIndex","ColdIndex","CladIndex","MorningExerciseIndex","RowingMeteorologicalIndex","MeteorologicalIndexOfBeer"};
	private int id;
	private int node;
	
	private String HeatStrokeIndex;
	private String TheUVIndex;
	private String IndexOfTheMood;
	private String IndexOfTheAppointment;
	private String IndexOfTheNightlife;  
	private String IndexOfTheUmbrella;  
	private String MovementIndex; 
	private String CarWashIndex;
	private String MeteorologicalIndexOfTransportation;  
	private String MeteorologicalIndexOfRoads;

	private String IndexOfTourism; 
	private String IndexOfBodyFeelingTemperature;
	private String Windchill;
	private String ComfortIndex;
	private String DressingIndex;
	private String Apdimc;
	private String KiteIndex;
	private String HairdressingIndex;
	private String Acoi;
	private String IndexOfShopping;

	private String SPF;
	private String IndexOfFishing;
	private String DryIndex;
	private String ColdIndex;
	private String CladIndex;
	private String MorningExerciseIndex;
	private String RowingMeteorologicalIndex;
	private String MeteorologicalIndexOfBeer;
	private boolean isexist;
	
	public WeatherIndex(){}
	public WeatherIndex(int node) throws SQLException{
		this.node=node;
		load();
		
	}
	
	public static WeatherIndex find(int node) throws SQLException{
		WeatherIndex wi=(WeatherIndex)c.get(new Integer(node));
		if(wi==null&&(!wi.isexist)){
			wi=new WeatherIndex(node);
			c.put(new Integer(node), wi);
		}
		return wi;
	}
	private void load() throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("select id,HeatStrokeIndex,TheUVIndex,IndexOfTheMood,IndexOfTheAppointment,IndexOfTheNightlife,IndexOfTheUmbrella,MovementIndex,CarWashIndex,MeteorologicalIndexOfTransportation,MeteorologicalIndexOfRoads," +
					"IndexOfTourism,IndexOfBodyFeelingTemperature,Windchill,ComfortIndex,DressingIndex,Apdimc,KiteIndex,HairdressingIndex,Acoi,IndexOfShopping," +
					"SPF,IndexOfFishing,DryIndex,ColdIndex,CladIndex,MorningExerciseIndex,RowingMeteorologicalIndex,MeteorologicalIndexOfBeer from WeatherIndex where node="+this.node);
			if(db.next()){
				int i=1;
				this.id=db.getInt(i++);
				this.HeatStrokeIndex=db.getString(i++);
				this.TheUVIndex=db.getString(i++);
				this.IndexOfTheMood=db.getString(i++);
				this.IndexOfTheAppointment=db.getString(i++);
				this.IndexOfTheNightlife=db.getString(i++);  
				this.IndexOfTheUmbrella=db.getString(i++);  
				this.MovementIndex=db.getString(i++); 
				this.CarWashIndex=db.getString(i++);
				this.MeteorologicalIndexOfTransportation=db.getString(i++);  
				this.MeteorologicalIndexOfRoads=db.getString(i++);
	
				this.IndexOfTourism=db.getString(i++); 
				this.IndexOfBodyFeelingTemperature=db.getString(i++);
				this.Windchill=db.getString(i++);
				this.ComfortIndex=db.getString(i++);
				this.DressingIndex=db.getString(i++);
				this.Apdimc=db.getString(i++);
				this.KiteIndex=db.getString(i++);
				this.HairdressingIndex=db.getString(i++);
				this.Acoi=db.getString(i++);
				this.IndexOfShopping=db.getString(i++);
	
				this.SPF=db.getString(i++);
				this.IndexOfFishing=db.getString(i++);
				this.DryIndex=db.getString(i++);
				this.ColdIndex=db.getString(i++);
				this.CladIndex=db.getString(i++);
				this.MorningExerciseIndex=db.getString(i++);
				this.RowingMeteorologicalIndex=db.getString(i++);
				this.MeteorologicalIndexOfBeer=db.getString(i++);
				this.isexist=true;
			}else{
				this.isexist=false;
			}
		}finally{
			db.close();
		}
	}
	
	
	public  void set() throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("select node from WeatherIndex where node="+node);
			if(db.next()){
				db.executeUpdate("update WeatherIndex set HeatStrokeIndex="+DbAdapter.cite(HeatStrokeIndex)+",TheUVIndex="+DbAdapter.cite(TheUVIndex)+
						",IndexOfTheMood="+DbAdapter.cite(IndexOfTheMood)+",IndexOfTheAppointment="+DbAdapter.cite(IndexOfTheAppointment)+"," +
						"IndexOfTheNightlife="+DbAdapter.cite(IndexOfTheNightlife)+"," +"IndexOfTheUmbrella="+DbAdapter.cite(IndexOfTheUmbrella)
						+",MovementIndex="+DbAdapter.cite(MovementIndex)+",CarWashIndex="+DbAdapter.cite(CarWashIndex)
						+",MeteorologicalIndexOfTransportation="+DbAdapter.cite(MeteorologicalIndexOfTransportation)+",MeteorologicalIndexOfRoads="+DbAdapter.cite(MeteorologicalIndexOfRoads)+"," +
					"IndexOfTourism="+DbAdapter.cite(IndexOfTourism)+",IndexOfBodyFeelingTemperature="+DbAdapter.cite(IndexOfBodyFeelingTemperature)
					+",Windchill="+DbAdapter.cite(Windchill)+",ComfortIndex="+DbAdapter.cite(ComfortIndex)+",DressingIndex="+DbAdapter.cite(DressingIndex)
					+",Apdimc="+DbAdapter.cite(Apdimc)+",KiteIndex="+DbAdapter.cite(KiteIndex)+",HairdressingIndex="+DbAdapter.cite(HairdressingIndex)
					+",Acoi="+DbAdapter.cite(Acoi)+",IndexOfShopping="+DbAdapter.cite(IndexOfShopping)+"," +"SPF="+DbAdapter.cite(SPF)+",IndexOfFishing="+DbAdapter.cite(IndexOfFishing)
					+",DryIndex="+DbAdapter.cite(DryIndex)+",ColdIndex="+DbAdapter.cite(ColdIndex)+",CladIndex="+DbAdapter.cite(CladIndex)+",MorningExerciseIndex="+DbAdapter.cite(MorningExerciseIndex)
					+",RowingMeteorologicalIndex="+DbAdapter.cite(RowingMeteorologicalIndex)+",MeteorologicalIndexOfBeer="+DbAdapter.cite(MeteorologicalIndexOfBeer)+"  where node="+node);
				c.remove(new Integer(node));
			}else{
				db.executeUpdate("insert into WeatherIndex(node,HeatStrokeIndex,TheUVIndex,IndexOfTheMood,IndexOfTheAppointment,IndexOfTheNightlife," +
						"IndexOfTheUmbrella,MovementIndex,CarWashIndex,MeteorologicalIndexOfTransportation,MeteorologicalIndexOfRoads," +
					"IndexOfTourism,IndexOfBodyFeelingTemperature,Windchill,ComfortIndex,DressingIndex,Apdimc,KiteIndex,HairdressingIndex,Acoi,IndexOfShopping," +
					"SPF,IndexOfFishing,DryIndex,ColdIndex,CladIndex,MorningExerciseIndex,RowingMeteorologicalIndex,MeteorologicalIndexOfBeer) values (" +
					node+","+DbAdapter.cite(HeatStrokeIndex)+","+DbAdapter.cite(TheUVIndex)+","+DbAdapter.cite(IndexOfTheMood)
					+","+DbAdapter.cite(IndexOfTheAppointment)+","+DbAdapter.cite(IndexOfTheNightlife)+","+DbAdapter.cite(IndexOfTheUmbrella)+","
					+DbAdapter.cite(MovementIndex)+","+DbAdapter.cite(CarWashIndex)+","+DbAdapter.cite(MeteorologicalIndexOfTransportation)+","
					+DbAdapter.cite(MeteorologicalIndexOfRoads)+","+DbAdapter.cite(IndexOfTourism)+","+DbAdapter.cite(IndexOfBodyFeelingTemperature)+","
					+DbAdapter.cite(Windchill)+","+DbAdapter.cite(ComfortIndex)+","+DbAdapter.cite(DressingIndex)+","
					+DbAdapter.cite(Apdimc)+","+DbAdapter.cite(KiteIndex)+","+DbAdapter.cite(HairdressingIndex)+","
					+DbAdapter.cite(Acoi)+","+DbAdapter.cite(IndexOfShopping)+","+DbAdapter.cite(SPF)+","
					+DbAdapter.cite(IndexOfFishing)+","+DbAdapter.cite(DryIndex)+","+DbAdapter.cite(ColdIndex)+","
					+DbAdapter.cite(CladIndex)+","+DbAdapter.cite(MorningExerciseIndex)+","+DbAdapter.cite(RowingMeteorologicalIndex)+","+DbAdapter.cite(MeteorologicalIndexOfBeer)+")");
			}
			
		}finally{
			db.close();
		}
		
	}
	
	public static Enumeration findWeatherIndex(String sql,int pos,int size) throws SQLException{
		DbAdapter db=new DbAdapter();
		Vector v=new Vector();
		try{
			db.executeQuery("select node from WeatherIndex where 1=1 "+sql,pos,size);
			while(db.next()){
				v.addElement(new Integer(db.getInt(1)));
			}
		}finally{
			db.close();
			return v.elements();
		}
	}
	
	public static void delete(int node) throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("delete from WeatherIndex where node="+node);
		}finally{
			c.remove(new Integer(node));
			db.close();
		}
		
	}
	public boolean isExist() {
		return isexist;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNode() {
		return node;
	}

	public void setNode(int node) {
		this.node = node;
	}
	
	public static String wiTOString(){
		StringBuffer sb=new StringBuffer("/");
		for(int i=0;i<WeatherIndex.WI.length;i++){
			sb.append(WeatherIndex.WI[i]).append("/");
		}
		return sb.toString();
	} 
	
	public static String  getDetail(Node node,int listing,String target,TeaSession ts) throws SQLException{
		StringBuffer sb=new StringBuffer();
//		Subject subject=Subject.find(node._nNode, ts._nLanguage);
		WeatherIndex wi=WeatherIndex.find(node._nNode);
		String title=node.getSubject(ts._nLanguage);
		ListingDetail detail=ListingDetail.find(listing, 110, ts._nLanguage);
		Iterator it=detail.keys();
		String wit=WeatherIndex.wiTOString();
		while(it.hasNext()){
			StringBuffer sb2=new StringBuffer();
			String name=(String)it.next(),value=null;
			int type=detail.getIstype(name);
			if(type==0){
				continue;
			}
			boolean thi=false;
			String url="/"+(ts._nStatus==1?"xhtml":"html")+"/"+ts._strCommunity+"/weatherindex/"+node._nNode+"-"+ts._nLanguage+".htm";
			String bt=detail.getBeforeItem(name),at=detail.getAfterItem(name);
			Resource r=new Resource();
			if("name".equals(name)){
				value=title;
			}else if(wit.indexOf("/"+name+"/")>=0){
				 value=wi.getValue(name);
				 int wid=0;
				if(value!=null){
					wid=Integer.parseInt(value);
					WindexValue wv=new WindexValue(name, wid);
					if(wv.isExist()){
						String option=detail.getOptions(name);
						if(option.indexOf("/100/")!=-1){
							thi=true;
						}
						if(option.indexOf("/101/")!=-1){
							sb2.append("<span id='WeatherIndexID"+name+"_scope").append("'>").append(wv.getScope()).append("</span>");
						}
						if(option.indexOf("/102/")!=-1){
							sb2.append("<span id='WeatherIndexID"+name+"_index").append("'>").append(wid).append("</span>");
						}
						if(option.indexOf("/103/")!=-1){
							sb2.append("<span id='WeatherIndexID"+name+"_indexName").append("'>").append(wv.getIndexName()).append("</span>");
						}
						if(option.indexOf("/104/")!=-1){
							sb2.append("<span id='WeatherIndexID"+name+"_safe").append("'>").append(wv.getSafe()).append("</span>");
						}
						if(option.indexOf("/105/")!=-1){
							sb2.append("<span id='WeatherIndexID"+name+"_content").append("'>").append(wv.getContent()).append("</span>");
						}
						value=r.getString(ts._nLanguage, name);
					}else{
						value="";
					}
				}
				
			}
			
			
			if(value==null){
				value="";
			}
			if(type==2&&value.length()==0){
				continue;
			}
			
			value=detail.getOptionsToHtml(name, node, value);
			if(detail.getAnchor(name)!=0){
				value="<A href='"+url+"' target='"+target+"' title='"+title.replace('"', '\'')+"' >"+value+"<a>";
			}
			sb.append(bt);
			if(thi){
				sb.append("<span id='WeatherIndexID"+name+"_img' ><img src='/tea/weatherIndex/"+name+".gif'></span>");
			}
			sb.append("<span id='WeatherIndexID"+name+"' >").append(value).append("</span>");
			if(sb2.length()>0){
				sb.append(sb2);
			}
			sb.append(at);
		}
		return sb.toString();
	}
	
	
public  void setValue(String name, String value){
		
		
		if("HeatStrokeIndex".equals(name)){
			this.HeatStrokeIndex=value;
		}else if("TheUVIndex".equals(name)){
			this.TheUVIndex=value;
		}else if("IndexOfTheMood".equals(name)){
			this.IndexOfTheMood=value;
		}else if("IndexOfTheAppointment".equals(name)){
			this.IndexOfTheAppointment=value;
		}else if("IndexOfTheNightlife".equals(name)){
			this.IndexOfTheNightlife=value;
		}else if("IndexOfTheUmbrella".equals(name)){
			this.IndexOfTheUmbrella=value;
		}else if("MovementIndex".equals(name)){
			this.MovementIndex=value;
		}else if("CarWashIndex".equals(name)){
			this.CarWashIndex=value;
		}else if("MeteorologicalIndexOfTransportation".equals(name)){
			this.MeteorologicalIndexOfTransportation=value;
		}else if("MeteorologicalIndexOfRoads".equals(name)){
			this.MeteorologicalIndexOfRoads=value;
		}else if("IndexOfTourism".equals(name)){
			this.IndexOfTourism=value;
		}else if("IndexOfBodyFeelingTemperature".equals(name)){
			this.IndexOfBodyFeelingTemperature=value;
		}else if("Windchill".equals(name)){
			this.Windchill=value;
		}else if("ComfortIndex".equals(name)){
			this.ComfortIndex=value;
		}else if("DressingIndex".equals(name)){
			this.DressingIndex=value;
		}else if("Apdimc".equals(name)){
			this.Apdimc=value;
		}else if("KiteIndex".equals(name)){
			this.KiteIndex=value;
		}else if("Acoi".equals(name)){
			this.Acoi=value;
		}else if("IndexOfShopping".equals(name)){
			this.IndexOfShopping=value;
		}else if("SPF".equals(name)){
			this.SPF=value;
		}else if("IndexOfFishing".equals(name)){
			this.IndexOfFishing=value;
		}else if("DryIndex".equals(name)){
			this.DryIndex=value;
		}else if("ColdIndex".equals(name)){
			this.ColdIndex=value;
		}else if("MorningExerciseIndex".equals(name)){
			this.MorningExerciseIndex=value;
		}else if("RowingMeteorologicalIndex".equals(name)){
			this.RowingMeteorologicalIndex=value;
		}else if("MeteorologicalIndexOfBeer".equals(name)){
			this.MeteorologicalIndexOfBeer=value;
		}else if("CladIndex".equals(name)){
			this.CladIndex=value;
		}else if("HairdressingIndex".equals(name)){
			this.HairdressingIndex=value;
		}else{
			System.out.println(name);
		}
	}
	

public  String getValue(String name){
	
	
	if("HeatStrokeIndex".equals(name)){
		return this.HeatStrokeIndex;
	}else if("TheUVIndex".equals(name)){
		return this.TheUVIndex;
	}else if("IndexOfTheMood".equals(name)){
		return this.IndexOfTheMood;
	}else if("IndexOfTheAppointment".equals(name)){
		return this.IndexOfTheAppointment;
	}else if("IndexOfTheNightlife".equals(name)){
		return this.IndexOfTheNightlife;
	}else if("IndexOfTheUmbrella".equals(name)){
		return this.IndexOfTheUmbrella;
	}else if("MovementIndex".equals(name)){
		return this.MovementIndex;
	}else if("CarWashIndex".equals(name)){
		return this.CarWashIndex;
	}else if("MeteorologicalIndexOfTransportation".equals(name)){
		return this.MeteorologicalIndexOfTransportation;
	}else if("MeteorologicalIndexOfRoads".equals(name)){
		return this.MeteorologicalIndexOfRoads;
	}else if("IndexOfTourism".equals(name)){
		return this.IndexOfTourism;
	}else if("IndexOfBodyFeelingTemperature".equals(name)){
		return this.IndexOfBodyFeelingTemperature;
	}else if("Windchill".equals(name)){
		return this.Windchill;
	}else if("ComfortIndex".equals(name)){
		return this.ComfortIndex;
	}else if("DressingIndex".equals(name)){
		return this.DressingIndex;
	}else if("Apdimc".equals(name)){
		return this.Apdimc;
	}else if("KiteIndex".equals(name)){
		return this.KiteIndex;
	}else if("Acoi".equals(name)){
		return this.Acoi;
	}else if("IndexOfShopping".equals(name)){
		return this.IndexOfShopping;
	}else if("SPF".equals(name)){
		return this.SPF;
	}else if("IndexOfFishing".equals(name)){
		return this.IndexOfFishing;
	}else if("DryIndex".equals(name)){
		return this.DryIndex;
	}else if("ColdIndex".equals(name)){
		return this.ColdIndex;
	}else if("MorningExerciseIndex".equals(name)){
		return this.MorningExerciseIndex;
	}else if("RowingMeteorologicalIndex".equals(name)){
		return this.RowingMeteorologicalIndex;
	}else if("MeteorologicalIndexOfBeer".equals(name)){
		return this.MeteorologicalIndexOfBeer;
	}else if("HairdressingIndex".equals(name)){
		return this.HairdressingIndex;
	}else if("CladIndex".equals(name)){
		return this.CladIndex;
	}else{
		System.out.println(name);
		return "";
	}
	
}

}
