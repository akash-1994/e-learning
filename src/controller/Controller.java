package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sh = request.getParameter("subheading");
		String tsh = request.getParameter("topicName");
		String stn = request.getParameter("subTopicName");

		if (sh != null) {
			ArrayList<Content> content = new ArrayList<Content>();

			content = FetchData.getAllContent(sh);
			Gson gson = new Gson();
			JsonElement element = gson.toJsonTree(content, new TypeToken<List<Content>>() {
			}.getType());
			JsonArray jsonArray = element.getAsJsonArray();
			response.setContentType("application/json");
			response.getWriter().print(jsonArray);
		} else if (tsh != null) {
			ArrayList<ContentAdmin> contentAdmin = new ArrayList<ContentAdmin>();
			contentAdmin = FetchDataAdmin.getAllContent(tsh);
			Gson gson = new Gson();
			JsonElement elementAdmin = gson.toJsonTree(contentAdmin, new TypeToken<List<ContentAdmin>>() {
			}.getType());
			JsonArray jsonArrayAdmin = elementAdmin.getAsJsonArray();
			response.setContentType("application/json");
			response.getWriter().print(jsonArrayAdmin);
		} else if (stn != null) {
			ArrayList<ContentAdmin> contentAdmin = new ArrayList<ContentAdmin>();
			contentAdmin = FetchDataAdmin.getAllContentEdit(stn);
			Gson gson = new Gson();
			JsonElement elementAdmin = gson.toJsonTree(contentAdmin, new TypeToken<List<ContentAdmin>>() {
			}.getType());
			JsonArray jsonArrayAdmin = elementAdmin.getAsJsonArray();
			response.setContentType("application/json");
			response.getWriter().print(jsonArrayAdmin);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
