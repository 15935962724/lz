package tea;

import java.net.*;
import java.io.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class CheckURL {

	 /**
	 *
	 * @param urlvalue
	 *
	 * @return 获取url内容
	 */

  public static String check(String urlvalue ) {


	  String inputLine="";
	  String line2 = "";

		try{
				URL url = new URL(urlvalue);

				HttpURLConnection urlConnection  = (HttpURLConnection)url.openConnection();

				BufferedReader in  = new BufferedReader(
						new InputStreamReader(
								urlConnection.getInputStream()));
				int i = 1;
				while ((line2 = in.readLine()) != null) {
				inputLine+=line2;
				//System.out.println(i);
			//	i++;
				}

    Pattern P_NEW = Pattern.compile("<!-- 正文块 begin -->([^我要评论</a>]*)"); // 匹配<title>开头，</title>结尾 --截取网页重要部分内容块
    Pattern P_subject = Pattern.compile("<h1 id=\"artibodyTitle\" pid=\"31\" tid=\"1\" did=\"6472135\" fid=\"1554\">([^<]+)</h1>"); // 主题
    Pattern P_content = Pattern.compile("<!-- publish_helper name='原始正文' p_id='31' t_id='1' d_id='6472135' f_id='45' -->(.+)</p> <div class="); //内容

				String news = inputLine;
				Matcher m_new = P_NEW.matcher(news);
                while(m_new.find())
                {
                    String subject = "",content = "";
                    Matcher m_c = P_subject.matcher(news); //主题
                    if(m_c.find())
                    {
                        subject = m_c.group(1).trim();
                    }
					m_c = P_content.matcher(news);
					if(m_c.find())
					{
						content =m_c.group(1).trim();
					}
                    System.out.println(i + ":" + subject);
					System.out.println(content);
                    i++;

                }


		}
				catch(Exception e){
					e.printStackTrace();
				}
			//System.out.println(inputLine);  系统打印出抓取得验证结果

		return inputLine;
  }

 /* public static void main(String a[]){
	System.out.println(CheckURL.check("http://www.163.com"));
  }*/


  }


