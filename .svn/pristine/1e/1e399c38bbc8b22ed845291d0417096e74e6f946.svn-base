package tea.ui.contract;

import tea.entity.contract.Contract;
import tea.ui.TeaServlet;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;


public class ContractServlet extends TeaServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8"); /**设置编码格式*/
        TeaSession teasession = new TeaSession(request);
        String community = teasession.getParameter("community");
        try
        {
            /**从页面取到del参数如果 它不为空的话 则进行删除操作*/
            if (teasession.getParameter("del") != null && teasession.getParameter("del").length() > 0)
            {

                String id = teasession.getParameter("del");

                Contract.del(id);
                response.sendRedirect("/jsp/contract/conlist.jsp"); /**跳转到列表页面*/
                return; /**不再继续往下执行*/

            } else
            {
                String conid = null;
                float money = 0;
                float prepay = 0;
                String e_contract = null;
                if (teasession.getParameter("conid") != null && !teasession.getParameter("conid").equals(""))
                {
                    conid = teasession.getParameter("conid");

                }

                /**如果用户ID有重复的且前台传来的参娄为insert 则提示用户已存在 退出*/
                if (Contract.findSame(conid) != 0 && teasession.getParameter("id").equals("insert"))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("该合同已存在!", "utf-8"));
                    return;
                }

                String cname = teasession.getParameter("cname");
                String member = teasession.getParameter("member");
                String time = teasession.getParameter("time");
                String outtime = teasession.getParameter("outtime");
                String type = teasession.getParameter("type");

                if (teasession.getParameter("money") != null && !teasession.getParameter("money").equals(""))
                {
                    money = Float.parseFloat(teasession.getParameter("money"));
                }
                if (teasession.getParameter("prepay") != null && !teasession.getParameter("prepay").equals(""))
                {
                    prepay = Float.parseFloat(teasession.getParameter("prepay"));
                }
                //上面是取得页面参数
                Contract cobj = Contract.find(conid, member);
                byte by[] = teasession.getBytesParameter("e_contract");
                if (teasession.getParameter("check1") != null)
                {
                    e_contract = "";
                } else if (by != null)
                {
                    e_contract = write(teasession._strCommunity, "contract", by, ".doc");
                } else
                {
                    e_contract = cobj.getE_contract();
                }

                /**如果用户ID已存在 但没有得到前台传来的 insert 参数 则进行修改*/
//           if(cobj.getConid()!=null)
//           {
//             cobj.set(conid,cname,money,time,outtime,member,e_contract,community,prepay,type);
//               response.sendRedirect("/jsp/contract/conlist.jsp");
//               return ;
//           }

                Contract.create(conid, cname, money, time, outtime, member, e_contract, community, prepay, type);
                response.sendRedirect("/jsp/contract/conlist.jsp");
                return;
            }

        } catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }
}
