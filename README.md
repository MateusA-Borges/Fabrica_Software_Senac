# Fabrica_Software_Senac

Monitoramento e controle de acesso automatizados via detecção facial em imagens de câmeras de segurança.

### Como usar

Construir a imagem (Docker vai requerer a especificação do arquivo: `-f Containerfile`):
```
podman build -t fs-senac .
```

Iniciar o container (interativo):
```
podman run --rm -it \
    --name fs-senac \
    --device /dev/video0:/dev/video0 \
    --shm-size=8g \
    --network host \
    -v "$PWD":/workspace \
    -v "$HOME/.cache/huggingface":/root/.cache/huggingface \
    fs-senac bash
```

E dentro do container:
```
uv run python "${SEU_SCRIPT}.py"
```
