
package tea.entity.csvclub.alipay;
import java.net.*;
import java.io.*;


public class CheckURL {
	   /**
     * ���ַ����MD5����
	 * @param myUrl
     *
     * @param url
     *
     * @return ��ȡurl����
     */
  public static String check(String urlvalue ) {


	  String inputLine="";

		try{
				URL url = new URL(urlvalue);

				HttpURLConnection urlConnection  = (HttpURLConnection)url.openConnection();

				BufferedReader in  = new BufferedReader(
			            new InputStreamReader(
			            		urlConnection.getInputStream()));

				inputLine = in.readLine().toString();
			}catch(Exception e){
				e.printStackTrace();
			}
			//System.out.println(inputLine);  ϵͳ��ӡ��ץȡ����֤���

	    return inputLine;
  }


  }
