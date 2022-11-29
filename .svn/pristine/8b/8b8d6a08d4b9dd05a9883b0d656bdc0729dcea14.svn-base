package tea.ui.node.type.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.node.Node;
import tea.entity.node.Report;
import tea.entity.node.Media;
import tea.db.*;
import tea.htmlx.TimeSelection;

public class ImportReport extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            byte bycontent[] = teasession.getBytesParameter("content");
            java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(new String(bycontent), "\u00FF");
            while (tokenizer.hasMoreTokens())
            {
                String subcontent = tokenizer.nextToken();
                java.util.StringTokenizer subtokenizer = new java.util.StringTokenizer(subcontent, "\r\n");
                String subject = subtokenizer.nextToken();
                String mediaName = subtokenizer.nextToken();
                String date = subtokenizer.nextToken();

                int index = date.indexOf("年");
                String year = date.substring(0, index);

                int index2 = date.indexOf("月", index);
                String month;
                if (index2 != -1)
                {
                    month = date.substring(index + 1, index2);
                } else
                {
                    month = "1";
                }

                int index3 = date.indexOf("日", index2);
                String day;
                if (index3 != -1)
                {
                    day = date.substring(index2 + 1, index3);
                } else
                {
                    day = "1";
                }

             //   importdb(teasession, subcontent, subject, mediaName.substring(mediaName.indexOf("《") + 1, mediaName.indexOf("》")), TimeSelection.makeTime(year, month, day));

            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
/*
    public void importdb(tea.ui.TeaSession teasession, String content, String subject, String mediaName, java.util.Date date)
    {
        try
        {
            tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
            //节点号，顺序,社区,类型,类型别名,  ,选项,  ,默认语言,开始日期,结束日期,主题,关键字,内容,图片,Alt,排列Align,声音,ClickUrl,SrcUrl,SrcUrlx,FileName,文件,发布日期
            int newnode = Node.create(teasession._nNode, 0, node.getCommunity(), teasession._rv, 39, 0, false, 1339853504, 0, 1, null, null, teasession._nLanguage, subject, null, content,
                                      null, "", 1, null, "", "", "", subject + ".txt", content.getBytes(), new java.util.Date(), 0, 0, 0, 0, "", "");

            tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
            dbadapter.executeQuery("SELECT media_id,mname FROM media where language=" + teasession._nLanguage);
            int mediaId = 0;
            while (dbadapter.next())
            {
                if (dbadapter.getVarchar(teasession._nLanguage, 1, 2).equals(mediaName))
                {
                    mediaId = dbadapter.getInt(1);
                    break;
                }
            }
            if (mediaId == 0)
            {
                Media media = new Media();
                media.set(mediaId, mediaName, null, teasession.getParameter("ClearPicture") != null, teasession._nLanguage);
                mediaId = dbadapter.getInt("SELECT MAX(media_id) FROM media where language=" + teasession._nLanguage);
            }
            dbadapter.close();
            Report.create(newnode, teasession._nLanguage, mediaId, 0, "", "", "", "", "", date);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }
*/
    //Clean up resources
    public void destroy()
    {
    }
}
