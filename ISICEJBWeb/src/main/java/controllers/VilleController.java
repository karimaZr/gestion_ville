package controllers;

import java.io.IOException;

import dao.IDaoLocale;
import entities.Ville;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class VilleController
 */
public class VilleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB(name = "kenza")
    private IDaoLocale<Ville> ejb;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public VilleController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "edit":
                    // Récupérer l'ID de la ville à mettre à jour depuis les paramètres de la requête
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        long id = Long.parseLong(idStr);
                        Ville villeToUpdate = ejb.findById(Integer.parseInt(idStr));

                        // Mettre à jour la ville avec les nouvelles informations
                        String updatedName = request.getParameter("updatedVilleName");
                        villeToUpdate.setNom(updatedName);
                        ejb.update(villeToUpdate);
                    }
                    break;

                case "delete":
                    // Récupérer l'ID de la ville à supprimer depuis les paramètres de la requête
                    String deleteIdStr = request.getParameter("id");
                    if (deleteIdStr != null && !deleteIdStr.isEmpty()) {
                        Ville villeToDelete = ejb.findById(Integer.parseInt(deleteIdStr));

                        // Supprimer la ville
                        ejb.delete(villeToDelete);
                    }
                    break;
            }
        } else {
        	
            String nom = request.getParameter("ville");
            if (nom != null && !nom.isEmpty()) {
                ejb.create(new Ville(nom));
            } else {
                // Handle the case when nom is empty or null, e.g., show an error message or take appropriate action
                System.out.println("Error: nom is empty or null");
            }
        }

        // Mettre à jour la liste des villes après les opérations
        request.setAttribute("villes", ejb.findAll());
        RequestDispatcher dispatcher = request.getRequestDispatcher("ville.jsp");

        dispatcher.forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
