# Python Development - pyproject.toml

Template moderno de `pyproject.toml` para proyectos Python 3.9+.

## Características

### Build System
- **PEP 517/518/621** compliant
- `setuptools >= 61.0` como backend

### Herramientas Configuradas

#### Linting & Formatting
- **Black**: formatter (line-length=100)
- **Ruff**: linter moderno (reemplazo de flake8)
- **isort**: sorting de imports
- **mypy**: type checking

#### Testing
- **pytest**: framework de testing
- **coverage**: code coverage con reports HTML/XML/terminal

### Optional Dependencies

```toml
[project.optional-dependencies]
dev = ["pytest", "black", "mypy", ...]  # desarrollo
docs = ["sphinx", ...]                   # documentación
```

## Ubicación

- **NO se instala automáticamente** - es un template
- **Módulo**: `modules/dev-tools/python/`

## Uso

### Copiar a tu proyecto

```bash
cp modules/dev-tools/python/pyproject.toml ~/mi-proyecto/
```

### Editar campos requeridos

1. `name` - nombre del proyecto
2. `version` - versión inicial
3. `description` - descripción
4. `authors` - tu info
5. `dependencies` - dependencias del proyecto

### Instalar en modo desarrollo

```bash
cd ~/mi-proyecto
pip install -e ".[dev]"  # con dependencias de desarrollo
```

## Comandos Útiles

### Formatting

```bash
black src/
isort src/
```

### Linting

```bash
ruff check src/
mypy src/
```

### Testing

```bash
pytest                    # tests
pytest --cov              # con coverage
pytest -v                 # verbose
```

### Build

```bash
pip install build
python -m build           # crea wheel y sdist
```

## Estructura de Proyecto Recomendada

```
mi-proyecto/
├── pyproject.toml        # este archivo
├── README.md
├── src/
│   └── mi_paquete/
│       ├── __init__.py
│       └── modulo.py
├── tests/
│   ├── __init__.py
│   └── test_modulo.py
└── docs/
    └── index.md
```

## Notas

- Python 3.9+ requerido
- Compatible con venv, poetry, conda
- Tools modernos (ruff) preferidos sobre legacy (flake8)
- Coverage configurado para omitir tests de sí mismos
