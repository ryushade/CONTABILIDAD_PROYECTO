
export function ShowMarcas({  }) {
  

 

  return (
    <div>
      <div className="overflow-x-auto shadow-md sm:rounded-lg">
        <table className="w-full text-sm table-auto divide-gray-200 rounded-lg">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-xs font-bold text-gray-500 uppercase text-center">
                NOMBRE
              </th>
              <th className="px-6 py-3 text-xs font-bold text-gray-500 uppercase text-center">
                DESCRIPCION
              </th>
              
            </tr>
          </thead>
          <tbody className="bg-white divide-gray-200">
            
          </tbody>
        </table>
      </div>

      {/* Paginación */}
      <div className="flex justify-end mt-4">
      </div>

      
    </div>
  );
}

export default ShowMarcas;
