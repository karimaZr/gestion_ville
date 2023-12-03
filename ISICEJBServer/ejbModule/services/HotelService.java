package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
@Stateless(name = "hotel")
public class HotelService implements IDaoRemote<Hotel> {


	@PersistenceContext
	private EntityManager em;

	@Override
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	
	@Override
	public boolean delete(Hotel o) {
	    // Assurez-vous que l'entité est attachée au contexte de persistance
	    Hotel attachedEntity = em.merge(o);

	    // Maintenant, supprimez l'entité attachée
	    em.remove(attachedEntity);

	    return true;
	}


	@Override
	public Hotel update(Hotel o) {
		
		    // Assurez-vous que l'entité est attachée au contexte de persistance
		    Hotel attachedEntity = em.merge(o);

		    // La mise à jour est effectuée automatiquement lors de la fusion (merge)
		    return attachedEntity;
		
	}

	

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select h from Hotel h");
		return query.getResultList();
	}


	@Override
	public Hotel findById(int id) {
		return em.find(Hotel.class, id);
	}
}