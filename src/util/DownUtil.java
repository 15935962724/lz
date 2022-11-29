package util;

import tea.entity.Filex;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class DownUtil {
	public static void downLoadFromUrl(String urlStr, String fileName, HttpServletResponse response, HttpServletRequest request) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
        conn.setRequestProperty("referer", "https://cpc.cat.com");
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Maxthon;)");
        conn.setRequestProperty("Accept-Encoding", "gzip");
        conn.setRequestProperty("cookie", "https://cpc.cat.com");
        conn.setRequestProperty("Host", "cpc.cat.com");
        //设置超时间为3秒
        //conn.setConnectTimeout(3*1000);
        //防止屏蔽程序抓取而返回403错误
        //conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

        //得到输入流
        //InputStream inputStream = conn.getInputStream();
        
        
        BufferedInputStream inpputStream=new BufferedInputStream(conn.getInputStream());
        BufferedOutputStream outputStream=new BufferedOutputStream(response.getOutputStream());

        try {
            //缓冲文件输出流
            
            
            //通知浏览器以附件形式下载
            // response.setHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileName,"UTF-8"));
            // 为防止 文件名出现乱码
        	String contentType = "application/octet-stream";
            response.setContentType(contentType);
            response.setHeader("Set-Cookie","cookiename=cookievalue; path=/; Domain=domainvaule; Max- age=seconds; HttpOnly");
            /*byte[] car = new byte[1024];
            
            int L;

            while(-1 != (L = inpputStream.read(car, 0,car.length))){
                    outputStream.write(car, 0,L);
            }
            response.flushBuffer();*/
           /* if(outputStream!=null){
                outputStream.flush();
                outputStream.close();
            }*/
            
            Filex.piped(inpputStream, outputStream);


        } catch (IOException e) {
            e.printStackTrace();
            Filex.logs("DownUtil.txt","==="+e+"行"+e.getStackTrace()[0].getLineNumber());

        }
        finally {
            if(inpputStream!=null){
                inpputStream.close();
            }
            if(outputStream!=null){
                outputStream.close();
            }
        }
    }

    public static void downLoadFromUrl(String urlStr) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
        conn.setRequestProperty("referer", "https://cpc.cat.com");
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Maxthon;)");
        conn.setRequestProperty("Accept-Encoding", "gzip");
        conn.setRequestProperty("cookie", "https://cpc.cat.com");
        conn.setRequestProperty("Host", "cpc.cat.com");

        BufferedInputStream inpputStream=new BufferedInputStream(conn.getInputStream());
        System.out.println("-------");
        try {
            //缓冲文件输出流




            //通知浏览器以附件形式下载
            // response.setHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileName,"UTF-8"));
            // 为防止 文件名出现乱码
            String contentType = "application/octet-stream";
            /*byte[] car = new byte[1024];

            int L;

            while(-1 != (L = inpputStream.read(car, 0,car.length))){
                    outputStream.write(car, 0,L);
            }
            response.flushBuffer();*/
           /* if(outputStream!=null){
                outputStream.flush();
                outputStream.close();
            }*/



        } catch (Throwable e) {
            e.printStackTrace();
            Filex.logs("DownUtil.txt","==="+e+"行"+e.getStackTrace()[0].getLineNumber());

        }
        finally {
        }

    }

    public static void main(String[] args) {
	    try{
            downLoadFromUrl("https://cpc.cat.com/ws/xml/J540/405tree_zh.xml");
            System.out.println("===");
        }catch (Throwable e){
System.out.println(e.toString()+"===");
        }
    }
}
