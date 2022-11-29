package tea.ui.admin.sales;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import tea.entity.admin.Workproject;
import tea.ui.*;

public class SalesImport extends HttpServlet
{

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);
		if (teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		String act = teasession.getParameter("act");
		try
		{
			// /////////////////导入客户///////////////////////////////////////////
			if ("importworkproject".equals(act))
			{
				int _nMember = Integer.parseInt(teasession.getParameter("member"));
				int _nTel = Integer.parseInt(teasession.getParameter("tel"));
				int _nFax = Integer.parseInt(teasession.getParameter("fax"));
				int _nUrl = Integer.parseInt(teasession.getParameter("url"));
				int _nEmail = Integer.parseInt(teasession.getParameter("email"));
				int _nName = Integer.parseInt(teasession.getParameter("name"));
				int _nContent = Integer.parseInt(teasession.getParameter("content"));
				int _nType = Integer.parseInt(teasession.getParameter("type"));
				int _nEmployee = Integer.parseInt(teasession.getParameter("employee"));
				int _nCalling = Integer.parseInt(teasession.getParameter("calling"));
				int _nEarning = Integer.parseInt(teasession.getParameter("earning"));
				int _nCountry = Integer.parseInt(teasession.getParameter("country"));
				int _nCountry2 = Integer.parseInt(teasession.getParameter("country2"));
				int _nPostcode = Integer.parseInt(teasession.getParameter("postcode"));
				int _nPostcode2 = Integer.parseInt(teasession.getParameter("postcode2"));
				int _nState = Integer.parseInt(teasession.getParameter("state"));
				int _nState2 = Integer.parseInt(teasession.getParameter("state2"));
				int _nCity = Integer.parseInt(teasession.getParameter("city"));
				int _nCity2 = Integer.parseInt(teasession.getParameter("city2"));
				int _nStreet = Integer.parseInt(teasession.getParameter("street"));
				int _nStreet2 = Integer.parseInt(teasession.getParameter("street2"));
				String identity = teasession.getParameter("identity");
				int workproject = 0;
				int itemgenre = Integer.parseInt("itemgenre");// 070916——项目类型
				String file = teasession.getParameter("file");
				String rows[] = file.split("\n");
				for (int i = 1; i < rows.length; i++)
				{
					String cols[] = rows[i].replaceAll(",,", " , ,").split(",");
					System.out.println(rows[i]);
					String member = teasession._rv.toString();
					if (_nMember != -1)
					{
						member = cols[_nMember];
					}
					String tel = null;
					if (_nTel != -1)
					{
						tel = cols[_nTel];
					}
					String fax = null;
					if (_nFax != -1)
					{
						fax = cols[_nFax];
					}
					String url = null;
					if (_nUrl != -1)
					{
						url = cols[_nUrl];
					}
					String email = null;
					if (_nEmail != -1)
					{
						email = cols[_nEmail];
					}
					String name = null;
					if (_nName != -1)
					{
						name = cols[_nName];
					}
					String content = null;
					if (_nContent != -1)
					{
						content = cols[_nContent];
					}
					int type = 0;
					int employee = 0;
					int calling = 0;
					String earning = null;
					if (_nEarning != -1)
					{
						earning = cols[_nEarning];
					}
					// /////////开单地址
					String country = null;
					if (_nCountry != -1)
					{
						country = cols[_nCountry];
					}
					String postcode = null;
					if (_nPostcode != -1)
					{
						postcode = cols[_nPostcode];
					}
					String state = null;
					if (_nState != -1)
					{
						state = cols[_nState];
					}
					String city = null;
					if (_nCity != -1)
					{
						city = cols[_nCity];
					}
					String street = null;
					if (_nStreet != -1)
					{
						street = cols[_nStreet];
					}
					// /////////发货地址
					String country2 = null;
					if (_nCountry2 != -1)
					{
						country2 = cols[_nCountry2];
					}
					String postcode2 = null;
					if (_nPostcode2 != -1)
					{
						postcode2 = cols[_nPostcode2];
					}
					String state2 = null;
					if (_nState2 != -1)
					{
						state2 = cols[_nState2];
					}
					String city2 = null;
					if (_nCity2 != -1)
					{
						city2 = cols[_nCity2];
					}
					String street2 = null;
					if (_nStreet2 != -1)
					{
						street2 = cols[_nStreet2];
					}
					if ("name".equals(identity))
					{
						workproject = Workproject.findByName(name);
					} else
					{
						workproject = Workproject.findByTel(tel);
					}
					if (workproject < 1)
					{
						Workproject.create(teasession._strCommunity, member, tel, fax, url, email, name, content, type, employee, calling, earning, country, postcode, state, city, street, country2, postcode2, state2, city2, street2);
					} else
					{
						Workproject obj = Workproject.find(workproject);
						obj.set(tel, fax, url, email, name, content, type, employee, calling, earning, country, postcode, state, city, street, country2, postcode2, state2, city2, street2);
					}
				}
			}
			response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity);
		} catch (Exception ex)
		{
			ex.printStackTrace();
			throw new ServletException(ex.getMessage());
		}
	}
}
