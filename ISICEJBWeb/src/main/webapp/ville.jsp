<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Liste des Villes</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- DataTables CSS -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap4.min.css">

<style>
body {
	background-color: #f8f9fa;
}

.navbar {
	background-color: #007bff;
}

.navbar-dark .navbar-nav .nav-link {
	color: #ffffff;
}

/* Style for the form and table */
.container {
	max-width: 800px;
}

#cityTable_wrapper {
	margin-top: 20px;
}

/* Style for the form validation messages */
.invalid-feedback {
	display: block;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<a class="navbar-brand" href="#">Môtel</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="#">Gestion
						Ville</a></li>
				<li class="nav-item"><a class="nav-link" href="hotel.jsp">Gestion
						Hôtel</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-5">

		<!-- Form to Add a City -->
		<h2>Ajouter une ville:</h2>
		<form action="VilleController" method="post" class="needs-validation"
			novalidate>
			<div class="form-group">
				<label for="ville">Nom :</label> <input type="text"
					class="form-control" id="ville" name="ville" required>
				<div class="invalid-feedback">Veuillez saisir le nom de la
					ville.</div>
			</div>
			<button type="submit" class="btn btn-primary">Enregistrer</button>
			<button type="submit" class="btn btn-warning">Afficher
				Hôtels</button>
		</form>

		<!-- Table to Display Cities -->
		<h2>Liste des villes :</h2>
		
		<table id="cityTable" class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nom</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${villes}" var="v">
					<tr>
						<td>${v.id}</td>
						<td>${v.nom}</td>
						<td>
							<!-- Bouton pour la mise à jour -->
							<button type="button" class="btn btn-warning" data-toggle="modal"
								data-target="#updateModal${v.id}">Modifier</button> <!-- Modal pour la mise à jour -->
							<div class="modal fade" id="updateModal${v.id}" tabindex="-1"
								role="dialog" aria-labelledby="updateModalLabel${v.id}"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="updateModalLabel${v.id}">Modifier
												la ville</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form action="VilleController" method="get">
												<input type="hidden" name="action" value="edit"> <input
													type="hidden" name="id" value="${v.id}">
												<div class="form-group">
													<label for="updatedVilleName">Nouveau nom :</label> <input
														type="text" class="form-control" value="${v.nom}"
														id="updatedVilleName" name="updatedVilleName" required>
												</div>
												<button type="submit" class="btn btn-primary">Enregistrer
													les modifications</button>
											</form>
										</div>
									</div>
								</div>
							</div> <!-- Bouton pour la suppression -->
							<button type="button" class="btn btn-danger" data-toggle="modal"
								data-target="#deleteModal${v.id}">Supprimer</button> <!-- Modal pour la suppression -->
							<div class="modal fade" id="deleteModal${v.id}" tabindex="-1"
								role="dialog" aria-labelledby="deleteModalLabel${v.id}"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="deleteModalLabel${v.id}">Supprimer
												la ville</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form action="VilleController" method="get">
												<input type="hidden" name="action" value="delete"> <input
													type="hidden" name="id" value="${v.id}">
												<p>Voulez-vous vraiment supprimer la ville "${v.nom}" ?</p>
												<button type="submit" class="btn btn-danger">Oui,
													supprimer</button>
											</form>
										</div>
									</div>
								</div>
							</div>

						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<!-- Bootstrap and DataTables JavaScript -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


	<!-- Custom JavaScript for form validation -->
	<script>
	
		$(document)
				.ready(
						function() {
							$('#cityTable').DataTable();
							(function() {
								'use strict';
								window
										.addEventListener(
												'load',
												function() {
													// Récupérer tous les formulaires auxquels nous voulons appliquer des styles Bootstrap personnalisés
													var forms = document
															.getElementsByClassName('needs-validation');
													// Boucle sur eux et empêcher la soumission
													var validation = Array.prototype.filter
															.call(
																	forms,
																	function(
																			form) {
																		form
																				.addEventListener(
																						'submit',
																						function(
																								event) {
																							if (form
																									.checkValidity() === false) {
																								event
																										.preventDefault();
																								event
																										.stopPropagation();
																							}
																							form.classList
																									.add('was-validated');
																						},
																						false);
																	});
												}, false);
							})();
						});
	</script>

</body>
</html>
