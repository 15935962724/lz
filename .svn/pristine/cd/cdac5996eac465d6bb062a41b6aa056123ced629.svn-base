package app;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Http;
import tea.ui.TeaServlet;

public class FileList extends TeaServlet{
	static String rpath="";
	static int r=0,m=0;
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Http h = new Http(request);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String act = h.get("act");
		try {
			if("Filelist".equals(act)){
				String dir=h.get("dir");
				rpath=h.REAL_PATH;
				r=0;
				StringBuffer sb = new StringBuffer("[");
				final File[] fs = new File(rpath+"/res/papc/"+dir).listFiles();
		        //final File[] fs = new File("D:/TestData").listFiles();
		        for(int i = 0;i < fs.length;i++) //
		        {
		        	if(fs[i].isFile())
		            {
		            	String name = fs[i].getName();
		            	String path=fs[i].getPath();
		            	String s=(r==0?"{\"name\":\""+name+"\",\"path\":\""+get(path)+"\"}":",{\"name\":\""+name+"\",\"path\":\""+get(path)+"\"}");
		            	r=1;
		            	sb.append(s);
		            }
		            
		        }
		        sb.append("]");
		        out.println(sb.toString());
			}else if("dirlist".equals(act)){
				String community=h.get("community");
				m=0;
				String path=h.REAL_PATH+"/res/"+community+"/_doc/";
				StringBuffer sb = new StringBuffer("[");
				File[] fs=new File(path).listFiles();
				for(int i = 0;i < fs.length;i++) //
		        {
					String s=scale(fs[i],"root");
					sb.append(s);
		        }
		        sb.append("]");
		        out.println(sb.toString());
			}
		}catch (Exception e) {
		
			e.printStackTrace();
		}
	}
	public static String scale(File f,String father)
    {
		String s="";
        if(f.isDirectory())
        {
        	String name = f.getName();
        	String path=f.getPath();
        	s=(m==0?"{\"name\":\""+name+"\",\"father\":\""+father+"\"}":",{\"name\":\""+name+"\",\"father\":\""+father+"\"}");
        	m=1;
            File[] fs = f.listFiles();
            if(fs == null)
            {
                System.out.println("NULL:" + f.getPath());
                return s;
            }
            for(int i = 0;i < fs.length;i++)
            {
                String c=scale(fs[i],f.getName());
                if(c.length()>0)s=s+c;
                
            }
        }
        return s;
    }
	public static String get(String s) {

		String value = s.replace(rpath, "");
		value = value.replace("\\", "/");
		value=Http.enc(value);
		return value;

	}
	
}
