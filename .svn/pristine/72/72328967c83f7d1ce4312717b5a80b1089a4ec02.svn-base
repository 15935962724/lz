package tea.ui.node.type.friend;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Friend;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditFriend extends TeaServlet
{

	public EditFriend()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		try
		{
			TeaSession teasession = new TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}

			Node node = Node.find(teasession._nNode);
			Friend friend = Friend.find(teasession._nNode);
			if (request.getMethod().equals("GET"))
			{
				response.sendRedirect("/jsp/type/friend/EditFriend.jsp?" + request.getQueryString());

				// Form form = new Form("foEdit", "POST", "/servlet/EditFriend");
				// form.setOnSubmit("return(submitInteger(this.Age, '" + super.r.getString(teasession._nLanguage, "InvalidAge") + "')" + "&&submitInteger(this.Height, '" + super.r.getString(teasession._nLanguage, "InvalidHeight") + "')" + ");");
				// form.add(new HiddenField("Node", teasession._nNode));
				// Table table = new Table();
				// Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Gender") + ":"), true));
				// DropDown dropdown = new DropDown("Gender", friend.getGender());
				// for (int j1 = 0; j1 < Friend.FRIEND_GENDER.length; j1++)
				// {
				// dropdown.addOption(j1, super.r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[j1]));
				// }
				//
				// row.add(new Cell(dropdown));
				// table.add(row);
				// Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "PrefGender") + ":"), true));
				// DropDown dropdown1 = new DropDown("PrefGender", friend.getPrefGender());
				// for (int i2 = 0; i2 < Friend.FRIEND_GENDER.length; i2++)
				// {
				// dropdown1.addOption(i2, super.r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[i2]));
				// }
				//
				// row1.add(new Cell(dropdown1));
				// table.add(row1);
				// Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Relationship") + ":"), true));
				// Cell cell = new Cell();
				// for (int l2 = 0; l2 < Friend.FRIEND_RELATIONSHIP.length; l2++)
				// {
				// cell.add(new CheckBox(Friend.FRIEND_RELATIONSHIP[l2], (friend.getRelationship() & 1 << l2) != 0));
				// cell.add(new Text(super.r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[l2])));
				// }
				//
				// row2.add(cell);
				// table.add(row2);
				// Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Ethnicity") + ":"), true));
				// DropDown dropdown2 = new DropDown("Ethnicity", friend.getEthnicity());
				// for (int l3 = 0; l3 < Friend.FRIEND_ETHNICITY.length; l3++)
				// {
				// dropdown2.addOption(l3, super.r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[l3]));
				// }
				//
				// row3.add(new Cell(dropdown2));
				// table.add(row3);
				// Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Education") + ":"), true));
				// DropDown dropdown3 = new DropDown("Education", friend.getEducation());
				// for (int k4 = 0; k4 < Friend.FRIEND_EDUCATION.length; k4++)
				// {
				// dropdown3.addOption(k4, super.r.getString(teasession._nLanguage, Friend.FRIEND_EDUCATION[k4]));
				// }
				//
				// row4.add(new Cell(dropdown3));
				// table.add(row4);
				// Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Employment") + ":"), true));
				// DropDown dropdown4 = new DropDown("Employment", friend.getEmployment());
				// for (int j5 = 0; j5 < Friend.FRIEND_EMPLOYMENT.length; j5++)
				// {
				// dropdown4.addOption(j5, super.r.getString(teasession._nLanguage, Friend.FRIEND_EMPLOYMENT[j5]));
				// }
				//
				// row5.add(new Cell(dropdown4));
				// table.add(row5);
				// Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Religion") + ":"), true));
				// DropDown dropdown5 = new DropDown("Religion", friend.getReligion());
				// for (int k5 = 0; k5 < Friend.FRIEND_RELIGION.length; k5++)
				// {
				// dropdown5.addOption(k5, super.r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[k5]));
				// }
				//
				// row6.add(new Cell(dropdown5));
				// table.add(row6);
				// Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Hobbies") + ":"), true));
				// Cell cell1 = new Cell();
				// for (int l5 = 0; l5 < Friend.FRIEND_HOBBIES.length; l5++)
				// {
				// cell1.add(new CheckBox(Friend.FRIEND_HOBBIES[l5], (friend.getHobbies() & 1 << l5) != 0));
				// cell1.add(new Text(super.r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[l5])));
				// }
				//
				// row7.add(cell1);
				// table.add(row7);
				// Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "BodyType") + ":"), true));
				// DropDown dropdown6 = new DropDown("BodyType", friend.getBodyType());
				// for (int i6 = 0; i6 < Friend.FRIEND_BODYTYPE.length; i6++)
				// {
				// dropdown6.addOption(i6, super.r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[i6]));
				// }
				//
				// row8.add(new Cell(dropdown6));
				// table.add(row8);
				// Row row9 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Age") + ":"), true));
				// row9.add(new Cell(new TextField("Age", friend.getAge())));
				// table.add(row9);
				// Row row10 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Height") + ":"), true));
				// row10.add(new Cell(new TextField("Height", friend.getHeight())));
				// table.add(row10);
				// Row row11 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Smoke") + ":"), true));
				// DropDown dropdown7 = new DropDown("Smoke", friend.getSmoke());
				// for (int j6 = 0; j6 < Friend.FRIEND_SMOKE.length; j6++)
				// {
				// dropdown7.addOption(j6, super.r.getString(teasession._nLanguage, Friend.FRIEND_SMOKE[j6]));
				// }
				//
				// row11.add(new Cell(dropdown7));
				// table.add(row11);
				// Row row12 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Drink") + ":"), true));
				// DropDown dropdown8 = new DropDown("Drink", friend.getDrink());
				// for (int k6 = 0; k6 < Friend.FRIEND_DRINK.length; k6++)
				// {
				// dropdown8.addOption(k6, super.r.getString(teasession._nLanguage, Friend.FRIEND_DRINK[k6]));
				// }
				//
				// row12.add(new Cell(dropdown8));
				// table.add(row12);
				// Row row13 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Children") + ":"), true));
				// DropDown dropdown9 = new DropDown("Children", friend.getChildren());
				// for (int l6 = 0; l6 < Friend.FRIEND_CHILDREN.length; l6++)
				// {
				// dropdown9.addOption(l6, super.r.getString(teasession._nLanguage, Friend.FRIEND_CHILDREN[l6]));
				// }
				//
				// row13.add(new Cell(dropdown9));
				// table.add(row13);
				// form.add(table);
				// form.add(new Go(teasession._nLanguage, 1));
				// PrintWriter printwriter = response.getWriter();
				// printwriter.print(form);
				// printwriter.print(new Languages(teasession._nLanguage, request));
				// printwriter.close();
			} else
			{
				int i = Integer.parseInt(request.getParameter("Gender"));
				int j = Integer.parseInt(request.getParameter("PrefGender"));
				int k = 0;
				for (int l = 0; l < Friend.FRIEND_RELATIONSHIP.length; l++)
				{
					if (request.getParameter(Friend.FRIEND_RELATIONSHIP[l]) != null)
					{
						k |= 1 << l;
					}
				}

				int i1 = Integer.parseInt(request.getParameter("Ethnicity"));
				int k1 = Integer.parseInt(request.getParameter("Education"));
				int l1 = Integer.parseInt(request.getParameter("Employment"));
				int j2 = Integer.parseInt(request.getParameter("Religion"));
				int k2 = 0;
				for (int i3 = 0; i3 < Friend.FRIEND_HOBBIES.length; i3++)
				{
					if (request.getParameter(Friend.FRIEND_HOBBIES[i3]) != null)
					{
						k2 |= 1 << i3;
					}
				}

				int j3 = Integer.parseInt(request.getParameter("BodyType"));
				int k3 = Integer.parseInt(request.getParameter("Age"));
				int i4 = Integer.parseInt(request.getParameter("Height"));
				int j4 = Integer.parseInt(request.getParameter("Smoke"));
				int l4 = Integer.parseInt(request.getParameter("Drink"));
				int i5 = Integer.parseInt(request.getParameter("Children"));
				friend.set(i, j, k, i1, k1, l1, j2, k2, j3, k3, i4, j4, l4, i5);
				if (request.getParameter("GoBack") != null)
				{
					response.sendRedirect("EditNode?node=" + teasession._nNode);
				} else if (request.getParameter("GoFinish") != null)
				{
					node.finished(teasession._nNode);
					response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
				}
			}
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
	}

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/node/type/friend/EditFriend");
	}
}
