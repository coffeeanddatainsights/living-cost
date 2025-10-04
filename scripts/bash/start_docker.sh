#!/bin/bash

echo "🚀 Avvio del container Docker MySQL..."

docker-compose up -d
if [ $? -eq 0 ]; then
    echo "✅ Container MySQL avviato correttamente."
    docker ps | grep mysql
else
    echo "❌ Errore nell'avvio del container Docker."
fi