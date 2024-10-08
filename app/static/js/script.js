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

document.addEventListener('DOMContentLoaded', function () {
  const searchInput = document.getElementById('searchInput');
  const tableRows = document.querySelectorAll('table tbody tr');

  searchInput.addEventListener('keyup', function () {
    const searchTerm = searchInput.value.toLowerCase();

    tableRows.forEach(row => {
      const codigoCuenta = row.querySelector('td:nth-child(1)').textContent.toLowerCase();
      const nombreCuenta = row.querySelector('td:nth-child(2)').textContent.toLowerCase();

      // Check if the search term matches either 'codigoCuenta' or 'nombreCuenta'
      if (codigoCuenta.includes(searchTerm) || nombreCuenta.includes(searchTerm)) {
        row.style.display = ''; // Show row
      } else {
        row.style.display = 'none'; // Hide row
      }
    });
  });
});



function openModalDelete(cuentaId) {
  document.getElementById('deleteCuentaModal').style.display = 'flex';
  document.getElementById('deleteCuentaModal').action = '/contable/cuentas/eliminar/' + cuentaId;
}

function closeModalDelete() {
  document.getElementById('deleteCuentaModal').style.display = 'none';
}

function openModalAdd() {
  document.getElementById('addAccountModal').style.display = 'flex';
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