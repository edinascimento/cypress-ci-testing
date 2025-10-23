#!/bin/bash

# Script para executar testes Cypress
# Usado pelo Docker no Jenkins

set -e  # Exit se qualquer comando falhar

echo "📦 Instalando dependências..."
npm ci

echo "🧪 Executando testes Cypress..."
npm run test:ci

echo "✅ Testes completados!"