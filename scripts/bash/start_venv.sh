#!/bin/bash

echo "🚀 Avvio dell'ambiente virtuale..."

if [ -d ".venv" ]; then
    source .venv/bin/activate
    if [ $? -eq 0 ]; then
        echo "✅ Ambiente virtuale attivato correttamente."
    else
        echo "❌ Errore nell'attivazione dell'ambiente virtuale."
    fi
else
    echo "❌ La cartella .venv non esiste. Crea prima l'ambiente virtuale con: python -m venv .venv"
fi