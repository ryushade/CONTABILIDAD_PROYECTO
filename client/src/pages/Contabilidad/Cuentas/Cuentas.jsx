import { useState } from 'react';
import Breadcrumb from '@/components/Breadcrumb/Breadcrumb';
import { Toaster } from "react-hot-toast";
import BarraSearch from "@/components/Search/Search";
import { Select, SelectItem } from "@nextui-org/react";
import ShowCuentas from "./ShowCuentas";

function Cuentas() {


  const [searchTerm, setSearchTerm] = useState("");


  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleClearSearch = () => {
    setSearchTerm(""); 
  };

  return (
    <div className="p-4">
      <Toaster />
      <Breadcrumb
        paths={[
          { name: "Inicio", href: "/inicio" },
          { name: "Contabilidad", href: "/contabilidad" },
          { name: "Cuentas", href: "/contabilidad/cuentas" },
        ]}
      />
      <hr className="my-4" />
      <h1 className='font-extrabold text-4xl mb-6'>Plan Contable General Empresarial</h1>

      <div className="flex flex-col md:flex-row justify-between items-justified mb-6 space-y-4 md:space-y-0">
        <h6 className='font-bold text-lg'>Lista de Cuentas</h6>

        <div className="flex w-full md:w-auto gap-4"> {/* Agrupar la barra de búsqueda y el select en el mismo contenedor */}
          {/* Barra de Búsqueda */}
          <div className='relative flex-grow max-w-5xl'>
            <BarraSearch
              value={searchTerm}
              onChange={handleSearchChange}
              placeholder="Ingrese la cuenta a buscar"
              isClearable={true}
              onClear={handleClearSearch}
            />
          </div>

          {/* Selector de Tipo de Cuenta */}
          <Select
            placeholder='Tipo de Cuenta'
            selectionMode='multiple'
            className='w-60'
          >
            <SelectItem key="activo">Activo</SelectItem>
            <SelectItem key="pasivo">Pasivo</SelectItem>
            <SelectItem key="patrimonio">Patrimonio</SelectItem>
            <SelectItem key="ingreso">Ingreso</SelectItem>
            <SelectItem key="gasto">Gasto</SelectItem>
          </Select>
        </div>
      </div>
      <div>
        <ShowCuentas />
      </div>
    </div>
  );
}

export default Cuentas;
