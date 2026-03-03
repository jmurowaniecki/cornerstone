# 📘 Makefile — Estrutura e Funcionamento

Este [Makefile](../Makefile) atua como interface de orquestração do repositório, oferecendo comandos padronizados para manutenção, execução e automação.

Ele foi projetado com interface declarativa, ajuda dinâmica, parametrização opcional, suporte a targets genéricos e organização sem acoplamento direto à stack.

Veja abaixo uma representação da execução do comando `make` sem parâmetros.
```bash
❯ make
 
λ::Makefile

For further information see `README.md`.

Repository maintenance options:

	install    Installs application.
	targets    Show target list.
	available  Show available commands.
	clean      Clean generated, temporary and working folders.

	run-%      Perform command targeting a wildcard.

	help       Shows this help.
```

## 🔧 As partes do Makefile

Variáveis Globais

### TODAY
```Makefile
TODAY  ?= $(shell date +'%Y%m%d%H%M%S')
```
Define a data atual no formato YYYYMMDDHHMMSS.

Usa `?=` para permitir override externo e pode ser utilizada para versionamento, logs ou geração automática de artefatos.

### WARNING
```Makefile
WARNING = Automatically generated on $(TODAY)
```
Mensagem padrão indicando geração automática de conteúdo.

Pode ser utilizada em arquivos produzidos por automações.

### DESTDIR / TARGET
```Makefile
ifneq (,$(DESTDIR))
TARGET =$(DESTDIR)
endif
```
Se DESTDIR for definido externamente `make build DESTDIR=/tmp/output` então TARGET passa a assumir esse valor.

Esse padrão é tradicional em sistemas de build que suportam instalação customizada ou necessidades arquiteturais específicas.

### SOURCE
```Makefile
SOURCE = source_file_or_folder
```
Define a origem principal do projeto.

Pode representar:
- Arquivo principal
- Pasta base
- Artefato inicial

### RULES
```Makefile
RULES = rule  \
		set   \
		about \
		your  \
		project
```
Lista declarativa de regras ou componentes do projeto.

Essa estrutura facilita expansão modular.

### FILES
```Makefile
FILES = $(RULES) \
		$(SOURCE)
```
Agrega regras e fonte principal.

Cria um conjunto consolidado para iteração posterior.

### TARGETS
```Makefile
TARGETS = $(foreach \
		destiny, \
		$(FILES), \
		$(wildcard $(TARGET)/$(destiny)))
```
Percorre cada item de FILES e verifica se existe no TARGET. Itera sobre FILES, aplica wildcard e retorna apenas os que existem. Esse tipo de recurso é útil para validações condicionais e builds incrementais.

### AVAILABLE_COMMANDS
```Makefile
AVAILABLE_COMMANDS = \
	build \
	lint \
	fix \
	dev \
	start
```
Lista declarativa de comandos suportados usada pelo target available para exibição dinâmica.

Essa abordagem permite documentação centralizada, expansão organizada e clareza sobre a interface pública do Makefile.

### 🎨 Controle de Estilo (Terminal)
```Makefile
 BOLD = \e[1m
/BOLD = \e[0m
```
Define códigos ANSI para ativar negrito e resetar formatação, utilizado principalmente no target help e em `make run-…` para destacar elementos no terminal.

### 🎯 Comportamento Padrão
```Makefile
.DEFAULT_GOAL := help
 DEFAULT      :  help
```
Define help como comando padrão.

Se o usuário executar apenas `make`, o help será exibido automaticamente.



## 🛠 Targets principais

Perceba que os targets `install`, `available` e `clean` possuem comentários e que serão estes exibidos pela execução do target `help`.

```Makefile
# Repository maintenance options:
#
install:	# Installs application.
		@\
		echo "Installing application…"

available:	# Show available commands.
		@\
		echo "$(AVAILABLE_COMMANDS)"

clean:	# Clean generated, temporary and working folders.
		@\
		echo "Cleaning generated folders…"

```



## 🔁 Target Dinâmico: run-%

Comandos utilizando targets dinâmicos podem automatizar pipelines mantendo granularidade e especificidade ao mesmo tempo que flexibiliza a execução de múltiplos targets em um único comando. 

```Makefile
run-%:
		@\
		wildcard="$(*)"; \
		echo "Do something with $(BOLD)$${wildcard}$(/BOLD)"
```
Permite execução parametrizada:
```bash
make run-api
make run-tests
```

O sufixo após `run-…` é capturado como wildcard/coringa, isso cria extensibilidade sem necessidade de declarar múltiplos targets.

## 📚 Help Dinâmico

Este é o componente mais sofisticado do Makefile.

Elê o próprio Makefile `$(MAKEFILE_LIST)`, extrai comentários após `#`, aplicando formatação com ANSI e exibindo os comandos documentados dinamicamente.

Benefícios:
- Evita duplicação de documentação;
- Mantém help sincronizado com targets;
- Permite comentários como fonte única de verdade;
- Esse padrão reduz divergência entre código e documentação.

## 🧩 Target Genérico Final

```Makefile
%:
		@:
```

Define um fallback silencioso. Se um target não existir explicitamente não gera erro, não executa nada e permite expansão futura.

Funciona como absorvedor de chamadas não mapeadas.

🧠 Filosofia Estrutural

Este Makefile foi projetado como interface estável, orquestrador genérico e base para crescimento modular independente de stack específica. Privilegiando parametrização, extensibilidade, facilitando o uso de documentação embutida e flexibilidade operacional.
