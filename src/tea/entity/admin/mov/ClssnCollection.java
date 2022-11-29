package tea.entity.admin.mov;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import tea.entity.node.Score;
import tea.entity.site.License;
import tea.entity.*;

import  org.htmlparser.NodeFilter;
import  org.htmlparser.Parser;
import  org.htmlparser.PrototypicalNodeFactory;
import  org.htmlparser.filters.*;
import  org.htmlparser.tags.ImageTag;
import  org.htmlparser.tags.LinkTag;
import  org.htmlparser.util.NodeList;
import  org.htmlparser.util.ParserException;


public class ClssnCollection {
    protected static Cache _cache = new Cache(100);


	  //定时更新
    public static void sync()
    {
    	 try
         {
    		/* License license = License.getInstance();
    			if(license.getListenertype()!=null && license.getListenertype().indexOf("/3/")!=-1) 
            	{       		
            	}else{return;}
    		 Timer timer = new Timer();
             timer.schedule(new TimerTask()
             {
                 String last = null;
                 public void run()
                 {
                	 try 
					{
                		System.out.println("==扫描电子报封面：1小时扫描一次==");
                	     ClssnCollection.UpdateCollection();
					} catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                 }

           //   },0,1* 60 * 1000);//2分钟扫描一次
        // },0,2* 60 * 1000);//2分钟扫描一次
             },0,1 * 60 * 60 * 1000);//1个小时扫描一次*/
         } catch(Exception ex)
         {
             ex.printStackTrace();
         }

    }


    public static void UpdateCollection()throws SQLException
    {




    	String url = "http://59.252.162.9:8080/bzdbdl/";
    	String code = "gb2312";

    	Parser parser;
		try {
				parser = new Parser(url);
				parser.setEncoding(code);


	    	String listbegin="<table cellSpacing=\"1\" cellPadding=\"0\" width=\"100%\" bgColor=\"#9c9c9c\" border=\"0\">";//开始
	    	String listend="width=\"310\" height=\"481\" border=\"0\"/></a>";//结束

	    	NodeFilter filter = new TagNameFilter ("body");   // 取得网页主体内容
	    	NodeList nodelist = parser.extractAllNodesThatMatch(filter);

	    	String body="";
	    	if(nodelist.size()>0)
	    	{
	    		body=nodelist.elementAt(0).toHtml();
	    		int beginIndex=body.indexOf(listbegin);
	    		int endIndex=body.indexOf(listend, beginIndex+listbegin.length())+listend.length();
	    		if(beginIndex<0||endIndex<0||beginIndex>endIndex)
	    		body="<body>error</body>";
	    		else
	    			body=body.substring(beginIndex, endIndex);
	    	 }


	    	body = body.replaceAll("<tr>","");
	    	body = body.replaceAll("<td bgColor=\"#ffffff\">","");
	    	body = body.replaceAll(listbegin,"");
	    	body = body.replaceAll(listend,"");




	    	// String   regEx  =  "[^a-zA-Z0-9]";
	    	// 清除掉所有特殊字符
	    	String regEx= "<\\/?[^\\>]+>";
	    	java.util.regex.Pattern  p3   =   java.util.regex.Pattern.compile(regEx);
	    	java.util.regex.Matcher  m   =   p3.matcher(body);

	    	body = m.replaceAll("").trim();

	    	body = body.replaceAll("<img src='","");
	    	body = body.replaceAll("'","");

	    	body = url+body;
	    	//更新电子报封面到本地
	    	String strurl = tea.resource.Common.REAL_PATH+"res/Home/dzb/";
	    	
	    	File file = new File(strurl+"b_page_01.jpg");
	    	if(file.isFile())
	    	{
	    		file.delete();
	    	} 
	    	
	    	ClssnCollection.writeFile(body,strurl,"b_page_01.jpg");
	    	System.out.println("已经创建文件:"+strurl+"b_page_01.jpg");

	    	body ="<img src=/res/Home/dzb/b_page_01.jpg?time="+new Date()+" />";
	    	ClssnCollection.getUrl(body);
		} catch (ParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


    }




    public  static String getUrl(String url)
    {
    	String sss = url;
    	if(url!=null && url.length()>0)
    	{
    		 _cache.put("1",url);
    	}else
    	{
    		sss = (String) _cache.get("1");
    	}

    return sss;
    }

    public static void writeFile(String strUrl,String filepath,String fileName){
    	    URL url = null;
    	    try {
    	         url = new URL(strUrl);
    	    } catch (MalformedURLException e2) {
    	        e2.printStackTrace();
    	   }
    	   InputStream is = null;
    	   try {
    	       is = url.openStream();
    	   } catch (IOException e1) {
    	       e1.printStackTrace();
    	   }
    	 OutputStream os = null; 
    	 //File f = new File("d:\\webimg\\");
    	 File f = new File(filepath);
    	 f.mkdirs();
    	 try{
    	  os = new FileOutputStream(filepath+fileName);
    	  int bytesRead = 0;
    	  byte[] buffer = new byte[8192];

    	  while((bytesRead = is.read(buffer,0,8192))!=-1){
    	   os.write(buffer,0,bytesRead);
    	  }
    	 }catch(FileNotFoundException e){

    	 } catch (IOException e) {
    	  e.printStackTrace();
    	 }


    }


}
