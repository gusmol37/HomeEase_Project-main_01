document.addEventListener('DOMContentLoaded', function() {
    // Cargar servicios al cargar la página
    loadServices();
    
    // Manejar filtro por categoría
    document.querySelectorAll('.category-filter').forEach(button => {
        button.addEventListener('click', function() {
            const categoryId = this.dataset.categoryId;
            loadServices(categoryId);
        });
    });
});

function loadServices(categoryId = null) {
    let url = '../services/get_services.php';
    if (categoryId) {
        url += `?category_id=${categoryId}`;
    }
    
    fetch(url)
        .then(response => response.json())
        .then(services => {
            const container = document.getElementById('services-container');
            container.innerHTML = '';
            
            if (services.length === 0) {
                container.innerHTML = '<div class="alert alert-info">No se encontraron servicios</div>';
                return;
            }
            
            services.forEach(service => {
                const card = `
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">${service.name}</h5>
                                <h6 class="card-subtitle mb-2 text-muted">${service.category_name}</h6>
                                <p class="card-text">${service.description}</p>
                                <p class="text-primary fw-bold">$${service.price.toLocaleString()}</p>
                                <p class="text-muted">Proveedor: ${service.provider_name}</p>
                                <a href="booking.html?service_id=${service.id}" class="btn btn-primary">Reservar</a>
                            </div>
                        </div>
                    </div>`;
                container.innerHTML += card;
            });
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('services-container').innerHTML = 
                '<div class="alert alert-danger">Error al cargar los servicios</div>';
        });
}