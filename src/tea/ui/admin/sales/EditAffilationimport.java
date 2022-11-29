package tea.ui.admin.sales;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.admin.sales.*;
import tea.db.*;

public class EditAffilationimport extends TeaServlet
{

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		tea.ui.TeaSession teasession = null;
		teasession = new tea.ui.TeaSession(request);
		try
		{

			String act = request.getParameter("act");
			if ("import".equals(act))
			{

				int _nMember = Integer.parseInt(teasession.getParameter("member"));
				int _Nname = Integer.parseInt(teasession.getParameter("name"));
				int _nTel = Integer.parseInt(teasession.getParameter("tel"));
				int _nMobile = Integer.parseInt(teasession.getParameter("mobile"));

				int _nEmail = Integer.parseInt(teasession.getParameter("email"));
				int _nClient= Integer.parseInt(teasession.getParameter("client"));

				
				int _nClienttype =1;// Integer.parseInt(teasession.getParameter("clienttype"));
				int _nSupervisor = Integer.parseInt(teasession.getParameter("supervisor"));

				int _nJob = Integer.parseInt(teasession.getParameter("job"));
				int _nCountry = Integer.parseInt(teasession.getParameter("country"));

				int _nPostcode = Integer.parseInt(teasession.getParameter("postcode"));
				int _nState = Integer.parseInt(teasession.getParameter("state"));

				int _nCity = Integer.parseInt(teasession.getParameter("city"));
				int _nStreet = Integer.parseInt(teasession.getParameter("street"));

				int _nCountry2 = Integer.parseInt(teasession.getParameter("country2"));
				int _nPostcode2 = Integer.parseInt(teasession.getParameter("postcode2"));

				int _nState2 = Integer.parseInt(teasession.getParameter("state2"));
				int _nCity2 = Integer.parseInt(teasession.getParameter("city2"));

				 int _nStreet2 = Integer.parseInt(teasession.getParameter("street2"));
				 int _nFax = Integer.parseInt(teasession.getParameter("fax"));

				 int _nOrigin = Integer.parseInt(teasession.getParameter("origin"));
				 int _nHometel = Integer.parseInt(teasession.getParameter("hometel"));

				 int _nBirth = Integer.parseInt(teasession.getParameter("birth"));
				 int _nOthertel = Integer.parseInt(teasession.getParameter("othertel"));

				 int _nUnit = Integer.parseInt(teasession.getParameter("unit"));
				 int _nAssistant = Integer.parseInt(teasession.getParameter("assistant"));

				 int _nAssistanttel = Integer.parseInt(teasession.getParameter("assistanttel"));
				 int _nContent = Integer.parseInt(teasession.getParameter("content"));

				String identity = teasession.getParameter("identity");
				int laid = 0;
				String file = teasession.getParameter("file");
				String rows[] = file.split("\n");
				for (int i = 1; i < rows.length; i++)
				{
					String cols[] = rows[i].replaceAll(",,", " , ,").split(",");
					// String name = null;
					// if(_nName !=-1)
					// {
					// name = cols[_nName];
					// }
					// String tel=null;
					// if(_nTel !=-1)
					// {
					// tel = cols[_nTel];
					// }

					String member = teasession._rv.toString();
					if (_nMember != -1)
					{
						member = cols[_nMember];
					}
					String name = null;
					if (_Nname != -1)
					{
						name = cols[_Nname];
					}
					String tel = null;
					if (_nTel != -1)
					{
						tel = cols[_nTel];
					}
					String mobile = null;
					if (_nMobile != -1)
					{
						mobile = cols[_nMobile];
					}
					String email = null;
					if (_nEmail != -1)
					{
						email = cols[_nEmail];
					}
					int client =0;
					if (_nClient != -1)
					{
						try{
						client = Integer.parseInt(cols[_nClient]);
						}catch(Exception ex){}
					}
					int grade = 0;

					boolean clienttype =false;
					//if (_nClienttype != -1)
					//{
						//clienttype = //"true".equals(cols[_nClienttype]);
					//}
					int supervisor = 0;
					if (_nCountry != -1)
					{
						try{
						supervisor = Integer.parseInt(cols[_nCountry]);
						}catch(Exception ex){}
					}
					
					String job = null;
					if (_nJob != -1)
					{
						job = cols[_nJob];
					}

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
					String country2 = null;
					if(_nCountry2 !=-1)
					{
						country2 = cols[_nCountry2];
					}

					String postcode2 = null;
					if (_nPostcode2 != -1)
					{

							postcode2 = cols[_nPostcode2];

					}
					String state2 =null;
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

					String fax = null;
					if (_nFax != -1)
					{
						fax = cols[_nFax];
					}

					int origin = 0;
					//if (_nOrigin != -1)
					//{
						//origin = cols[_nOrigin];
					//}

					String hometel = null;
					if (_nHometel != -1)
					{
						hometel = cols[_nHometel];
					}

					Date birth = null;
					if (_nBirth != -1)
					{
						birth = SalesLinkman.sdf.parse(cols[_nBirth]);
					}
					String othertel = null;
					if (_nOthertel != -1)
					{
						othertel = cols[_nOthertel];
					}
					String unit = null;
					if (_nUnit != -1)
					{
						unit = cols[_nUnit];
					}
					String assistant = null;
					if (_nAssistant != -1)
					{
						assistant = cols[_nAssistant];
					}

					String assistanttel = null;
					if (_nAssistanttel != -1)
					{
						assistanttel = cols[_nAssistanttel];
					}

					String content = null;
					if (_nContent != -1)
					{
						content = cols[_nContent];
					}

					if ("name".equals(identity))
					{
						laid = SalesLinkman.findByName(member);
					} else
					{
						laid = SalesLinkman.findByTel(tel);
					}
					String holder = null;
					if (laid < 1)
					{
						SalesLinkman.create(teasession._strCommunity, member, name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street, country2, postcode2, state2, city2, street2, fax, origin, hometel, birth, othertel, unit, assistant, assistanttel, content);

					} else
					{
						SalesLinkman saobj = SalesLinkman.find(laid);
						saobj.set(name, tel, mobile, email, client, clienttype, supervisor, job, country, postcode, state, city, street, country2, postcode2, state2, city2, street2, fax, origin, hometel, birth, othertel, unit, assistant, assistanttel, content);
					}
				}
				response.sendRedirect("/jsp/info/Succeed.jsp?community=" + teasession._strCommunity);
			}

		} catch (Exception ex)
		{
			ex.printStackTrace();

		}

	}

	// Clean up resources
	public void destroy()
	{
	}
}
