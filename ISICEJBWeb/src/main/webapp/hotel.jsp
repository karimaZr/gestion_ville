<%@page import="entities.Hotel"%>
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
<title>Liste des Hôtels</title>

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

#hotelTable_wrapper {
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
				<li class="nav-item"><a class="nav-link" href="ville.jsp">Gestion
						Ville</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Gestion
						Hôtel</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-5">

		<form action="HotelController" method="post">
			<button type="button" class="btn btn-warning" data-toggle="modal"
				data-target="#addModal">Ajouter un Hôtel</button>
			<button type="submit" class="btn btn-primary">Afficher
				Hôtels</button>
		</form>
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Ajouter un hôtel</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="HotelController" method="post"
							class="needs-validation" novalidate>
							<div class="form-group">
								<label for="hotel">Nom :</label> <input type="text"
									class="form-control" id="hotel" name="hotel" required>
							</div>
							<div class="form-group">
								<label for="adresse">Adresse :</label> <input type="text"
									class="form-control" id="adresse" name="adresse" required>
							</div>
							<div class="form-group">
								<label for="telephone">Téléphone :</label> <input type="text"
									class="form-control" id="telephone" name="telephone" required>
							</div>
							<div class="form-group">
								<label for="ville">Ville :</label> <select class="form-control"
									id="ville" name="ville" required>
									<c:forEach items="${villes}" var="v">
										<option value="${v.id}">${v.nom}</option>
									</c:forEach>
								</select>
							</div>
							<button type="submit" class="btn btn-primary">Enregistrer
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Table to Display Hotels -->
		<h1>Liste des hôtels :</h1>
		<div class="form-group">
			<label for="filterVille">Filter by Ville:</label> <select
				class="form-control" id="filterVille" name="filterVille">
				<option value="">All</option>
				<c:forEach items="${villes}" var="v">
					<option value="${v.id}">${v.nom}</option>
				</c:forEach>
			</select>
		</div>


		<table id="hotelTable" class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nom</th>
					<th>Adresse</th>
					<th>Téléphone</th>
					<th>Ville</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${hotels}" var="h">
					<tr>
						<td>${h.id}</td>
						<td>${h.nom}</td>
						<td>${h.adresse}</td>
						<td>${h.telephone}</td>
						<td>${h.ville.nom}</td>

						<td>
							<!-- Bouton pour la mise à jour -->
							<button type="button" class="btn btn-warning" data-toggle="modal"
								data-target="#updateModal${h.id}">Modifier</button> <!-- Modal pour la mise à jour -->
							<div class="modal fade" id="updateModal${h.id}" tabindex="-1"
								role="dialog" aria-labelledby="updateModalLabel${h.id}"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="updateModalLabel${h.id}">Modifier
												l'hôtel</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form action="HotelController" method="get">
												<input type="hidden" name="action" value="edit"> <input
													type="hidden" name="id" value="${h.id}">
												<div class="form-group">
													<label for="updatedHotelName" value="${h.id}">Nouveau
														nom :</label> <input type="text" class="form-control"
														id="updatedHotelName" value="${h.nom}"
														name="updatedHotelName" required>
												</div>
												<div class="form-group">
													<label for="updatedHotelAdresse">Nouvelle adresse :</label>
													<input type="text" value="${h.adresse}"
														class="form-control" id="updatedHotelAdresse"
														name="updatedHotelAdresse" required>
												</div>
												<div class="form-group">
													<label for="updatedHotelTelephone">Nouveau
														téléphone :</label> <input type="text" value="${h.telephone}"
														class="form-control" id="updatedHotelTelephone"
														name="updatedHotelTelephone" required>
												</div>
												<div class="form-group">
													<label for="updVille">Nouvelle ville :</label> <select
														class="form-control" id="updVille" name="updVille"
														required>
														<c:forEach items="${villes}" var="v">
															<option value="${v.id}">${v.nom}</option>
														</c:forEach>
													</select>
												</div>
												<button type="submit" class="btn btn-primary">Enregistrer
													les modifications</button>
											</form>
										</div>
									</div>
								</div>
							</div> <!-- Bouton pour la suppression -->
							<button type="button" class="btn btn-danger" data-toggle="modal"
								data-target="#deleteModal${h.id}">Supprimer</button> <!-- Modal pour la suppression -->
							<div class="modal fade" id="deleteModal${h.id}" tabindex="-1"
								role="dialog" aria-labelledby="deleteModalLabel${h.id}"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="deleteModalLabel${h.id}">Supprimer
												l'hôtel</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form action="HotelController" method="get">
												<input type="hidden" name="action" value="delete"> <input
													type="hidden" name="id" value="${h.id}">
												<p>Voulez-vous vraiment supprimer l'hôtel "${h.nom}" ?</p>
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


<script>
    $(document).ready(function () {
        var table = $('#hotelTable').DataTable({
            // Your DataTable configuration options...
            // ...
            initComplete: function () {
                this.api().columns().every(function () {
                    var column = this;
                    if (column.header().textContent === 'Ville') {
                        // Add a filter dropdown for the "Ville" column
                        var select = $('<select><option value="">All</option></select>')
                            .appendTo($(column.footer()).empty())
                            .on('change', function () {
                                var val = $.fn.dataTable.util.escapeRegex($(this).val());
                                column.search(val ? '^' + val + '$' : '', true, false).draw();
                            });

                        // Add options from Ville dropdown to DataTable filter dropdown
                        $('#filterVille option').each(function () {
                            select.append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
                        });

                        // Trigger change event to initialize the filter
                        select.trigger('change');
                    }
                });
            }
        });
    });
</script>
</body>
</html>
