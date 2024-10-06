document.addEventListener('DOMContentLoaded', function() {
  const editButtons = document.querySelectorAll('.action-button.edit');

  editButtons.forEach(button => {
    button.addEventListener('click', function() {
      const cuentaId = this.dataset.cuentaId;
      openEditModal(cuentaId);
    });
  });
});

function openEditModal(cuentaId) {
  fetch('/contable/cuentas/obtener/' + cuentaId)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert('Error: ' + data.error);
      } else {
        document.getElementById('codigo_cuenta').value = data.codigo_cuenta;
        document.getElementById('nombre_cuenta').value = data.nombre_cuenta;
        document.getElementById('naturaleza').value = data.naturaleza;
        document.getElementById('estado_cuenta').value = data.estado_cuenta;

        document.getElementById('editCuentaModal').action = '/contable/cuentas/editar/' + cuentaId;

        // Mostrar el modal
        document.querySelector('.modal-overlay').style.display = 'flex'; // Usa 'flex' si usas flexbox
      }
    })
    .catch(error => {
      console.error('Error fetching account data:', error);
    });
}

function closeModal() {
  document.querySelector('.modal-overlay').style.display = 'none';
}