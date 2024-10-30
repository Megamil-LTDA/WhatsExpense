## Ambiente local virtual:
```bash
$ python3 -m venv local_modules
# Para ativar
$ source local_modules/bin/activate
# Para desativar
$ deactivate
```

## Dependências:
```bash
pip install -r requirements.txt
```

```bash
# Executar sem criar arquivos de cache
$ python3 -B app.py
# Limpar cache se preciso
$ find . -type d -name __pycache__ -exec rm -r {} +
```