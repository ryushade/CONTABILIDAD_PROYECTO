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

function openEditUsu(usuarioId) {
  fetch('/contable/usuarios/obtener/' + usuarioId)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert('Error: ' + data.error);
      } else {
        document.getElementById('nom_rol').value = data.nom_rol;
        document.getElementById('usua').value = data.usua;
        document.getElementById('contra').value = data.contra;
        document.getElementById('estado_usuario').value = data.estado_usuario;

        document.getElementById('editUsuarioModal').action = '/contable/usuarios/editar/' + usuarioId;

        document.querySelector('.modal-overlay').style.display = 'flex';

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


function openModalDeleteUsu(idUsuario, nombreUsuario) {
  document.getElementById('deleteUsuarioModal').style.display = 'flex';
  document.getElementById('deleteUsuarioId').value = idUsuario;
  document.getElementById('deleteUsuInfo').innerText = `"${nombreUsuario}"`;
}

function closeModalDeleteUsuario() {
  document.getElementById('deleteUsuarioModal').style.display = 'none';
}

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

function deleteUsuario() {
  const usuarioId = document.getElementById('deleteUsuarioId').value;

  fetch(`/contable/usuarios/eliminar/${usuarioId}`, {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json'
      }
  })
  .then(response => {
      if (response.redirected) {
          window.location.href = response.url;  // Redirige a la página a la que el servidor haya especificado
      } else if (response.ok) {
          alert("Usuario eliminado correctamente");
          closeModalDeleteUsuario();
          // Aquí puedes actualizar la interfaz, por ejemplo, eliminando la fila del usuario de la tabla
      } else {
          alert("Error al eliminar el usuario");
      }
  })
  .catch(error => {
      console.error("Error al eliminar el usuario:", error);
  });
}

function submitAddUsuario(event) {
  event.preventDefault();  

  const rol = document.getElementById('rol').value;
  const usuario = document.getElementById('usuario').value;
  const contrasena = document.getElementById('contrasena').value;
  const estado = document.getElementById('estado').value;

  const data = {
      id_rol: rol,
      usua: usuario,
      contra: contrasena,
      estado_usuario: estado
  };

  fetch('/contable/usuarios/agregar', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
  })
  .then(response => {
      if (response.ok) {
          closeModalUsu();  
          window.location.reload();  
      } else {
          return response.json().then(data => {
              alert(data.message || "Error al añadir el usuario");
          });
      }
  })
  .catch(error => {
      console.error("Error:", error);
      alert("Error al conectar con el servidor");
  });
}


function openModalVerRegla(nombre_regla, tipo_transaccion, estado, cuenta_debito, cuenta_credito) {
  document.getElementById('openVerModal').style.display = 'flex';
  document.getElementById('nombre_regla').textContent = nombre_regla;
  document.getElementById('tipo_transaccion').textContent = tipo_transaccion;
  document.getElementById('estado').textContent = estado;
  document.getElementById('cuenta_debito').textContent = cuenta_debito;
  document.getElementById('cuenta_credito').textContent = cuenta_credito;
}

function openModalAdd() {
  document.getElementById('addAccountModal').style.display = 'flex';
}

function openModalAddUsu() {
  document.getElementById('addUsuarioModal').style.display = 'flex';
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

function closeModalVer() {
  document.getElementById('openVerModal').style.display = 'none';
}

function closeModalUsu() {
  document.getElementById('addUsuarioModal').style.display = 'none';
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


document.addEventListener("DOMContentLoaded", function () {
  const soloDebitoCheckbox = document.getElementById('solo_debito_checkbox');
  const soloCreditoCheckbox = document.getElementById('solo_credito_checkbox');
  const cuentaDebitoInput = document.getElementById('cuenta_debito');
  const cuentaCreditoInput = document.getElementById('cuenta_credito');

  soloDebitoCheckbox.addEventListener('change', () => {
    if (soloDebitoCheckbox.checked) {
      cuentaCreditoInput.disabled = true;
      soloCreditoCheckbox.checked = false;
    } else {
      cuentaCreditoInput.disabled = false;
    }
  });

  soloCreditoCheckbox.addEventListener('change', () => {
    if (soloCreditoCheckbox.checked) {
      cuentaDebitoInput.disabled = true;
      soloDebitoCheckbox.checked = false;
    } else {
      cuentaDebitoInput.disabled = false;
    }
  });
});