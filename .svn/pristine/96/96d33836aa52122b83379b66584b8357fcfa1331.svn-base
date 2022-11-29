package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.site.*;

public class EditDynamicType extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        try
        {
            String community = teasession._strCommunity;
            int dynamic = Integer.parseInt(teasession.getParameter("dynamic"));
            String act = teasession.getParameter("act");
            if("delete".equals(act))
            {
                int dynamictype = Integer.parseInt(teasession.getParameter("dynamictype"));
                DynamicType dt = DynamicType.find(dynamictype);
                dt.delete(teasession._nLanguage);
            } else if(teasession.getParameter("edit") != null)
            {
                String dynamictypes[] = teasession.getParameterValues("dynamictypes");
                if(dynamictypes != null)
                {
                    for(int i = 0;i < dynamictypes.length;i++)
                    {
                        int dynamictype = Integer.parseInt(dynamictypes[i]);
                        DynamicType dt = DynamicType.find(dynamictype);
                        String before = teasession.getParameter("before_" + dynamictype);
                        String after = teasession.getParameter("after_" + dynamictype);
                        String name = teasession.getParameter("name_" + dynamictype);
                        String content = teasession.getParameter("content_" + dynamictype);
                        dt.set(dt.getType(),dt.getSequence(),dt.isHidden(),dt.isNeed(),dt.isQrc(),dt.getDefaultvalue(),dt.getFilecenter(),dt.getBinding(),dt.isSync(),dt.isMulti(),dt.getWidth(),dt.getHeight(),dt.getFather(),dt.getQuantity(),dt.getColumns(),dt.getColumnAfter(),dt.isSeparate(),dt.isExport(),teasession._nLanguage,name,content,before,after);
                    }
                }
            } else
            {
                int dynamictype = Integer.parseInt(teasession.getParameter("dynamictype"));
                String name = teasession.getParameter("name");
                String content = teasession.getParameter("content");
                String type = teasession.getParameter("type");
                boolean isFile = type.equals("office") || type.equals("file") || type.equals("img") || type.equals("img");
                if(isFile)
                {
                    if(dynamictype > 0)
                    {
                        content = DynamicType.find(dynamictype).getContent(teasession._nLanguage);
                    }
                }
                int sequence = 0;
                try
                {
                    sequence = Integer.parseInt(teasession.getParameter("sequence"));
                } catch(NumberFormatException ex)
                {
                }
                String before = teasession.getParameter("before");
                String after = teasession.getParameter("after");
                boolean show = teasession.getParameter("show") != null;
                boolean need = teasession.getParameter("need") != null;
                boolean qrc = teasession.getParameter("qrc") != null;
                int binding = Integer.parseInt(teasession.getParameter("binding"));
                String bindfc = teasession.getParameter("bindfc");
                boolean sync = teasession.getParameter("sync") != null;
                boolean multi = teasession.getParameter("multi") != null;
                boolean dtfb = teasession.getParameter("dtfb") != null;
                boolean dtst = teasession.getParameter("dtst") != null;
                String width = teasession.getParameter("width");
                String height = teasession.getParameter("height");
                int folder = 0;
                String tmp = teasession.getParameter("folder");
                if(tmp != null)
                {
                    folder = Integer.parseInt(tmp);
                }
                int quantity = Integer.parseInt(teasession.getParameter("quantity"));
                int column = Integer.parseInt(teasession.getParameter("column"));
                String columnafter = teasession.getParameter("columnafter");
                boolean separate = teasession.getParameter("separate") != null;
                boolean export = teasession.getParameter("export") != null;
                int defaultvalue = 0;
                tmp = teasession.getParameter("defaultvalue");
                if(tmp != null)
                {
                    defaultvalue = Integer.parseInt(tmp);
                } else if(isFile)
                {
                    for(int i = 0;i < 50;i++)
                    {
                        String file = teasession.getParameter("file" + i);
                        if(file != null)
                        {
                            content += file + ":";
                        }
                    }
                    ServletContext application = getServletContext();
                    String filedel[] = teasession.getParameter("filedel").split(":");
                    for(int i = 1;i < filedel.length;i++)
                    {
                        File f = new File(application.getRealPath(filedel[i]));
                        f.delete();
                        content = content.replaceFirst(":" + filedel[i] + ":",":");
                    }
                    if(content != null && content.length() > 0 && content.charAt(0) != ':')
                    {
                        content = ":" + content;
                    }
                }
                int filecenter = 0;
                tmp = teasession.getParameter("filecenter");
                if(tmp.length() > 0)
                {
                    filecenter = Integer.parseInt(tmp);
                }
                if(dynamictype > 0)
                {
                    DynamicType dt = DynamicType.find(dynamictype);
                    dt.set(type,sequence,show,need,qrc,defaultvalue,filecenter,binding,sync,multi,width,height,folder,quantity,column,columnafter,separate,export,teasession._nLanguage,name,content,before,after);
                } else
                {
                    dynamictype = DynamicType.create(dynamic,type,sequence,show,need,qrc,defaultvalue,filecenter,binding,sync,multi,width,height,folder,quantity,column,columnafter,separate,export,teasession._nLanguage,name,content,before,after);
                }
                //
                Dynamic d = Dynamic.find(dynamic);
//        int fb = d.getDtfb();
//        if (dynamictype == fb)
//        {
//          fb = 0;
//        }
//        dtfb ? dynamictype : fb
                int st = d.getDtst();
                if(dynamictype == st)
                {
                    st = 0;
                }
                d.setDtst(dtst ? dynamictype : st);
                if(bindfc.length() > 0)
                {
                    d.setBindfc(bindfc,dynamictype);
                }
            }
            response.sendRedirect("/jsp/community/DynamicTypes.jsp?dynamictype=0&dynamic=" + dynamic + "&community=" + community + "&nexturl=" + java.net.URLEncoder.encode(teasession.getParameter("nexturl"),"UTF-8"));
        } catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
