#!/bin/bash

echo "🛑 Arresto del container Docker MySQL..."

docker-compose down
if [ $? -eq 0 ]; then
    echo "✅ Container MySQL fermato correttamente."
else
    echo "❌ Errore nell'arresto del container Docker."
fi