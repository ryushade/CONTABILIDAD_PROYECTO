
function openEditUsu(usuarioId) {
  fetch('/contable/usuarios/obtener/' + usuarioId)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert('Error: ' + data.error);
      } else {
        // Verifica los datos que están siendo asignados
        console.log("Datos recibidos:", data);

        // Asignar valores a los campos del formulario
        document.getElementById('rol').value = data.rol;
        document.getElementById('usua').value = data.usua;
        document.getElementById('contrasena').value = data.contra;
        document.getElementById('estado').value = data.estado_usuario;

        // Mostrar el modal de edición
        document.getElementById('editUsuarioModal').style.display = 'flex';
      }
    })
    .catch(error => {
      console.error('Error fetching user data:', error);
    });
}

function openEditRegla(reglaId) {
  fetch('/contable/reglas/detalles/' + reglaId)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert('Error: ' + data.error);
      } else {
        // Verifica los datos que están siendo asignados
        console.log("Datos recibidos:", data);
        document.getElementById('nombre_regla').value = data.nombre_regla;
        document.getElementById('tipo_transaccion').value = data.tipo_transaccion;
        document.getElementById('cuenta_debito').value = data.cuenta_debito;
        document.getElementById('cuenta_credito').value = data.cuenta_credito;
        document.getElementById('estado').value = data.estado_regla;

        document.getElementById('editReglaModal').style.display = 'flex';
      }
    })
    .catch(error => {
      console.error('Error fetching rule data:', error);
    }
    );
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

function closeModalUsuEdit() {
  document.getElementById('editUsuarioModal').style.display = 'none';
}

function openModalDeleteUsu(idUsuario, nombreRol, nombreUsuario) {
  document.getElementById('deleteUsuarioModal').style.display = 'flex';
  document.getElementById('deleteUsuarioId').value = idUsuario;
  document.getElementById('deleteUsuarioInfo').innerText = `${nombreRol} - ${nombreUsuario}`;
}




function openModalDeleteRegla(idRegla, nombreRegla) {
  document.getElementById('deleteReglaModal').style.display = 'flex';
  document.getElementById('deleteReglaId').value = idRegla;
  document.getElementById('deleteReglaInfo').innerText = `"${nombreRegla}"`;
}

function closeModalDeleteRegla() {
  document.getElementById('deleteReglaModal').style.display = 'none';
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

function deleteRegla() {
  var reglaId = document.getElementById('deleteReglaId').value;
  var form = document.createElement('form');
  form.method = 'POST';
  form.action = '/contable/reglas/eliminar/' + reglaId;
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

document.addEventListener("DOMContentLoaded", function() {
  // Verifica si el mensaje de alerta debe mostrarse
  {% if session.get('show_permission_alert') %}
      document.getElementById("permissionAlert").style.display = "flex";
      // Limpia la variable de la sesión después de mostrar el mensaje
      {% set session['show_permission_alert'] = None %}
  {% endif %}
});

function openModalAdd() {
  document.getElementById('addAccountModal').style.display = 'flex';
}

function openModalAddUsu() {
  document.getElementById('addUsuarioModal').style.display = 'flex';
}

function openModalVer(codigo_cuenta, nombre_cuenta, naturaleza, nivel, estado_cuenta) {
  document.getElementById('verCuentaModal').style.display = 'flex';
  document.getElementById('codigo_cuenta2').textContent = codigo_cuenta;
  document.getElementById('nombre_cuenta2').textContent = nombre_cuenta;
  document.getElementById('naturaleza2').textContent = naturaleza;
  document.getElementById('nivel_cuenta2').textContent = nivel == 1 ? 'Elemento' : nivel == 2 ? 'Cuenta' : nivel == 3 ? 'Subcuenta' : 'Divisionaria ? Subdivisionaria';
  document.getElementById('estado_cuenta2').textContent = estado_cuenta == 1 ? 'Activo' : 'Inactivo';
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




// Función para Cerrar el Modal
function closeModalVer() {
  document.getElementById('openVerModal').style.display = 'none';
}


let currentReglaId = null;

function openEditModal(reglaId, nombre, tipoTransaccion, cuentaDebito, cuentaCredito, estado) {
  currentReglaId = reglaId; // Guarda el ID de la regla actual

  // Llena los campos del formulario con los datos actuales de la regla
  document.getElementById("nombre_regla_edit").value = nombre;
  document.getElementById("tipo_transaccion_edit").value = tipoTransaccion;
  document.getElementById("cuenta_debito_edit").value = cuentaDebito || ""; // Si es nulo, poner ""
  document.getElementById("cuenta_credito_edit").value = cuentaCredito || ""; // Si es nulo, poner ""
  document.getElementById("estado_cuenta_edit").value = estado;

  // Muestra el modal
  document.getElementById("editReglaModal").style.display = "flex";
}

function closeModalEdit() {
  document.getElementById("editReglaModal").style.display = "none";
}

function submitEditForm(event) {
  event.preventDefault(); // Evita el envío del formulario

  // Obtiene los valores del formulario
  const nombreRegla = document.getElementById("nombre_regla_edit").value;
  const tipoTransaccion = document.getElementById("tipo_transaccion_edit").value;
  const cuentaDebito = document.getElementById("cuenta_debito_edit").value || null;
  const cuentaCredito = document.getElementById("cuenta_credito_edit").value || null;
  const estado = document.getElementById("estado_cuenta_edit").value;

  // Realiza una petición al servidor para actualizar la regla
  fetch(`/contable/reglas/actualizar_regla/${currentReglaId}`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      nombre_regla: nombreRegla,
      tipo_transaccion: tipoTransaccion,
      cuenta_debito: cuentaDebito,
      cuenta_credito: cuentaCredito,
      estado: estado,
    }),
  })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert("Regla actualizada correctamente.");
        closeModalEdit(); // Cierra el modal
        location.reload(); // Recarga la página para mostrar los cambios
      } else {
        // Imprime los datos enviados y el mensaje de error recibido
        console.log("Datos enviados:", {
          nombre_regla: nombreRegla,
          tipo_transaccion: tipoTransaccion,
          cuenta_debito: cuentaDebito,
          cuenta_credito: cuentaCredito,
          estado: estado,
        });
        console.log("Error en la respuesta del servidor:", data.message);
        alert("Error al actualizar la regla: " + data.message);
      }
    })
    .catch(error => {
      console.error("Error en la solicitud:", error);
      alert("Ocurrió un error al intentar actualizar la regla.");
    });
}



document.addEventListener('DOMContentLoaded', () => {
  const addForm = document.getElementById('addForm');
  if (addForm) {
    addForm.addEventListener('submit', submitAddForm);
  }

  // Monitor select changes
  const tipoTransaccionSelect = document.getElementById('tipo_transaccion');
  if (tipoTransaccionSelect) {
    tipoTransaccionSelect.addEventListener('change', (e) => {
      console.log('Select changed:', e.target.value);
    });
  }
});
function submitAddForm(event) {
  event.preventDefault();

  // Get form elements
  const nombreRegla = document.getElementById("codigo_cuenta").value;
  const tipoTransaccion = document.getElementById("tipo_transaccion_add").value;
  const cuentaDebito = document.getElementById("cuenta_debito_add").value || null;
  const cuentaCredito = document.getElementById("cuenta_credito_add").value || null;
  const estado = document.getElementById("estado_cuenta").value;

  // Log form data
  console.log("Datos del formulario:", {
    nombreRegla,
    tipoTransaccion,
    cuentaDebito,
    cuentaCredito,
    estado
  });

  // Create request body
  const requestBody = {
    nombre_regla: nombreRegla,
    tipo_transaccion: tipoTransaccion,
    cuenta_debito: cuentaDebito,
    cuenta_credito: cuentaCredito,
    estado: estado,
  };

  // Send request
  fetch(`/contable/reglas/agregar`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(requestBody),
  })
    .then(response => {
      if (!response.ok) {
        throw new Error(`Error HTTP: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      if (data.success) {
        alert("Regla agregada correctamente.");
        closeModalAdd();
        location.reload();
      } else {
        alert("Hubo un problema al agregar la regla: " + (data.message || ''));
      }
    })
    .catch(error => {
      console.error("Error al agregar la regla:", error);
      alert("Error al agregar la regla. Revisa la consola para más detalles.");
    });
}

function previewPhoto(event) {
  const reader = new FileReader();
  reader.onload = function () {
    const profileImagePreview = document.getElementById('profileImagePreview');
    profileImagePreview.innerHTML = `<img src="${reader.result}" alt="Foto de perfil" style="width: 100%; height: 100%; border-radius: 50%;">`;
  };
  reader.readAsDataURL(event.target.files[0]);
}
