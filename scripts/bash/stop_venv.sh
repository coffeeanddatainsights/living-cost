#!/bin/bash

echo "🛑 Disattivazione dell'ambiente virtuale..."

if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
    if [ $? -eq 0 ]; then
        echo "✅ Ambiente virtuale disattivato correttamente."
    else
        echo "❌ Errore nella disattivazione dell'ambiente virtuale."
    fi
else
    echo "⚠️ Nessun ambiente virtuale attivo."
fi