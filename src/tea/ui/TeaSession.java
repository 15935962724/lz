package tea.ui;

import java.io.*;
import javax.servlet.http.*;
import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.http.MultipartRequest;
import tea.entity.member.*;
import tea.service.*;

public class TeaSession extends MultipartRequest
{
    HttpSession session;
    public int _nLanguage;
    public int _nNode = 0;
    public int _nStatus = 0;
    public String _strCommunity;
    public RV _rv = null;

    public TeaSession(HttpServletRequest request) throws IOException
    {
        super(request);
        session = request.getSession(true);
        try
        {
            String tmp = getParameter("node");
            if(tmp == null)
            {
                tmp = getParameter("Node");
            }
            if(tmp != null)
            {
                _nNode = Integer.parseInt(tmp);
            } else
            {
                Object obj = session.getAttribute("tea.Node");
                if(obj != null)
                {
                    _nNode = ((Integer) obj).intValue();
                }
            }
            // ////////////
            String jsessionid = getParameter("jsessionid");
            if(jsessionid != null)
            {
                OnlineList ol = OnlineList.find(jsessionid);
                String m = ol.getMember();
                if(m != null)
                {
                    _rv = new RV(m);
                    session.setAttribute("tea.RV",_rv);
                }
            } else
            {
                Http h = new Http(request);
                if(h.member > 0)
                {
                    _rv = new RV(Profile.find(h.member).getMember());
                }
            }
            // 状态//////////////////
            tmp = getParameter("status");
            if(tmp == null)
                tmp = (String) request.getAttribute("status");
            if(tmp == null)
                tmp = getCook("status","0");
            _nStatus = Byte.parseByte(tmp);
            // 语言//////////////////
            tmp = getParameter("language");
            if(tmp == null)
                tmp = getCook("language","1");
            _nLanguage = Byte.parseByte(tmp);

            // 社区////////////////////
            _strCommunity = getParameter("community");
            if(_strCommunity == null)
                _strCommunity = getCook("community",null);
        } catch(NumberFormatException ex)
        {
            throw ex;
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public String getCook(String name,String dv)
    {
        Cookie cs[] = _req.getCookies();
        if(cs != null)
            for(int i = 0;i < cs.length;i++)
            {
                if(name.equals(cs[i].getName()))
                    return cs[i].getValue();
            }
        return dv;
    }

    public String isNULL(String name)
    {
        if(name != null && name.length() > 0)
        {
            return name;
        } else
        {
            return "";
        }
    }

    public HttpSession getSession()
    {
        return session;
    }
}
