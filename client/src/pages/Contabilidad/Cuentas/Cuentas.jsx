import { useState } from "react";
import Breadcrumb from "@/components/Breadcrumb/Breadcrumb";
import { Toaster } from "react-hot-toast";
import { ButtonIcon } from "@/components/Buttons/Buttons";
import { FaPlus } from "react-icons/fa";
import BarraSearch from "@/components/Search/Search";

function Cuentas() {
  const [activeAdd, setModalOpen] = useState(false);
  const handleModalAdd = () => {
    setModalOpen(!activeAdd);
  };

  const [searchTerm, setSearchTerm] = useState("");

  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleClearSearch = () => {
    setSearchTerm(""); 
  };

  return (
    <div>
      <Toaster />
      <Breadcrumb
        paths={[
          { name: "Inicio", href: "/inicio" },
          { name: "Contabilidad", href: "/contabilidad" },
          { name: "Cuentas", href: "/contabilidad/cuentas" },
        ]}
      />
      <hr className="mb-4" />
      <h1 className="font-extrabold text-4xl">Plan general contable empresarial</h1>
      <div className="flex justify-between mt-5 mb-4 items-center">
        <div
          id="barcode-scanner"
          hidden
          style={{ width: "100%", height: "400px" }}
        ></div>
        <h6 className="font-bold">Listado de cuentas</h6>
        {/* <div className="flex items-center gap-4 ml-auto">
          <div className="relative">
            <BarraSearch
              value={searchTerm}
              onChange={handleSearchChange}
              placeholder="Ingrese la marca a buscar"
              isClearable={true}
              onClear={handleClearSearch} 
            />
          </div>
        
        </div> */}
      </div>
      <div>
      </div>
     
    </div>
  );
}

export default Cuentas;