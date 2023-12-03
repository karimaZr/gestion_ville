package controllers;

import java.io.IOException;
import java.util.logging.Logger;
import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(HotelController.class.getName());

	@EJB(name = "hotel")
	private IDaoRemote<Hotel> ejb;
	@EJB(name = "kenza")
	private IDaoLocale<Ville> ejbVille;
	
	public HotelController() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action != null) {
			switch (action) {
			case "edit":
				String idStr = request.getParameter("id");
				if (idStr != null && !idStr.isEmpty()) {
					long id = Long.parseLong(idStr);
					Hotel hotelToUpdate = ejb.findById(Integer.parseInt(idStr));
					String villeIdStr = request.getParameter("updVille");
                    System.out.println(villeIdStr);

                    int Idupd = Integer.parseInt(villeIdStr);
                    logger.info("Parsed VilleId: " + Idupd);

                    Ville selectedVille = ejbVille.findById(Idupd);

					String updatedName = request.getParameter("updatedHotelName");
					String updatedAdresse = request.getParameter("updatedHotelAdresse");
					String updatedTelephone = request.getParameter("updatedHotelTelephone");

					hotelToUpdate.setNom(updatedName);
					hotelToUpdate.setAdresse(updatedAdresse);
					hotelToUpdate.setTelephone(updatedTelephone);
					hotelToUpdate.setVille(selectedVille);

					ejb.update(hotelToUpdate);
				}
				break;

			case "delete":
				String deleteIdStr = request.getParameter("id");
				if (deleteIdStr != null && !deleteIdStr.isEmpty()) {
					Hotel hotelToDelete = ejb.findById(Integer.parseInt(deleteIdStr));
					ejb.delete(hotelToDelete);
				}
				break;
			}
		} else {
			// Assurez-vous que les noms des paramètres du formulaire correspondent
			String villeIdStr = request.getParameter("ville");
			if (villeIdStr != null && !villeIdStr.isEmpty()) {
				int villeId = Integer.parseInt(villeIdStr);
				Ville selectedVille = ejbVille.findById(villeId);

				// Assurez-vous d'ajuster la logique pour créer ou mettre à jour l'hôtel avec la
				// ville sélectionnée
				String nom = request.getParameter("hotel");
				String adresse = request.getParameter("adresse");
				String telephone = request.getParameter("telephone");

				Hotel newHotel = new Hotel(nom, adresse, telephone, selectedVille);

				ejb.create(newHotel);
			}
		}
		request.setAttribute("villes", ejbVille.findAll());
		request.setAttribute("hotels", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
