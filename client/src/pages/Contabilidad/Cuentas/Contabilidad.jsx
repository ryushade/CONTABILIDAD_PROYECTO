import { useState } from 'react';
import Breadcrumb from '@/components/Breadcrumb/Breadcrumb';
import { Toaster } from "react-hot-toast";
import { IoIosSearch } from "react-icons/io";
import { Select, SelectItem } from "@nextui-org/react";
import { MdOutlineHelpOutline } from "react-icons/md";


function Cuentas() {
    // Estado de Modal de Agregar Producto
    const [activeAdd, setModalOpen] = useState(false);
    const handleModalAdd = () => {
        setModalOpen(!activeAdd);
    };

    // Input de búsqueda de productos
    const [searchTerm, setSearchTerm] = useState('');
    const handleSearchChange = (e) => {
        setSearchTerm(e.target.value);
    };

    return (
        <div className="p-4">
            <Toaster />
            <Breadcrumb
                paths={[
                    { name: "Inicio", href: "/inicio" },
                    { name: "Contabilidad", href: "/contabilidad" },
                ]}
            />
            <hr className="my-4" />
            <h1 className='font-extrabold text-3xl mb-4'>Módulo de contabilidad</h1>

            <div className="flex flex-col md:flex-row justify-between items-justified mb-6 space-y-4 md:space-y-0">
                <p
                    className="text-small text-default-400"
                    style={{
                        fontSize: "14px",
                        pointerEvents: "none",
                        userSelect: "none",

                    }}
                >
                    Este módulo permite gestionar de manera eficiente los asientos contables, el libro diario y mayor, así como el listado de cuentas del PCGE.                 </p>
                <div className="flex flex-col md:flex-row justify-between items-center mb-4 space-y-2 md:space-y-0">
                    <MdOutlineHelpOutline 
                    style={{marginRight:"5px", color:"green"}}/>
                    <p style={{ fontSize: "12px", color: "green" , cursor:"pointer"}}>Ayuda

                    </p>
                </div>

            </div>

            <div>
            </div>

        </div>
    );
}

export default Cuentas;
