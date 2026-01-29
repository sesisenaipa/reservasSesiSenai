#!/bin/bash

echo "⏳ Aguardando ngrok iniciar..."
sleep 3

NGROK_URL=$(curl -s http://localhost:4040/api/tunnels \
  | grep -oP '"public_url":"\Khttps:[^"]+')

if [ -z "$NGROK_URL" ]; then
  echo "❌ Não foi possível obter o link do ngrok"
  exit 1
fi

echo "✅ Link do ngrok: $NGROK_URL"

cat > ngrok-url.json <<EOF
{
  "url": "$NGROK_URL"
}
EOF

git add ngrok-url.json
git commit -m "Atualiza link ngrok automaticamente"
git push origin main

echo "🚀 Site atualizado com sucesso!"
