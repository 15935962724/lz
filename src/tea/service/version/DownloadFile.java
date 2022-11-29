package tea.service.version;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FilterInputStream;
import java.net.URL;
import java.util.Map;
import java.util.HashMap;
import tea.db.DbAdapter;

public class DownloadFile
{

  	public void download(String surl,String filePath) {
	   try {
	    URL  url = null;
        DbAdapter db = new DbAdapter();
        String client= "";
        String path = "";
        try
        {
            db.executeQuery("select clientname,downloadpath from updatepath");
            if (db.next())
            {
               client = db.getString(1);
               path = db.getString(2);
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }

         HttpRequester hreq = new HttpRequester(); //
            Map param = new HashMap();
            param.put("client", client);
            param.put("path",path);
            HttpRespons hr = hreq.sendGet(surl, param, null);
            String filelist = hr.getContent();

         try {
               url = new URL(surl);
             } catch(Exception e) {
                          System.out.println("this url is error");
		 }
		     FilterInputStream in=(FilterInputStream) url.openStream();
		     File fileOut=new File(filePath);
		     FileOutputStream out=new FileOutputStream(fileOut);
		     byte[] bytes=new byte[1024];
		     int c;
			while((c=in.read(bytes))!=-1) {
			 out.write(bytes,0,c);
			 }
		     in.close();
		     out.close();
		    } catch(Exception e) {
		    e.printStackTrace();
		     System.out.println("Error!");
		    }
	   }

    /*public static void main(String[] args){
    	DownloadFile df=new DownloadFile();
    	df.download("http://127.0.0.1:8080/update/workspace1.zip","c:\\ss.zip");


    }*/

}
