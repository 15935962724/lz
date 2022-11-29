package tea.ui.node.type.quiz;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditQuizR extends TeaServlet
{

	public EditQuizR()
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
			new MultipartRequest(request);
			Node node = Node.find(teasession._nNode);
			if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>1)
			{
				response.sendError(403);
				return;
			}
			String s = teasession.getParameter("QuizR");
			boolean flag = s == null;
			if (request.getMethod().equals("GET"))
			{
				String qs = request.getQueryString();
				qs = qs == null ? "" : "?" + qs;
				response.sendRedirect("/jsp/type/quiz/EditQuizR.jsp" + qs);

				// int i = 0;
				// int k = 0;
				// String s1 = "";
				// String s3 = "";
				// int i1 = 0;
				// if (!flag)
				// {
				// int j1 = Integer.parseInt(s);
				// QuizR quizr = QuizR.find(j1);
				// i = quizr.getFloorScore();
				// k = quizr.getCeilScore();
				// s1 = quizr.getText(teasession._nLanguage);
				// s3 = quizr.getAlt(teasession._nLanguage);
				// i1 = quizr.getAlign(teasession._nLanguage);
				// }
				// Form form = new Form("foEdit", "POST", "EditQuizR");
				// form.setMultiPart(true);
				// form.setOnSubmit("return(submitInteger(this.FloorScore,'" + super.r.getString(teasession._nLanguage, "InvalidFloorScore") + "')" + "&&submitInteger(this.CeilScore,'" + super.r.getString(teasession._nLanguage, "InvalidCeilScore") + "')" + ")");
				// form.add(new HiddenField("Node", teasession._nNode));
				// if (!flag)
				// {
				// form.add(new HiddenField("QuizR", s));
				// }
				// Table table = new Table();
				// Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "FloorScore") + ":"), true));
				// row.add(new Cell(new TextField("FloorScore", i)));
				// table.add(row);
				// Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "CeilScore") + ":"), true));
				// row1.add(new Cell(new TextField("CeilScore", k)));
				// table.add(row1);
				// table.add(new PictureInput(teasession._nLanguage, "Picture", 0, s3, i1));
				// table.add(new FileInput(teasession._nLanguage, "Voice"));
				// table.add(new FileInput(teasession._nLanguage, "File"));
				// Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
				// row2.add(new Cell(new TextArea("Text", s1, 6, 60)));
				// table.add(row2);
				// form.add(table);
				// form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
				// PrintWriter printwriter = response.getWriter();
				// printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
				// printwriter.print(form);
				// printwriter.print(new Languages(teasession._nLanguage, request));
				// printwriter.close();
			} else
			{
				int j = 0;
				try
				{
					j = Integer.parseInt(teasession.getParameter("FloorScore"));
				} catch (Exception _ex)
				{
					outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidFloorScore"));
					return;
				}
				int l = 0;
				try
				{
					l = Integer.parseInt(teasession.getParameter("CeilScore"));
				} catch (Exception _ex)
				{
					outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidCeilScore"));
					return;
				}
				String s2 = teasession.getParameter("Text");
				byte abyte0[] = teasession.getBytesParameter("Picture");
				String s4 = teasession.getParameter("Alt");
				int k1 = Integer.parseInt(teasession.getParameter("Align"));
				byte abyte1[] = teasession.getBytesParameter("Voice");
				String s5 = teasession.getParameter("FileName");
				byte abyte2[] = teasession.getBytesParameter("File");
				if (flag)
				{
					QuizR.create(teasession._nNode, j, l, teasession._nLanguage, s2, abyte0, s4, k1, abyte1, s5, abyte2);
				} else
				{
					QuizR quizr1 = QuizR.find(Integer.parseInt(s));
					quizr1.set(j, l, teasession._nLanguage, s2, teasession.getParameter("ClearPicture") != null, abyte0, s4, k1, teasession.getParameter("ClearVoice") != null, abyte1, teasession.getParameter("ClearFile") != null, s5, abyte2);
				}
				response.sendRedirect("EditQuiz?node=" + teasession._nNode);
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
		super.r.add("tea/ui/node/type/quiz/EditQuizR");
	}
}
