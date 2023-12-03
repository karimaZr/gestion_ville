package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "kenza")
public class VilleService implements  IDaoLocale<Ville> {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Ville create(Ville o) {
		em.persist(o);
		return o;
	}

	
	@Override
	public boolean delete(Ville o) {
	    // Assurez-vous que l'entité est attachée au contexte de persistance
	    Ville attachedEntity = em.merge(o);

	    // Maintenant, supprimez l'entité attachée
	    em.remove(attachedEntity);

	    return true;
	}


	@Override
	public Ville update(Ville o) {
		
		    // Assurez-vous que l'entité est attachée au contexte de persistance
		    Ville attachedEntity = em.merge(o);

		    // La mise à jour est effectuée automatiquement lors de la fusion (merge)
		    return attachedEntity;
		
	}

	@Override
	public Ville findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Ville.class, id);
	}

	@Override
	public List<Ville> findAll() {
		Query query = em.createQuery("select v from Ville v");
		return query.getResultList();
	}

}
