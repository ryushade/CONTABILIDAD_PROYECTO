import { Card, Text } from "@tremor/react"
import { FaFileAlt} from "react-icons/fa"

const reports = [
  {
    title: "Asientos contables",
    description: "Conoce las entradas y salidas de tu empresa.",
    icon: "file-alt"
  },
  {
    title: "Estados financieros",
    description: "Obtén una visión completa de la situación financiera y el rendimiento de tu empresa.",
    icon: "file-alt"
  },
  {
    title: "Cuentas del PCGE",
    description: "Consulta todas las cuentas del PCGE distribuidas por categoria.",
    icon: "file-alt"
  },
  {
    title: "Movimientos por cuenta contable",
    description: "Conoce la actividad de tus cuentas y sus movimientos asociados.",
    icon: "file-alt"
  },
  {
    title: "Libro diario",
    description: "Gestiona el movimiento contable de tus transacciones registradas.",
    icon: "file-alt"
  },
  {
    title: "Libro mayor",
    description: "Gestiona el movimiento contable de tus transacciones registradas de forma cronológica.",
    icon: "file-alt"
  },
  {
    title: "Balance de situacion",
    description: "Consulta el saldo acumulado y los movimientos de tus cuentas.",
    icon: "file-alt"
  },
  {
    title: "Estado de resultados",
    description: "Consulta los movimientos de tus cuentas detalladamente.",
    icon: "excel"
  },
]

export default function Dashboard() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 p-4">
      {reports.map((report, index) => (
        <Card 
          key={index} 
          className="relative overflow-hidden hover:shadow-lg transition-shadow duration-300 animate-tremor"
        >
          <div className="absolute top-2 right-2">
          </div>
          <div className="flex items-center space-x-4">
            <div className="bg-yellow-100 p-3 rounded-full">
              {report.icon === 'excel' ? (
                // Puedes elegir un ícono de Excel si lo deseas
                <FaFileAlt className="h-6 w-6 text-green-600" />
              ) : (
                <FaFileAlt className="h-6 w-6 text-yellow-600" />
              )}
            </div>
            <div>
              <Text className="font-medium">{report.title}</Text>
              <Text className="text-sm text-gray-500">{report.description}</Text>
            </div>
          </div>
        </Card>
      ))}
    </div>
  )
}
