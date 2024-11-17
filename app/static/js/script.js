function openEditUsu(id_usuario, id_rol, usua, contra, estado_usuario, admin) {
  document.getElementById('rol_usuario').value = id_rol;
  document.getElementById('usuario_edit').value = usua;
  document.getElementById('contrasena_usuario_edit').value = contra;
  document.getElementById('estado_usuario').value = estado_usuario;
  document.getElementById('admin_edit').value = admin ? '1' : '0';
  // Guardar el ID del usuario en el dataset del formulario para su uso en la actualización
  document.getElementById('editUsuarioModal').dataset.usuarioId = id_usuario;

  // Mostrar el modal de edición
  document.getElementById('editUsuarioModal').style.display = 'flex';
}

document.getElementById('editUsuarioModal').addEventListener('submit', function (event) {
  event.preventDefault();

  const usuarioId = this.dataset.usuarioId;  
  const formData = new FormData(this);

  for (let [key, value] of formData.entries()) {
      console.log(`${key}: ${value}`);
  }

  fetch('/contable/usuarios/actualizar/' + usuarioId, {
      method: 'POST',
      body: formData
  })
  .then(response => response.json())
  .then(data => {
      if (data.code === 1) {
          alert('Usuario modificado exitosamente');  
          closeModalUsuEdit();  
          setTimeout(() => window.location.reload(), 500);
      } else {
          alert(data.error || data.message || 'Error al actualizar el usuario');
      }
  })
  .catch(error => {
      console.error('Error al actualizar el usuario:', error);
      alert('Error al actualizar el usuario. Por favor, inténtalo de nuevo más tarde.');
  });
});






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

function closeModalError() {
  document.getElementById('ErrorModal').style.display = 'none';
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

  // Obtener valores de los campos
  const rol = document.getElementById('rol').value;
  const usuario = document.getElementById('usuario').value.trim();
  const contrasena = document.getElementById('contrasena').value;
  const estado = document.getElementById('estado').value;
  const admin = document.getElementById('admin').value;

  // Expresiones regulares y validaciones
  const usuarioRegex = /^[a-zA-Z0-9_]{3,20}$/; // Solo letras, números y guiones bajos, entre 3 y 20 caracteres

  // Validar que todos los campos estén llenos
  if (!rol || !usuario || !contrasena || !estado) {
    alert("Todos los campos son obligatorios.");
    return;
  }

  // Validar rol
  if (rol === "0") { // Asegúrate de que el valor "0" es el predeterminado cuando no se selecciona un rol válido
    alert("Por favor, selecciona un rol válido.");
    return;
  }

  // Validar usuario
  if (!usuarioRegex.test(usuario)) {
    alert("El nombre de usuario debe contener solo letras, números o guiones bajos y tener entre 3 y 20 caracteres.");
    return;
  }



  // Crear el cuerpo de la solicitud
  const data = {
    id_rol: rol,
    usua: usuario,
    contra: contrasena,
    estado_usuario: estado,
    admin: admin
  };

  // Enviar la solicitud
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

  const nombreRegla = document.getElementById("codigo_cuenta").value;
  const tipoTransaccion = document.getElementById("tipo_transaccion_add").value;
  const cuentaDebito = document.getElementById("cuenta_debito_add").value || null;
  const cuentaCredito = document.getElementById("cuenta_credito_add").value || null;
  const estado = document.getElementById("estado_cuenta").value;
  const tipoMonto = document.getElementById("tipo_monto_add").value;

  // Expresión regular para validar que no contenga letras ni caracteres especiales
  const invalidChars = /[A-Za-zñÑ@!#$%^&*(),?":{}|<>]/g;

  // Solo validar si los campos tienen valor
  if ((cuentaDebito && invalidChars.test(cuentaDebito)) ||
    (cuentaCredito && invalidChars.test(cuentaCredito))) {
    alert("Las cuentas no deben contener letras ni caracteres especiales.");
    return;
  }
  console.log("Datos del formulario:", {
    nombreRegla,
    tipoTransaccion,
    cuentaDebito,
    cuentaCredito,
    estado,
    tipoMonto,
  });

  const requestBody = {
    nombre_regla: nombreRegla,
    tipo_transaccion: tipoTransaccion,
    cuenta_debito: cuentaDebito,
    cuenta_credito: cuentaCredito,
    estado: estado,
    tipo_monto: tipoMonto,
  };

  // Enviar la solicitud
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

