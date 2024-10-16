document.addEventListener('DOMContentLoaded', function () {
  const editButtons = document.querySelectorAll('.action-button.edit');

  editButtons.forEach(button => {
    button.addEventListener('click', function () {
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


let ascending = true;

function sortTable(columnIndex) {
  const table = document.querySelector("table");
  const tbody = table.tBodies[0];
  const rows = Array.from(tbody.rows);

  rows.sort((a, b) => {
    const cellA = a.cells[columnIndex].textContent.trim();
    const cellB = b.cells[columnIndex].textContent.trim();

    if (ascending) {
      return cellA.localeCompare(cellB);
    } else {
      return cellB.localeCompare(cellA);
    }
  });

  rows.forEach(row => tbody.appendChild(row));

  ascending = !ascending;
  document.getElementById("arrow").innerHTML = ascending ? "&#9650;" : "&#9660;";
}

function navigateToInicio() {
  const url = document.getElementById('navigateInicio').getAttribute('data-url');
  window.location.href = url;
}

document.addEventListener('DOMContentLoaded', function () {
  const searchInput = document.getElementById('searchInput');
  const tableRows = document.querySelectorAll('table tbody tr');
  const noResultsMessage = document.createElement('tr');
  
  noResultsMessage.innerHTML = '<td colspan="5" style="text-align: center;">No se encontraron resultados..</td>';
  noResultsMessage.style.display = 'none';
  
  tableRows[0].parentNode.appendChild(noResultsMessage);

  searchInput.addEventListener('keyup', function () {
    const searchTerm = searchInput.value.toLowerCase();
    let found = false;

    tableRows.forEach(row => {
      const codigoCuenta = row.querySelector('td:nth-child(1)').textContent.toLowerCase();
      const nombreCuenta = row.querySelector('td:nth-child(2)').textContent.toLowerCase();

      if (codigoCuenta.includes(searchTerm) || nombreCuenta.includes(searchTerm)) {
        row.style.display = ''; // mostrar
        found = true;
      } else {
        row.style.display = 'none'; // ocultar
      }
    });

    noResultsMessage.style.display = found ? 'none' : '';
  });
});




function openModalDelete(cuentaId, codigoCuenta, nombreCuenta) {
  // Mostrar el modal
  document.getElementById('deleteCuentaModal').style.display = 'flex';

  // Guardar el ID de la cuenta en un campo oculto
  document.getElementById('deleteCuentaId').value = cuentaId;

  // Actualizar el texto con la información de la cuenta
  document.getElementById('deleteCuentaInfo').innerText = `"${codigoCuenta} - ${nombreCuenta}"`;
}

function closeModalDelete() {
  document.getElementById('deleteCuentaModal').style.display = 'none';
}

function deleteCuenta() {
  var cuentaId = document.getElementById('deleteCuentaId').value;
  // Crear un formulario para enviar la solicitud POST
  var form = document.createElement('form');
  form.method = 'POST';
  form.action = '/contable/cuentas/eliminar/' + cuentaId;
  document.body.appendChild(form);
  form.submit();
}


function openModalAdd() {
  document.getElementById('addAccountModal').style.display = 'flex';
}

function openModalVer(codigo_cuenta, nombre_cuenta, naturaleza, nivel, estado_cuenta) {
  document.getElementById('verCuentaModal').style.display = 'flex';
  document.getElementById('codigo_cuenta').textContent = codigo_cuenta;
  document.getElementById('nombre_cuenta').textContent = nombre_cuenta;
  document.getElementById('naturaleza').textContent = naturaleza;
  document.getElementById('nivel_cuenta').textContent = nivel == 1 ? 'Elemento' : nivel == 2 ? 'Cuenta' : nivel == 3 ? 'Subcuenta' : 'Divisionaria ? Subdivisionaria';
  document.getElementById('estado_cuenta').textContent = estado_cuenta == 1 ? 'Activo' : 'Inactivo';
}



function closeModalView() {
  document.getElementById('verCuentaModal').style.display = 'none';
}


function closeModalAdd() {
  document.getElementById('addAccountModal').style.display = 'none';
}

document.getElementById('codigo_cuenta').addEventListener('input', function () {
  var nivelCuenta = this.value.length;
  var cuentaPadreContainer = document.getElementById('cuenta_padre_container');

  if (nivelCuenta > 1) {
    cuentaPadreContainer.style.display = 'block';
  } else {
    cuentaPadreContainer.style.display = 'none';
  }
});