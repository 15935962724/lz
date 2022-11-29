package tea.ui;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.entity.*;
import tea.entity.yl.shop.OperationMes;

import java.sql.SQLException;

public class Filter extends HttpServlet implements javax.servlet.Filter
{
    private FilterConfig filterConfig;
    public void init(FilterConfig filterConfig) throws ServletException
    {
        this.filterConfig = filterConfig;
    }

    public void doFilter(ServletRequest request,ServletResponse response,FilterChain filterChain) throws IOException,ServletException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String par = getAllPar(request);
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        if(MT.f(req.getParameter("act")).equals("")){
            filterChain.doFilter(request, response);
            return;
        }
        try
        {
            //System.out.println(req.getMethod()+"==="+getPostData(req));
            Http h = new Http(req,res);
            String url = ((HttpServletRequest) request).getRequestURL()+"";
            String act = h.get("act");
            int member = h.member;


            OperationMes om = OperationMes.find(0);
            om.setAct(act);
            om.setMember(member);
            om.setTime(new Date());
            om.setPar(par);
            om.setRequesturl(url);
            if(MT.f(par).length()>0){
                om.set();
            }

        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
            //filterChain.doFilter(req, res);
            filterChain.doFilter(request,response);
    }
    /**
     * 获取参数
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    public String getAllPar(ServletRequest request) throws UnsupportedEncodingException{
        Map<String, String[]> parameterMap=request.getParameterMap();
        String parameterStr="";
        //之后，所有变长参数都在这个名为parameterMap的Map里面了。
        //只需要遍历一下这个Map就可以了。
        for(String key : parameterMap.keySet()){
            //parameterStr+=key+"="+URLEncoder.encode(parameterMap.get(key)[0],"UTF-8")+"&";
            parameterStr+=key+"="+ URLEncoder.encode(request.getParameter(key),"UTF-8")+"&";
        }
        return parameterStr;
    }





}
