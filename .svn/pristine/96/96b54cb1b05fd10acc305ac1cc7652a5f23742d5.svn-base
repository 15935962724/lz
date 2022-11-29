package util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jsp.index_jsp;
import org.apache.tomcat.jni.FileInfo;

import net.mietian.convert.Video;

import tea.db.DbAdapter;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.Img;
import tea.entity.node.Node;
import tea.entity.node.SPicture;
import tea.entity.node.Specimen;
import tea.ui.TeaServlet;

public class ImpDatas extends TeaServlet{
	static SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	static SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	static Connection conn = null;
	static Statement sta =null;
	static int count1=0;
	static int count2=0;
	static int num=0;
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        PrintWriter out = response.getWriter();
        String act = h.get("act"),nexturl = h.get("nexturl","");
		System.out.println("目标：" + Http.REAL_PATH);
		out.println("<script>var mt=parent.mt,$=parent.$;</script>");
        if(act.equals("impspecimen"))
        {   
        	
        	String namepath=h.get("namepath");
        	String picpath=h.get("picpath");
        	if(namepath.length()>0){
        		File file=new File(namepath);
            	if (!file.exists()) {
            		out.println("<script>mt.show('数据文件不存在,请仔细检查路径是否正确')</script>");
            		return;
            	}
        	}
        	if(picpath.length()>0){
        		File file=new File(picpath);
            	if (!file.exists()) {
            		out.println("<script>mt.show('图片目录不存在，请仔细检查后重新提交')</script>");
            		return;
            	}
        	}
        	
        	String url = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ="+namepath;
			
    		try {
    			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    			conn = DriverManager.getConnection(url);
    			sta = conn.createStatement();
    			ResultSet rs = sta.executeQuery("select count(1) from Specimen");
    			int sum=0;
    			if(rs.next()){
    				sum=rs.getInt(1);
    				//rs.close();
    				//sta.close();
    				
    			}
    			rs = sta.executeQuery("select * from Specimen");
    			for (int j = 0; j < 20; j++)
    				out.write("// 显示进度条  \n");
    			for (int k=1;rs.next();k++) {
    				
    				int sid=rs.getInt(1);
    				
    				Specimen specimen=null;
    				ArrayList list=Specimen.find(" and sid="+sid, 0, 1);
    				if (list.size()<1){
    					specimen=new Specimen(0);
    				}else{
    					specimen=(Specimen)list.get(0);
    				}
    				specimen.sid=sid;
    				specimen.unit=getstr(2,rs);
    				specimen.bbgdm=getstr(3,rs);
    				specimen.species[1]=getstr(4,rs);
    				specimen.class1=getstr(5,rs);
    				specimen.order0=getstr(6,rs);
    				specimen.family=getstr(7,rs);
    				specimen.genus=getstr(8,rs);
    				specimen.species[0]=getstr(9,rs);
    				specimen.mutation=getstr(10,rs);
    				specimen.snumber=getstr(11,rs);
    				specimen.cperson=getstr(12,rs);
    				String temp=getstr(13,rs);
    				Date ctime=null;
    				if(temp.equals("")||temp==null){
    					ctime=new Date();
    				}else{
    					ctime=sdf2.parse(temp); 
    				}
    				
    				specimen.ctime=ctime;
    				specimen.cnumber=getstr(14,rs);
    				specimen.csite=getstr(15,rs);
    				//specimen.rname=MT.f(getstr(16,rs));
    				specimen.rcode=getstr(17, rs);
    				specimen.country=getstr(18,rs);
    				specimen.province=getstr(19,rs);
    				specimen.longitude=getstr(20, rs);
    				specimen.latitude=getstr(21, rs);
    				specimen.elevation=getstr(22,rs);
    				specimen.vegetation=getstr(23, rs);
    				specimen.environment=getstr(24, rs);
    				specimen.host=getstr(25, rs);
    				specimen.sexual=getstr(26, rs);
    				specimen.old=getstr(27, rs);
    				specimen.property=getstr(28, rs);
    				specimen.status=getvalue(getstr(29, rs));
    				specimen.preserve=getstr(30, rs);
    				specimen.conlive=getstr(31, rs);
    				specimen.share=getstr(32, rs);
    				specimen.getway=getstr(33, rs);
    				
    				specimen.discribe=getstr(34, rs);
    				
    				specimen.speciestype=rs.getInt(35);
    				
    				specimen.uuser=getstr(36, rs);
    				specimen.uid=rs.getInt(37);
    				specimen.enterdbdate=rs.getDate(38);
    				specimen.firstlevel=getstr(39,rs);
    				specimen.secondlevel=getstr(40,rs);
    				specimen.zyglm=getstr(41, rs);
    				specimen.picture=getstr(42, rs);
    				specimen.language=1;				
    				String msg= specimen.imp();
    				specimen.set("imp", sdf.format(new Date() ));
    				if(k==(sum-1)&&k%2==0){
    					out.print("<script>mt.progress(" + k + ","+sum+",'"+msg+"   请稍等.正在导入其他数据     " + k + "/"+sum+"');</script>");
    					out.flush();
    				}else if(k%2==0){
    					out.print("<script>mt.progress(" + k + ","+sum+",'"+msg+"        " + k + "/"+sum+"');</script>");
    					out.flush();
    				}
    				System.out.println("########"+count1++);
    			}
    			imppic(out);
    			imppicture(picpath,out);
    		} catch (Exception e) {
    			e.printStackTrace(); 
    			out.print("<script>mt.show('"+e.toString()+"');</script>");
    			Filex.logs("Exception"+sdf.format(new Date())+".txt", count1+e.toString());
    		} 
        }else if(act.equals("biaobenurl")){
        	String datapath=h.get("datapath");
        	if(datapath.length()>0){
        		File file=new File(datapath);
            	if (!file.exists()) {
            		out.println("<script>mt.show('数据文件不存在,请仔细检查路径是否正确')</script>");
            		return;
            	}
        	}
        	String tablename=h.get("tablename");
        	String url = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ="+datapath;
			
    		try {
    			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    			conn = DriverManager.getConnection(url);
    			sta = conn.createStatement();
    			ResultSet rs = sta.executeQuery("select count(1) from "+tablename);
    			int sum=0;
    			if(rs.next()){
    				sum=rs.getInt(1);  				
    			}

    			rs = sta.executeQuery("select catalogNumber from "+tablename);
    			
    			for(int k=0;rs.next();k++) {
    				int sid=rs.getInt(1);
    				DbAdapter db=new DbAdapter();
    				db.executeQuery("select node from specimen where sid="+sid);
    				if(db.next()){
    					Statement sta1 = conn.createStatement();
    					int node=db.getInt(1);
    					sta1.executeUpdate("update "+tablename+" set source='http://www.papc.cn/html/papc/specimen/"+node+"-1.htm' where catalogNumber="+sid+"");
    					count1++;
    					System.out.println(count1+"^-^---------"+sid);
    					if(k%100==0){
        					out.print("<script>mt.progress(" + k + ","+sum+",'Sid:"+sid+" 路径生成成功。。    " + k + "/"+sum+"');</script>");
        					out.flush();
        				}
    					sta1.close();
    				}else{
    					if(k%100==0){
        					out.print("<script>mt.progress(" + k + ","+sum+",'Sid:"+sid+" 路径生成失败，数据库中没有此数据。。    " + k + "/"+sum+"');</script>");
        					out.flush();
        				}
    				}
    				db.close();
    			}
    			out.print("<script>mt.show('导出完毕');</script>");

    		} catch (Exception e) {
    			out.print("<script>mt.show('"+e.toString()+"');</script>");
    			e.printStackTrace(); 
    		} 
        }else if(act.equals("impKmz")){
        	String kmzpath=h.get("kmzpath");
        	if(kmzpath.length()>0){
        		File file=new File(kmzpath);
            	if (!file.exists()) {
            		out.println("<script>mt.show('目录不存在,请仔细检查路径是否正确')</script>");
            		return;
            	}
        	}
        	final File[] fs = new File(kmzpath).listFiles();
            for(int i = 0;i < fs.length;i++)
            {
                final int j = i;
                try {
					scale2(fs[j],out);
				} catch (Exception e) {
					out.print("<script>mt.show('"+e.toString()+"');</script>");
					e.printStackTrace();
				}
            }
            out.print("<script>mt.show('导入完成');</script>");
        }
    }
	public static String getstr(int i,ResultSet rs) throws Exception{
    	byte[] bytes=rs.getBytes(i);
    	if(bytes==null)return null;
    	return new String(bytes, "GBK"); 	
    }
    public static int getvalue(String key){
    	int i=0;
    	if(key.equals("有花有果"))i=1;
    	if(key.equals("有花无果"))i=2;
    	if(key.equals("无花有果"))i=3;
    	if(key.equals("无花无果"))i=4;
    	if(key.equals("有孢子囊"))i=5;
    	if(key.equals("无孢子囊"))i=6;
    	return i;
    }
    public static void imppic(PrintWriter out){
    	
    	try {
    		ResultSet rset=sta.executeQuery("select count(1) from Picture");
			int sum=0;
			if(rset.next()){
				sum=rset.getInt(1);		
			}
			rset = sta.executeQuery("select * from Picture");
			for(int k=0;rset.next();k++) {
				
				int pid=rset.getInt(1);
				int picsid=rset.getInt(2);
				String mulname=getstr(3, rset);
				SPicture sPicture=null;
				ArrayList listpic=SPicture.find(" and sid="+picsid+" and mulname='"+mulname+"'", 0, 1);
				if (listpic.size()<1){
					sPicture=new SPicture(0);
				}else{
					sPicture=(SPicture)listpic.get(0);
				}
				sPicture.sid=picsid;
				sPicture.pid=pid;
				sPicture.mulname=mulname;
				sPicture.multype=getstr(4, rset);
				sPicture.keyword=getstr(5, rset);
				sPicture.copyrightowner=getstr(6, rset);
				sPicture.remark=getstr(7, rset);
				//sPicture.set();
				String msg=sPicture.imp();
				if(k==(sum-1)&&k%2==0){
					out.print("<script>mt.progress(" + k + ","+sum+",'"+msg+"   数据导入完成。。正在处理图片   " + k + "/"+sum+"');</script>");
					out.flush();
				}else if(k%2==0){
					out.print("<script>mt.progress(" + k + ","+sum+",'"+msg+"        " + k + "/"+sum+"');</script>");
					out.flush();
				}
				
				System.out.println("##########--"+count2++);
				sPicture.set("imp", sdf.format(new Date() ));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			out.print("<script>mt.show('"+e.toString()+"');</script>");
			Filex.logs("Exception"+sdf.format(new Date())+".txt", count2+e.toString());
		}
    }
    static int hits = 0;
    public static void imppicture(String path,final PrintWriter out){
    	System.out.println("目标：" + Http.REAL_PATH);
    	num=0;
    	hits=0;
    	getpicNum(path,"jpg");
        final File[] fs = new File(path).listFiles();
        //final File[] fs = new File("D:/TestData").listFiles();
        for(int i = 0;i < fs.length;i++) //
        {
            final int j = i;
            
            scale(fs[j],out);
            
        }
        out.print("<script>mt.show('图片处理完毕');</script>");
    }
    
    public static void scale(File f,PrintWriter out)
    {
        System.out.println((hits++) + "：" + f.getPath());
        if(f.isFile())
        {
            String name = f.getName();
            if("Thumbs.db".equals(name))
            {
                f.delete();
                return;
            }
            String ex = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
            if("rar".equals(ex) || "xls".equals(ex))
                return;
            if("avi".equals(ex))
            {
                String path = f.getPath();
                try
                {
                    Video v = new Video(path);
                    //转FLV
//                    path = path.substring(0,path.length() - 3) + "flv";
//                    path = path.substring(0,2) + "\\_flv_" + path.substring(2).toLowerCase();
//                    f = new File(path);
//                    f.getParentFile().mkdirs();
//                    v.width = 640;
//                    v.height = 480;
//                    v.start(path,new PrintWriter(System.out));
//                    if(true)
//                        return;
                    //
                    path = path.substring(0,path.length() - 3) + "jpg";
                    path = path.substring(0,2) + "\\_img_" + path.substring(2);
                    System.out.println("IMG：" + path);
                    f = new File(path);
                    f.getParentFile().mkdirs();
                    v.pic(0,path);
                } catch(Throwable th)
                {
                    th.printStackTrace();
                    return;
                }
            }
            Img i = new Img(f);
            //600 无水印
            i.quality = 100;
            i.width = i.height = 600;
            System.out.println("----------"+f.getPath());
            String path = f.getPath().replace('\\','/');
            path = path.substring(0,2) + "/600_src" + path.substring(2)
                   .replaceFirst("/TestData/","/").replaceFirst("Multimedia","-")
                   .replaceFirst("/红外相机数据处理2012.12.4/","/infrared/").toLowerCase();
            /*f = new File(path + path.substring(10));
            if(!f.exists())
            {
                f.getParentFile().mkdirs();
                i.start(f);
            }*/

            //170
            i = new Img(f);
            i.width = i.height = 170;
            File f2 = new File(Http.REAL_PATH + "/res/attch/170" + path.substring(10)); //10是:D:/600_src
            if(!f2.exists())
            {
                f2.getParentFile().mkdirs();
                i.start(f2);
                out.print("<script>mt.progress(" + hits + ","+num+",'图片"+name+"   " + hits + "/"+num+"  170处理成功');</script>");
				out.flush();
            }

            //600
            i = new Img(f);
            i.width = i.height = 600;
            i.gravity = "Center";
            i.composite = Http.REAL_PATH + "/res/papc/1303/watermark.png";
            File f3 = new File(Http.REAL_PATH + "/res/attch/600" + path.substring(10));
            if(!f3.exists())
            {
                f3.getParentFile().mkdirs();
                i.start(f3);
                out.print("<script>mt.progress(" + hits + ","+num+",'图片"+name+"   " + hits + "/"+num+"  600处理成功');</script>");
				out.flush();
                Filex.logs(sdf.format(new Date())+"picpath.txt", Http.REAL_PATH + "/res/attch/600" + path.substring(10));
            }
        } else
        {
            File[] fs = f.listFiles();
            if(fs == null)
            {
                System.out.println("NULL:" + f.getPath());
                return;
            }
            for(int i = 0;i < fs.length;i++)
            {
                scale(fs[i],out);
            }
        }
    }
    public static void getpicNum(String path,String type){
    	System.out.println("目标：" + Http.REAL_PATH);
        final File[] fs = new File(path).listFiles();
        for(int i = 0;i < fs.length;i++) //
        {
            if(fs[i].isDirectory()){
            	getpicNum(fs[i].toString(),type);
            }else{
            	String name = fs[i].getName();
            	String ex = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
                if(type.equals(ex)){
                	num++;
                }
            	
            }
        }
    }
    public static void scale2(File f,PrintWriter out) throws IOException, SQLException
    {
        System.out.println((hits++) + "：" + f.getPath());
        if(f.isFile())
        {
            String name = f.getName();
            Enumeration e;
			
				e = Node.find(" AND father=19 and hidden=0 AND nl.subject="+DbAdapter.cite(name.substring(0, name.length()-4)), 0, Integer.MAX_VALUE);
				for(int i=0;e.hasMoreElements();i++)
	            { 
	              int node=((Integer)e.nextElement()).intValue();
	              Node n=Node.find(node);
	              
	            //f.renameTo(new File(+node+".kmz")); 
	            copyFile(f, new File(Http.REAL_PATH + "/res/papc/kmz/"+node+".kmz"));
	            out.print("<script>mt.progress(" + hits + ","+num+",'kmz"+name+"   " + hits + "/"+num+"  导入成功。。');</script>");
				out.flush();  
	            }
			
            
        }
    }
	// 复制文件
    public static void copyFile(File sourceFile, File targetFile) throws IOException {
        BufferedInputStream inBuff = null;
        BufferedOutputStream outBuff = null;
        try {
            // 新建文件输入流并对它进行缓冲
            inBuff = new BufferedInputStream(new FileInputStream(sourceFile));

            // 新建文件输出流并对它进行缓冲
            outBuff = new BufferedOutputStream(new FileOutputStream(targetFile));

            // 缓冲数组
            byte[] b = new byte[1024 * 5];
            int len;
            while ((len = inBuff.read(b)) != -1) {
                outBuff.write(b, 0, len);
            }
            // 刷新此缓冲的输出流
            outBuff.flush();
        } finally {
            // 关闭流
            if (inBuff != null)
                inBuff.close();
            if (outBuff != null)
                outBuff.close();
        }
    }
}
