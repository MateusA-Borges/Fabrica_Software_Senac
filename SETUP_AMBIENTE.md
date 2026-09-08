# Setup do ambiente de execução

## Decisão do projeto
Para esta etapa, o ambiente oficial será o **Dev Container** já versionado em `.devcontainer/devcontainer.json`.

Com isso, ficamos com **uma única fonte de configuração** do ambiente no repositório, evitando manter configurações duplicadas em paralelo.

## Pré-requisitos
- Docker Desktop (Windows/macOS) ou Docker Engine (Linux)
- VS Code
- Extensão **Dev Containers** (`ms-vscode-remote.remote-containers`)

## Subindo o ambiente
1. Clone o repositório.
2. (Opcional) Crie `.devcontainer/.env` a partir de `.devcontainer/.env.example`.
3. Abra a pasta do projeto no VS Code.
4. Execute `Dev Containers: Reopen in Container`.

## Validação inicial do backend (câmera)
Com o container já aberto:

1. Entre na pasta do backend:
   ```bash
   cd pi-iii-backend
   ```
2. Rode o script de teste:
   ```bash
   python test.py
   ```
3. Valide no terminal as mensagens `Saved image ...` e os arquivos `output_cam_image_*.jpg` gerados.

> Update registrado na issue: `Containerfile` executando `pi-iii-backend/test.py` com webcam.

## Execução da API para integração com frontend
No container:

```bash
cd pi-iii-backend
python server.py
```

Endpoints úteis:
- `http://localhost:8000/health`
- `http://localhost:8000/video_feed`
- WebSocket: `ws://localhost:8000/ws/logs`
