package tea.ui.node.type.job;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;

public class EditEntSearch extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            tea.entity.node.EntSearch entsearch = tea.entity.node.EntSearch.find(teasession.getParameter("txtAgentName"), teasession._nLanguage);
            entsearch.setCctgr(teasession.getParameter("skr_cctgr_id")); //现职位级别
            entsearch.setSkrInd(Integer.parseInt(teasession.getParameter("skr_ind_id")));
            entsearch.setSkrOcc(teasession.getParameter("skr_occ_id"));
            //teasession.getParameter("skr_cctgr_id");//现地区
            entsearch.setSkrCity(teasession.getParameter("skr_loc_city_id")); //现地区
            entsearch.setIndustry(Integer.parseInt(teasession.getParameter("ExpectIndustry"))); //期望从事行业
            entsearch.setJobCategory(teasession.getParameter("ExpectJobCategory")); //期望从事职业
            entsearch.setTgtCity(teasession.getParameter("tgt_loc_city_id")); //期望地区
            entsearch.setSkrdeg(teasession.getParameter("skr_deg_id")); //学历
//            teasession.getParameter("degreeup"); //含更高学历
            entsearch.setMajorCategory(Integer.parseInt(teasession.getParameter("MajorCategory"))); //所学专业类别
//            teasession.getParameter("skr_wrk_year"); //工作经验
            teasession.getParameter("keyword"); //关键词
            entsearch.set();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/type/job/EditEntSearch.jsp");
    }

    //Clean up resources
    public void destroy()
    {
    }
}
