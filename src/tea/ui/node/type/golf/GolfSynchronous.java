package tea.ui.node.type.golf;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.*;
import tea.entity.node.Score;
import tea.ui.TeaServlet;

//http://127.0.0.1:8080/servlet/GolfSynchronous?type=golfScore&xmlpassword=123456&xmlcontent=111
public class GolfSynchronous extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=GBK");
        java.io.PrintWriter out = response.getWriter();
        try
        {
            String xmlpassword = request.getParameter("xmlpassword");
            if(!"123456".equals(xmlpassword))
            {
                out.print("false您的密码不正确，请确认密码!");
                return;
            }
            String xmlcontent = request.getParameter("xmlcontent");
            if(xmlcontent == null || xmlcontent.length() < 1)
            {
                out.print("false无效内容!");
                return;
            }
            xmlcontent = new String(xmlcontent.getBytes("ISO-8859-1"),"GBK");
            String xmltype = request.getParameter("type");
            System.out.println("====" + xmltype + "=========================");
            System.out.println(xmlcontent);
            if("test".equals(xmltype)) //http://127.0.0.1:8080/servlet/GolfSynchronous?xmlpassword=123456&xmlcontent=11&type=test
            {
                String str = "<?xml version=\"1.0\" encoding=\"GBK\"?><golfScore><inMode>VIPID</inMode><VIPID>01023572</VIPID><caddyID>0102</caddyID><fieldID>A</fieldID><tee>蓝</tee><posID>S13002080912180010</posID><dateTime>20100521165126</dateTime><event>N</event><eventID>a</eventID><H1Way>Y</H1Way><H1On>2</H1On><H1Push>2</H1Push><H2Way>Y</H2Way><H2On>3</H2On><H2Push>1</H2Push><H3Way>N</H3Way><H3On>2</H3On><H3Push>2</H3Push><H4Way>Y</H4Way><H4On>2</H4On><H4Push>2</H4Push><H5Way>Y</H5Way><H5On>3</H5On><H5Push>2</H5Push><H6Way>N</H6Way><H6On>2</H6On><H6Push>2</H6Push><H7Way>Y</H7Way><H7On>2</H7On><H7Push>1</H7Push><H8Way>Y</H8Way><H8On>2</H8On><H8Push>2</H8Push><H9Way>Y</H9Way><H9On>3</H9On><H9Push>2</H9Push><H10Way>Y</H10Way><H10On>3</H10On><H10Push>3</H10Push><H11Way>Y</H11Way><H11On>2</H11On><H11Push>2</H11Push><H12Way>Y</H12Way><H12On>3</H12On><H12Push>2</H12Push><H13Way>Y</H13Way><H13On>3</H13On><H13Push>2</H13Push><H14Way>Y</H14Way><H14On>3</H14On><H14Push>1</H14Push><H15Way>Y</H15Way><H15On>2</H15On><H15Push>1</H15Push><H16Way>Y</H16Way><H16On>3</H16On><H16Push>2</H16Push><H17Way>Y</H17Way><H17On>3</H17On><H17Push>2</H17Push><H18Way>Y</H18Way><H18On>2</H18On><H18Push>1</H18Push></golfScore>"
                             ;
                out.print("<form name='form1' action='?' method='post'>");
                out.print("<input name='xmlpassword' type='hidden' value='123456' />");
                out.print("<table>");
                out.print("<tr><td>类型:</td><td><select name='type'><option value='golfScore'>录入成绩</option><option value='scoreSelect'>成绩查询</option><option value='fieldSelect'>差点查询</option></select></td></tr>");
                out.print("<tr><td>内容:</td><td><textarea name='xmlcontent' cols='80' rows='15'>" + str + "</textarea></td></tr>");
                out.print("<tr><td>&nbsp;</td><td><input type='submit' value='提交' /></td></tr></table></form>");
                out.print("<?xml version=\"1.0\" encoding=\"GBK\" ?><scoreSelect><selectMode>VIPID</selectMode><VIPID>webmaster</VIPID></scoreSelect>".replaceAll("<","&lt;"));
            } else
            if("scoreSelect".equals(xmltype)) //成绩查询
            {
                out.print(Score.exp(xmlcontent));
            } else if("golfScore".equals(xmltype)) //成绩录入
            {
            	
                //保存xml文件!
                String f = getServletContext().getRealPath("/res/Home/imp/" + Entity.sdf3.format(new Date()).replace(':','_') + "_" + xmlcontent.hashCode() + ".xml");
                Filex.write(f,xmlcontent);
                out.print(Score.imp(xmlcontent)); //录入
                //out.print(Score.exp(xmlcontent));//返回
            } else if("fieldSelect".equals(xmltype)) //差点查询
            {

                out.print(Score.fieldid_exp(xmlcontent)); //球场差点
            } else if("MobilegolfScore".equals(xmltype))
            {
            	//手机客户端中的成绩录入
            }
            else
            {
                out.print("false无效类型!");
            }
            
            
        } catch(Exception ex)
        {
            out.print("false出现错误:" + ex.getMessage());
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
